# the instance
resource "google_compute_instance" "nomad-node" {
  count = "${var.nb_nodes}"
  name = "${var.cluster_name}-${count.index+1}"
  machine_type = "${var.gce_machine_type}"
  zone = "${var.gce_zone}"

  disk {
    image = "${var.gce_image}"
    type = "pd-ssd"
  }

  # network interface
  network_interface {
    network = "${google_compute_network.nomad-net.name}"
    access_config {
      // ephemeral address
    }
  }

  # nomad version
  metadata {
    nomad_version = "${var.nomad_version}"
  }

  # define default connection for remote provisioners
  connection {
    user = "${var.gce_ssh_user}"
    key_file = "${var.gce_ssh_private_key_file}"
    agent = "false"
  }

  # copy files
  provisioner "file" {
    source = "resources/server.hcl"
    destination = "/home/${var.gce_ssh_user}/server.hcl"
  }

}

resource "google_compute_network" "nomad-net" {
  name = "${var.cluster_name}-net"
  ipv4_range ="${var.network}"
}

resource "google_compute_firewall" "nomad-ssh" {
  name = "${var.cluster_name}-nomad-ssh"
  network = "${google_compute_network.nomad-net.name}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "nomad-internal" {
  name = "${var.cluster_name}-nomad-internal"
  network = "${google_compute_network.nomad-net.name}"

  allow {
    protocol = "tcp"
    ports = ["1-65535"]
  }
  allow {
    protocol = "udp"
    ports = ["1-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["${google_compute_network.nomad-net.ipv4_range}","${var.localaddress}"]

}

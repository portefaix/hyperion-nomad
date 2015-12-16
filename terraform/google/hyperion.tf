resource "google_compute_network" "nomad-network" {
  name = "hyperion-network"
  ipv4_range ="${var.network}"
}

# Firewall
resource "google_compute_firewall" "hyperion-firewall-external" {
  name = "hyperion-firewall-external"
  network = "${google_compute_network.hyperion-network.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [
      "22",   # SSH
      "80",   # HTTP
      "443",  # HTTPS
      "4647", # Nomad API
      "4648", # Serf
    ]
  }

}

resource "google_compute_firewall" "hyperion-firewall-internal" {
  name = "hyperion-firewall-internal"
  network = "${google_compute_network.hyperion-network.name}"
  source_ranges = ["${google_compute_network.hyperion-network.ipv4_range}"]

  allow {
    protocol = "tcp"
    ports = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports = ["1-65535"]
  }
}


resource "google_compute_instance" "nomad-nodes" {
  count = "${var.nb_nodes}"
  zone = "${var.gce_zone}"
  name = "${var.cluster_name}-node-${count.index}" // => `xxx-node-{0,1,2}`
  description = "Nomad node ${count.index}"
  machine_type = "${var.gce_machine_type}"

  disk {
    image = "${var.gce_image}"
    auto_delete = true
  }
  metadata {
    sshKeys = "${var.gce_ssh_user}:${file("${var.gce_ssh_public_key}")}"
  }
  network_interface {
    network = "${google_compute_network.nomad-network.name}"
    access_config {
      // ephemeral ip
    }
  }
  connection {
    user = "${var.gce_ssh_user}"
    key_file = "${var.gce_ssh_private_key_file}"
    agent = false
  }

  provisioner "file" {
    source = "resources/server.hcl"
    destination = "/home/${var.gce_ssh_user}/server.hcl"
  }

}


# resource "google_compute_instance" "nomad-node" {
#   count = "${var.nb_nodes}"
#   name = "${var.cluster_name}-node-${count.index}" // => `xxx-node-{0,1,2}`
#   machine_type = "${var.gce_machine_type}"
#   zone = "${var.gce_zone}"

#   tags {
#     Name = "${var.cluster_name}-node-${count.index}"
#   }

#   disk {
#     image = "${var.gce_image}"
#     # type = "pd-ssd"
#     auto_delete = true
#   }

#   metadata {
#     sshKeys = "${var.gce_ssh_user}:${file("${var.gce_ssh_public_key}")}"
#   }

#   network_interface {
#     network = "${google_compute_network.nomad-network.name}"
#     access_config {
#       // ephemeral address
#     }
#   }

#   connection {
#     user = "${var.gce_ssh_user}"
#     key_file = "${var.gce_ssh_private_key_file}"
#     agent = "false"
#   }

#   provisioner "file" {
#     source = "resources/server.hcl"
#     destination = "/home/${var.gce_ssh_user}/server.hcl"
#   }

# }

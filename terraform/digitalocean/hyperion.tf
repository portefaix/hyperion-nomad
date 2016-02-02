resource "digitalocean_ssh_key" "hyperion-ssh-key" {
   name = "${var.cluster_name}-ssh-key"
   public_key = "${file("${var.do_pub_key}")}"
}

resource "digitalocean_droplet" "hyperion-nodes" {
  count = "${var.nb_nodes}"
  name = "${var.cluster_name}-node-${count.index}" // => `hyperion-node-{0,1,...}`
  region = "${var.do_region}"
  image = "${var.do_image}"
  size = "${var.do_size_master}"
  private_networking = true
  ssh_keys = ["${var.do_ssh_fingerprint}"]
  depends_on = [ "digitalocean_ssh_key.hyperion-ssh-key" ]

  connection {
    key_file = "${var.do_pvt_key}"
    agent = false
  }

  provisioner "remote-exec" {
    inline = <<CMD
cat > /etc/nomad/config.d/server.hcl <<EOF
datacenter = "${var.do_region}"
data_dir = "/var/lib/nomad"
bind_addr = "${self.ipv4_address}"
server {
  enabled = true
  bootstrap_expect = 3
}
EOF
CMD
  }

  provisioner "remote-exec" {
    inline = "sudo start nomad || sudo restart nomad"
  }

  # resource "null_resource" "bootstrap_cluster" {
  #   provisioner "remote-exec" {
  #     inline = "nomad server-join -address='http://${digitalocean_droplet.hyperion-nodes.0.ipv4_address}:4646' ${digitalocean_droplet.hyperion-nodes.1.ipv4_address} ${digitalocean_droplet.hyperion-nodes.2.ipv4_address}"
  #     connection = {
  #       user = "root"
  #       host = "${digitalocean_droplet.hyperion-nodes.0.ipv4_address}"
  #     }
  #   }
  # }

}

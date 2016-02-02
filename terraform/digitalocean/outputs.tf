output "hyperion_nodes" {
  value = "${join(" - ", digitalocean_droplet.hyperion-nodes.*.ipv4_address)}"
}

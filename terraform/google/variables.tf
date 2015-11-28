variable "gce_credentials" {
  description = "Path to the JSON file used to describe your account credentials, downloaded from Google Cloud Console."
}

variable "gce_project" {
  description = "The name of the project to apply any resources to."
}

variable "gce_ssh_user" {
  description = "SSH user."
}

variable "gce_ssh_public_key" {
  description = "Path to the ssh key to use"
}

variable "gce_ssh_private_key_file" {
  description = "Path to the SSH private key file."
}

variable "gce_region" {
  description = "The region to operate under."
  default = "us-central1"
}

variable "gce_zone" {
  description = "The zone that the machines should be created in."
  default = "us-central1-a"
}

variable "gce_image" {
  description = "The name of the image to base the launched instances."
  default = "hyperion-nomad-0-8-2-v20150904"
}

variable "gce_machine_type" {
  description = "The machine type to use for the hyperion master ."
  default = "n1-standard-1"
}

# the address of the subnet in CIDR
variable "network" {
    default = "10.33.23.0/24"
}

# public local address for unlimited access to the cluster, in CIDR
variable "localaddress" {
  default = "0.0.0.0"
}

variable "cluster_name" {
  default = "portefaix-nomad"
}

variable "nb_nodes" {
  description = "The number of nodes."
  default = "2"
}

variable "nomad_version" {
  default = "0.2.0"
}

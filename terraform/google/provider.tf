provider "google" {
  account_file = "${file("${var.gce_credentials}")}"
  project = "${var.gce_project}"
  region = "${var.gce_region}"
}

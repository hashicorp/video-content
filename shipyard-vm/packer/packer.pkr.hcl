variable "project" {
  type    = string
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

source "googlecompute" "shipyard" {
  project_id = var.project
  zone = var.zone

  source_image_family = "ubuntu-1910"
  image_name = "shipyard"

  disk_size = 100
  tags = ["shipyard"]

  ssh_username = "root"
}

build {
  sources = [
    "source.googlecompute.shipyard"
  ]

  provisioner "file" {
    source = "resources"
    destination = "/tmp/resources"
  }

  provisioner "shell" {
    script = "bootstrap.sh"
  }
}
resource "google_compute_instance" "default" {
  name         = "shipyard-${random_id.id.hex}"
  machine_type = var.machine
  zone         = var.zone

  tags = ["shipyard", random_id.id.hex]

  boot_disk {
    initialize_params {
      image = "shipyard"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata_startup_script = <<EOF
    users=(${join(" ", var.users)})
    for user in $${users[@]}; do
      sudo usermod -aG docker $user
    done
  EOF

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
resource "google_compute_firewall" "shipyard" {
  name    = "shipyard-${random_id.id.hex}"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  target_tags   = ["shipyard", random_id.id.hex]
  source_ranges = var.allowlist
}
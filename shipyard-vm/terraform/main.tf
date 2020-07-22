provider "google" {
  project = var.project
  region  = var.region
}

resource "random_id" "id" {
  byte_length = 8
}
variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "machine" {
  type    = string
  default = "n1-standard-4"
}

variable "users" {
  type = list(string)
}

variable "allowlist" {
  type = list(string)
}
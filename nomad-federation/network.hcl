network "dc1" {
  subnet = "10.10.0.0/16"
}

network "dc2" {
  subnet = "10.5.0.0/16"
}

network "wan" {
  subnet = "192.168.0.0/16"
}
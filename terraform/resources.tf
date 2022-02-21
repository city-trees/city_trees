resource "hcloud_ssh_key" "default" {
  for_each = var.ssh_keys

  name       = each.key
  public_key = each.value
}

resource "hcloud_network" "network" {
  name     = "network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

data "template_file" "user_data" {
  template = file("./cloud-init/setup-server.yaml")
}

resource "hcloud_server" "server" {
  name        = "server1"
  server_type = "cpx11"
  image       = "ubuntu-20.04"
  location    = "nbg1"
  ssh_keys    = keys(var.ssh_keys)
  user_data   = data.template_file.user_data.rendered
  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.5"
  }
  
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

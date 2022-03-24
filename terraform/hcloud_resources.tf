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

resource "hcloud_firewall" "server_firewall" {
  name = "server_firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "2211"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "4000"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ] 
  }
}

resource "hcloud_server" "city_trees_dev" {
  name        = "server1"
  server_type = "cpx11"
  image       = "ubuntu-20.04"
  location    = "nbg1"
  ssh_keys    = keys(var.ssh_keys)
  firewall_ids = [
    hcloud_firewall.server_firewall.id
  ]
  user_data   = data.template_file.user_data.rendered
  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.5"
  }
  
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_server" "city_trees_prod" {
  name        = "server1"
  server_type = "cpx11"
  image       = "ubuntu-20.04"
  location    = "nbg1"
  ssh_keys    = keys(var.ssh_keys)
  firewall_ids = [
    hcloud_firewall.server_firewall.id
  ]
  user_data   = data.template_file.user_data.rendered
  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.6"
  }
  
  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}
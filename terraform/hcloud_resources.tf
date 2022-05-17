locals {
  labels = {
    "env" = "${terraform.workspace}"
    "project" = "city_trees"
  }
}

resource "hcloud_network" "default" {
  name     = "network-${terraform.workspace}"
  ip_range = "10.0.0.0/16"
 
}

resource "hcloud_network_subnet" "default" {
  type         = "cloud"
  network_id   = hcloud_network.default.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_ssh_key" "deploy_ssh_key" {
  name       = "deploy_${terraform.workspace}"
  labels     = local.labels
  public_key = file("../.ssh/deploy_${terraform.workspace}.pub")
}

data "template_file" "user_data" {
  for_each  = var.app_servers
  template  = file("./cloud-init/setup-server.yaml")
   vars     = {
    ssh_authorized_keys = "- ${hcloud_ssh_key.deploy_ssh_key.public_key}"
    floating_ip = "${hcloud_floating_ip.app_server_ip[each.key].ip_address}"
  }
}

resource "hcloud_firewall" "default" {
  name   = "server_firewall-${terraform.workspace}"
  labels = local.labels
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
    direction   = "in"
    protocol    = "tcp"
    port        = "2096"
    source_ips  = [
      "0.0.0.0/0",
      "::/0"
    ] 
  }
}

resource "hcloud_server" "app_server" {
  for_each     = var.app_servers
  name         = "city-trees-${terraform.workspace}-${each.key}"
  server_type  = "cpx11"
  image        = "ubuntu-22.04"
  location     = each.value.location
  labels       = local.labels
  backups      = true
  ssh_keys     = [
    hcloud_ssh_key.deploy_ssh_key.id
  ]
  firewall_ids = [
    hcloud_firewall.default.id
  ]
  user_data   = data.template_file.user_data[each.key].rendered
  network {
    network_id = hcloud_network.default.id
    ip         = each.value.ip
  }
  depends_on = [
    hcloud_network_subnet.default
  ]
}

resource "hcloud_floating_ip" "app_server_ip" {
  type          = "ipv4"
  name          = "app-server-ip-${terraform.workspace}-${each.key}"
  home_location = each.value.location
  for_each      = var.app_servers
  labels        = local.labels
}

resource "hcloud_floating_ip_assignment" "app_server_assignment" {
  for_each        = var.app_servers
  floating_ip_id  = hcloud_floating_ip.app_server_ip[each.key].id
  server_id       = hcloud_server.app_server[each.key].id
}


output "server_apps" {
  value = [
    for k, s in hcloud_server.app_server : {
      internal_ip: s.ipv4_address,
      floating_ip: hcloud_floating_ip.app_server_ip[k].ip_address,
      id: s.id
      labels: s.labels
    }
  ]
}

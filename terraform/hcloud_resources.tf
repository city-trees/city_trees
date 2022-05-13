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
  name       = "SSH deploy ssh-key"
  labels     = local.labels
  public_key = file("../.ssh/deploy_${terraform.workspace}.pub")
}

data "template_file" "user_data" {
  template = file("./cloud-init/setup-server.yaml")
   vars = {
    ssh_authorized_keys = "- ${hcloud_ssh_key.deploy_ssh_key.public_key}"
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
  name         = "server-${terraform.workspace}-${each.key}"
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
  user_data   = data.template_file.user_data.rendered
  network {
    network_id = hcloud_network.default.id
    ip         = each.value.ip
  }
  depends_on = [
    hcloud_network_subnet.default
  ]
}

resource "hcloud_volume" "minio_server_volume" {
  for_each          = var.minio_servers
  labels            = local.labels
  delete_protection = true
  name              = "server_volume_${terraform.workspace}_${each.key}"
  size              = var.minio_disk_size
  location          = each.value.location
  format            = "xfs"
}

resource "hcloud_volume_attachment" "minio_server_volume" {
  for_each  = var.minio_servers
  volume_id = hcloud_volume.minio_server_volume[each.key].id
  server_id = hcloud_server.minio_server[each.key].id
  automount = true
}

resource "hcloud_server" "minio_server" {
  for_each    = var.minio_servers
  name        = "server-${terraform.workspace}-${each.key}"
  server_type = "cpx11"
  image       = "ubuntu-22.04"
  location    = each.value.location
  labels      = local.labels
  backups     = true
  ssh_keys    = [
    hcloud_ssh_key.deploy_ssh_key.id
  ]
  firewall_ids = [
    hcloud_firewall.default.id
  ]
  user_data   = data.template_file.user_data.rendered
  network {
    network_id = hcloud_network.default.id
    ip         = each.value.ip
  }
  depends_on = [
    hcloud_network_subnet.default
  ]
}


output "minio_volumes" {
  value = [
    for s in hcloud_volume_attachment.minio_server_volume : {
      server_id: s.server_id, 
      volume_id: s.volume_id,
    }
  ]
}

output "minio_ip_addr" {
  value = [
    for s in hcloud_server.minio_server : {
      ip: s.ipv4_address, 
      id: s.id,
    }
  ]
}
output "app_ip_addr" {
  value = [
    for s in hcloud_server.app_server : {
      ip: s.ipv4_address,
      id: s.id
    }
  ]
}

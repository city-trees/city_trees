terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.33"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    hashicorp = {
      source = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
  }
  backend "local" {
    workspace_dir  = "state"
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

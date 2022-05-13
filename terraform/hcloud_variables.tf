variable "hcloud_token" {
  description = "API Key access of hetzer account"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "app_servers" {
  default = {
    "app1": {ip: "10.0.1.5", location: "nbg1"}
  }
}
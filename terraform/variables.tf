variable "cloudflare_email" {
  description = "Email adress of cloudflare account"
  type        = string
  sensitive   = true
  nullable    = true
}
variable "cloudflare_api_key" {
  description = "API Key to access cloudflare account"
  type        = string
  sensitive   = true
  nullable    = true
}
variable "hcloud_token" {
  description = "API Key access of hetzer account"
  type        = string
  sensitive   = true
  nullable    = false
}
variable "ssh_keys" {
  description = "Map of SSH keys allowed to log in to server. Key is the name of user, value is the SSH public key"
}
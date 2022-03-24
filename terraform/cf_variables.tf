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
variable "city_trees_domain" {
  default = "city-trees.io"
}
variable "town_trees_domain" {
  default = "town-trees.com"
}


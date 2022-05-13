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
variable "minio_servers" {
  default = {
    "minio1": {ip: "10.0.1.20", location: "nbg1"},
    "minio2": {ip: "10.0.1.21", location: "fsn1"}
  }
}
variable "minio_disk_size" {
  type    = number
  default = 11
}
variable "minio_disk_count" {
  type    = number
  default = 4
}
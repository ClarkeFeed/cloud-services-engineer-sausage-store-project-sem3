variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
  description = "SSH public key"
}

variable "ssh_private_key" {
  type = string
  description = "SSH private key"
  sensitive = true
}
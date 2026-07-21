variable "env" {
  description = "The environment name (e.g., dev, staging, prod)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the security group."
  type        = string
}

variable "public_ip" {
  description = "The public IP address for SSH access."
  type        = list(string)
}
variable "env" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "igw_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to associate with the route table"
  type        = list(string)
}
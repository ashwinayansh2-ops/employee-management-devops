variable "env" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "enablePublicIP" {
  description = "Whether to enable public IP assignment for the subnets"
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "tag_name" {
  description = "A map of tags to assign to the subnets"
  type        = string

}

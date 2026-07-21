variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}


variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "db_username" {
  description = "The username for the database."
  type        = string
}

variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "The ID of the AMI to use for the backend server."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the backend server."
  type        = string
}


variable "instance_profile" {
  description = "The name of the IAM instance profile to associate with the backend server."
  type        = string
}


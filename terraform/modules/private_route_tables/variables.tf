variable "vpc_id" {
  description = "The ID of the VPC in which to create the private route table."
  type        = string
}

variable "nat_gateway_id" {
  description = "The ID of the NAT gateway to use for the private route table."
  type        = string
}

variable "private_app_subnet_ids" {
  description = "A list of private subnet IDs for the application tier."
  type        = list(string)
}

variable "private_db_subnet_ids" {
  description = "A list of private subnet IDs for the database tier."
  type        = list(string)
}
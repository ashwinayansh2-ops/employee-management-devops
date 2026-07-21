variable "private_db_subnet_ids" {
  description = "A list of private subnet IDs for the database tier."
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

variable "rds_sg_id" {
  description = "The ID of the security group to associate with the RDS instance."
  type        = string
}

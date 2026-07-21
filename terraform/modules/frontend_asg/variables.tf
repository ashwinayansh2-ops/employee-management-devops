variable "ami_id" {
  description = "The ID of the AMI to use for the backend server."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the backend server."
  type        = string
}
variable "frontend_sg_id" {
  description = "The ID of the security group for the backend server."
  type        = string  
}

variable "instance_profile" {
  description = "The name of the IAM instance profile to associate with the backend server."
  type        = string
}

variable "private_subnet1" {
  description = "The ID of the first private subnet for the backend server."
  type        = string
}

variable "private_subnet2" {
  description = "The ID of the second private subnet for the backend server."
  type        = string
}

variable "target_group_arn" {
  type = string
}
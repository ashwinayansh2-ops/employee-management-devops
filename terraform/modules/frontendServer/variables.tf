variable "ami_id" {
  description = "The ID of the AMI to use for the backend server."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the backend server."
  type        = string
}

variable "frontend_sg_id" {
  description = "The ID of the security group for the frontend server."
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets in which to launch the backend server."
  type        = list(string)
}

variable "instance_profile" {
  description = "The name of the IAM instance profile to associate with the backend server."
  type        = string
}

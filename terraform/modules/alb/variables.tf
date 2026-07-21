variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
}

variable "target_port" {
  description = "Target Port"
  type        = number
}

variable "target_protocol" {
  description = "Target Protocol"
  type        = string
  default     = "HTTP"
}

variable "instance_id" {
  description = "EC2 Instance ID"
  type        = list(string)
}
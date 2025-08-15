variable "project_name" {
  type = string
}


variable "alb_security_group_id" {
  description = "Security group ID for ALB from VPC module"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "certificate_arn" {
  description = "The arn of the certificate"
  type = string
  
}
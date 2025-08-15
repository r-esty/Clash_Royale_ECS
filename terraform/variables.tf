variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "romeoesty.com"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
}

variable "clash_royale_api_key" {
  description = "Clash Royale API key"
  type        = string
  sensitive   = true
}


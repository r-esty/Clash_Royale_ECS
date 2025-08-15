variable "project_name" {
 description = "Project name"
 type        = string
}



variable "aws_region" {
 description = "AWS region"
 type        = string
}

variable "execution_role_arn" {
 description = "ECS task execution role ARN from IAM module"
 type        = string
}

variable "task_role_arn" {
 description = "ECS task role ARN from IAM module"
 type        = string
}

variable "ecr_repository_url" {
 description = "ECR repository URL from ECR module"
 type        = string
}

variable "secret_arn" {
 description = "Secrets Manager ARN for API key"
 type        = string
}

variable "target_group_arn" {
 description = "Target group ARN from ALB module"
 type        = string
}

variable "ecs_security_group_id" {
 description = "Security group ID from VPC module"
 type        = string
}

variable "private_subnet_ids" {
 description = "Private subnet ids from the VPC module"
 type        = list(string)
}

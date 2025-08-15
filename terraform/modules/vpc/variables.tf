variable "vpc_cidr" {

    default = "10.0.0.0/16"
  
}

variable "project_name" {
    description = "name of the [roject used for tagging resources"
    type = string
}

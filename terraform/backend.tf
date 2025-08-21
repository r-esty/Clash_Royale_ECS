terraform {
  backend "s3" {
    bucket         = "clash-royale-tf-state"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "clash-royale-tf-locks"
    encrypt        = true
  }
}
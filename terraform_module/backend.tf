terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "ug-terraform-state-store"
    dynamodb_table = "ug-terraform-state-lock"
    key            = "vpc-terraform.tfstate"
    region         = "us-east-1"
  }
}
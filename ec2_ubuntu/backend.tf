terraform {
  backend "s3" {
    bucket = "ug-terraform-statestore"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
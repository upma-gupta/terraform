# main variables
variable "namespace" {
  description = "The project namespace for unique resource naming"
}
variable "region" {
  description = "AWS Region"
}

# vpc module
variable "vpc_cidr" {}
variable "azs" {}
variable "public_subnet_cidrs" {}
variable "web_subnet_cidrs" {}
variable "app_subnet_cidrs" {}
variable "db_subnet_cidrs" {}
variable "vpc_peer" {}

# ec2 module
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}




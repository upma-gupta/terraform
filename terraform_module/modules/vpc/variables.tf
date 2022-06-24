variable "namespace" {
  type = string
}
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list
}

variable "public_subnet_cidrs" {
  type = list
}

variable "vpc_peer" {}


variable "web_subnet_cidrs" {
  type = list
}

variable "app_subnet_cidr" {
  type = list
}

variable "db_subnet_cidr" {
  type = list
}
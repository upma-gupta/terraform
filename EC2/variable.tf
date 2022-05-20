variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIs" {
  type = map
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    ca-central-1 = "ami-03bcd79f25ca6b127"
    ap-southeast-1 = "ami-0f74c08b8b5effa56"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ugkey-tf.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "ugkey-tf"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
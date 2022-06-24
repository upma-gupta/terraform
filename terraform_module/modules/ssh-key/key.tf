# create ssh-key pair
# Firstly, create tls_private_key
# Secondly, create aws_key_pair
# Lastly, write the private key to a local file

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name = "${var.namespace}-${var.region}-key"
  public_key = tls_private_key.key.public_key_openssh
}

#resource "local_file" "private_key" {
#  filename = "${var.namespace}-${var.region}-key.pem"
#  sensitive_content = tls_private_key.key.private_key_pem
#  file_permission = "0400"
#}

resource "local_sensitive_file" "prv_key" {
  content = tls_private_key.key.private_key_pem
  filename = "${var.namespace}-${var.region}-key.pem"
}


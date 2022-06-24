resource "aws_security_group" "http" {
  name = "${var.namespace}-allow-http-sg"
  description = "Allow http traffic from anywhere"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.namespace}-allow-http-sg"
  }
  ingress [{
    description = "HTTP from anywhere"
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  },
  {
    description = "allow tomcat from anywhere"
    from_port = 8080
    protocol  = "tcp"
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "http" {
  name        = "${var.namespace}-allow-http-test-sg"
  description = "Allow http traffic from anywhere"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.namespace}-allow-http--test-sg"
  }
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "imp-test" {
        #.....configuration......
        name        = "allow_http"
        description = "allow_http"
        vpc_id      = var.vpc_id
        revoke_rules_on_delete = null
        tags = {}
}
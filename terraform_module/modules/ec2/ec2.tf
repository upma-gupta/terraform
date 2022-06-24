resource "aws_instance" "web_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id[0]
  key_name = var.key_name
  vpc_security_group_ids = [var.sg_name]
  user_data = file("./modules/ec2/userdata.sh")
  associate_public_ip_address = true


  tags = {
    Name = "${var.namespace}-web-server"
  }
}
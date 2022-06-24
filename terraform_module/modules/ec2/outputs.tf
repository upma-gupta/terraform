

output "web_server_instance_id" {
  value = aws_instance.web_server.id
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "web_server_private_ip" {
  value = aws_instance.web_server.private_ip
}
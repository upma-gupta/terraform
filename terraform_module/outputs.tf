output "vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_arn" {
  value = module.vpc.vpc_arn
}
output "igw" {
  value = module.vpc.igw
}
output "public_subnet_names" {
  value = module.vpc.public_subnet_name
}
output "web_server_instance_id" {
  value = module.ec2.web_server_instance_id
}
output "web_server_private_ip" {
  value = module.ec2.web_server_private_ip
}
output "web_server_url" {
  value = "http://${module.ec2.web_server_public_ip}:80"
}

output "allow_http_sg_name" {
  value = module.security_group.allow_http_sg_name
}
output "allow_http_sg_id" {
  value = module.security_group.allow_http_sg_id
}
output "ssh_key_pair_name" {
  value = module.ssh_key.key_name
}
output "vpc_id" {
  value = try(aws_vpc.vpc.id, "")
}
output "vpc_arn" {
  value = try(aws_vpc.vpc.arn, "")
}
output "public_subnet_name" {
  value = try(aws_subnet.public_subnet.*.id)
}
output "igw" {
  value = try(aws_internet_gateway.igw.id)
}
#VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.namespace}-vpc"
  }
}

# VPC Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.azs)
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.namespace}-public-subnet-0${count.index+1}"
  }
}
resource "aws_subnet" "web_subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.azs)
  cidr_block = element(var.web_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.namespace}-web-subnet-0${count.index+1}"
  }
}
resource "aws_subnet" "app_subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.azs)
  cidr_block = element(var.app_subnet_cidr,count.index)
  availability_zone = element(var.azs,count.index )
  tags = {
    Name = "${var.namespace}-app-subnet-0${count.index}+1"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.azs)
  cidr_block = element(var.db_subnet_cidr,count.index)
  availability_zone = element(var.azs,count.index )
  tags = {
    Name = "${var.namespace}-db-subnet-0${count.index}+1"
  }
}

# EIP
#resource "aws_eip" "eip" {
#  vpc = true
#  tags = {
#    Name = "${var.namespace}-nat-eip"
#  }
#}

# NAT Gateway
#resource "aws_nat_gateway" "nat-gw" {
#  subnet_id = aws_subnet.public_subnet.0.id
#  allocation_id = aws_eip.eip.id
#}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.namespace}-igw"
  }
}

# Route Table for public subnet
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.namespace}-public-rt"
  }
}

# Route Table for private subnet
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.namespace}-private-rt"
  }
}

# Add route to public route table
resource "aws_route" "public-rt-route" {
  route_table_id = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Add route to private route table
resource "aws_route" "private-rt-route" {
  route_table_id = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  #nat_gateway_id = aws_nat_gateway.nat-gw.id
  gateway_id = aws_internet_gateway.igw.id
  depends_on = [aws_nat_gateway.nat-gw, aws_route_table.private-rt]
}

# Public route table association
resource "aws_route_table_association" "public-subnet-asso" {
  count = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public-rt.id
  subnet_id = element(aws_subnet.public_subnet.*.id,count.index)
}

# Private route table association
resource "aws_route_table_association" "web-subnet-asso" {
  count = length(var.azs)
  route_table_id = aws_route_table.private-rt.id
  subnet_id = element(aws_subnet.web_subnet.*.id,count.index)
}
# Private route table association
resource "aws_route_table_association" "app-subnet-asso" {
  count = length(var.azs)
  route_table_id = aws_route_table.private-rt.id
  subnet_id = element(aws_subnet.app_subnet.*.id,count.index )
}
# Private route table association
resource "aws_route_table_association" "db-subnet-asso" {
  count = length(var.azs)
  route_table_id = aws_route_table.private-rt.id
  subnet_id = element(aws_subnet.db_subnet.*.id,count.index )
}

# VPC peering with Mumbai region P-vpc

resource "aws_vpc_peering_connection" "vpc-peering" {
  vpc_id        = aws_vpc.vpc.id
  peer_vpc_id   = "vpc-0fdd0b1d7edaed19b"
  peer_region   = "ap-south-1"

  tags = {
    Name = "VPC Peering between ${var.namespace}-vpc and p-vpc"
  }
}
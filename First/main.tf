# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

#Step2: Creating VPC

resource "aws_vpc" "VPC_nonprod" {
  cidr_block       = "10.15.0.0/16"
  instance_tenancy = "default"
}
# Step 3:Adding public subnet 1 and 2 in VPC_nonprod
#First defining cidrs in local
locals {
  public_cidrs = ["10.15.0.0/24", "10.15.1.0/24"]
}
#next add public subnet1
resource "aws_subnet" "public_sn1" {
  vpc_id            = aws_vpc.VPC_nonprod.id
  cidr_block        = local.public_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]
}
#public subnet2 
resource "aws_subnet" "public_sn2" {
  vpc_id            = aws_vpc.VPC_nonprod.id
  cidr_block        = local.public_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]
}
#Step 4: Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_nonprod.id
}
#Step 5: Routine Table to igw

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.VPC_nonprod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Step 6: Associating Routine table with subnet
#For subnet 1
resource "aws_route_table_association" "link1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_sn1.id
}
#For subnet 2
resource "aws_route_table_association" "link2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_sn2.id
}
# Step 7: Security Group
resource "aws_security_group" "web_sg1" {
  name        = "allow_http_ssh"
  description = "Allow HTTPS,HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.VPC_nonprod.id

 
  
  ingress {
    description = "HTTP from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = local.public_cidrs
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





              
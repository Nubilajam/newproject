# Step 7: Security Group
resource "aws_security_group" "wb_sg2" {
  name        = "allow_http_ssh2"
  description = "Allow HTTPS,HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.VPC_nonprod.id

  ingress {
    description = "HTTPS from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from everywhere"
    from_port   = 430
    to_port     = 430
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
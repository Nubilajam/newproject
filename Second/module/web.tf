

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "james_web" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  security_groups             = var.security_group
  associate_public_ip_address = true

  tags = {
    "Name"  = "James_web"
    "Owner" = "Nubila"
    "App"   = "Web"
  }

  user_data = <<EOF
              #!/bin/bash
              yum -y update
              systemctl enable httpd
              yum install -y httpd
              systemctl start httpd
              echo "<h1>Nubila Mbetigi James new project. Thanks </h1>" > /var/www/html/index.html
              EOF

  lifecycle {
    create_before_destroy = true
  }
}










   
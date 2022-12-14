#New Project

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
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.new_project.key_name
  subnet_id                   = aws_subnet.public_sn2.id
  security_groups             = [aws_security_group.wb_sg2.id]
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


# Adding SSH key to Amazon EC2
resource "aws_key_pair" "new_project" {
  key_name   = "project.pub"
  public_key = file("~/.ssh/project.pub")
}





   
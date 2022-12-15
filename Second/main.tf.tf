
provider "aws" {
  region  = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "project-nubila"               # Bucket to save terraform state
    key    = "idxbucket1/terraform.tfstate" # Object name in the bucket
    region = "us-east-1"
  }
}

module "vpc" {

  source            = "./modules/vpc"
  cidr_block        = var.cidr_block
  public_cidrs      = var.public_cidrs
  availability_zone = data.aws_availability_zones.available.names
}


module "web" {

  source         = "./modules/web"
  subnet_id      = module.vpc.public_subnet_1
  instance_type  = var.instance_type
  key_name       = aws_key_pair.new_project.key_name
  security_group = [module.vpc.web_sg2]
}


# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "new_project" {
  key_name   = "project.pub"
  public_key = file("~/.ssh/project.pub")
}


output "web_ip" {
  value = module.web.webip
}
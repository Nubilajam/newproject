# Step 1 - Module to deploy network and webserver

module "main" {

  source            = "./module"
  #cidr_block        = var.cidr_block
  public_cidrs      = var.public_cidrs
  availability_zone = data.aws_availability_zones.available.names
  key_name       = aws_key_pair.new_project.key_name
  subnet_id      = module.vpc.public_subnet_1
  security_group = [module.vpc.web_sg2]
  instance_type  = var.instance_type
}


# Step 2 - Storage, key
terraform {
  backend "s3" {
    bucket = "project-nubila"               # Bucket to save terraform state
    key    = "idxbucket1/terraform.tfstate" # Object name in the bucket
    region = "us-east-1"
  }
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




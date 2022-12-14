terraform {
  backend "s3" {
    bucket = "project-nubila"            # Bucket to save terraform state
    key    = "project/terraform.tfstate" # Object name in the bucket
    region = "us-east-1"
  }
}
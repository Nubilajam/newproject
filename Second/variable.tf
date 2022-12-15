
variable "cidr_block" {
  type = string
  description = "VPC cidr block"
  default = "10.15.0.0/16"
}

variable "public_cidrs" {
  type = list(any)
  description = "Public subnet cidr list"
  default = ["10.15.0.0/24", "10.15.1.0/24"]
}

variable "instance_type" {
  type        = string
  description = "Web instance"
  default     = "t2.micro"
}

# Data source for availability zones in us-east-1
#data "aws_availability_zones" "available" {
 # state = "available"
#}

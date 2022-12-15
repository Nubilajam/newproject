variable "vpc_cidr" {
  type = string
  description = "VPC cidr block"
}


variable "public_cidrs" {
  type = list
  description = "Public subnet cidr list"
}

variable "availability_zone" {
  type = list
  description = "Availability zone list"
}


variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "security_group" {
  type = list(string)
}
variable "key_name" {
  type = string
}
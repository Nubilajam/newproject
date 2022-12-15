variable "cidr_block" {
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
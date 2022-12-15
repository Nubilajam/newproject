
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
  description = "Web instance size"
  default     = "t2.micro"
}

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
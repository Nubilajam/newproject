
output "public_subnet_1" {
  value = aws_subnet.public_sn1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_sn2.id
}

output "web_sg2" {
  value = aws_security_group.wb_sg2.id
}
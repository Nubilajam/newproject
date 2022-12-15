output "public_sn_1" {
  value = aws_subnet.public_sn1.id
}

output "public_sn_2" {
  value = aws_subnet.public_sn2.id
}

output "vpc_id" {
  value = aws_vpc.VPC_nonprod.id
}

output "webip" {
  value = aws_instance.james_web.public_ip
}

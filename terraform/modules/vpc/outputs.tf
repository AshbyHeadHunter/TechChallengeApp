output "vpc_id" {
  value = aws_vpc.default.id
}

output "public_subnets" {
  value = [
    aws_subnet.public_a,
    aws_subnet.public_b,
    aws_subnet.public_c,
  ]
}

output "private_subnets" {
  value = [
    aws_subnet.private_a,
    aws_subnet.private_b,
    aws_subnet.private_c,
  ]
}

output "vpc" {
  value = aws_vpc.default
}

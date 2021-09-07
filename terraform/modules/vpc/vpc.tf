##
## VPC
## 1. Create our default aws VPC
## 2. Create our Internet Gateway
## 3. Create NAT Gateway
## 4. Create an Elastic IP
##
resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = merge(tomap({
    "Name" = "${var.app_name}-vpc"
  }), var.tags)
}

##
## Internet Gateway
##
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = merge(tomap({
    "Name" = "${var.app_name}-igw"   
  }), var.tags)
}
##
## NAT Gateway
## Currently only running a Single nat. Need to look at making this Highly avalibile so to remove single point of failure. Nat for each subnet.
##
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.default]

  tags = merge(tomap({
    "Name" = "${var.app_name}-nat"
    
  }), var.tags)
}
resource "aws_eip" "ngw" {
  vpc = true
  tags = merge(tomap({
    "Name" = "${var.app_name}-nat"
  }), var.tags)
}

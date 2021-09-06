##
## VPC
##
resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = merge(tomap({
    "Name" = "${var.app_name}-vpc"
    "Terraform" = replace(path.cwd, "/^.*(terraform.*)$/", "$1")
  }), var.tags)
}

##
## Internet Gateway
##
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = merge(tomap({
    "Name" = "${var.app_name}-igw"
    "Terraform" = replace(path.cwd, "/^.*(terraform.*)$/", "$1")
  }), var.tags)
}

##
## NAT Gateway
##
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [aws_internet_gateway.default]

  tags = merge(tomap({
    "Name" = "${var.app_name}-nat"
    "Terraform" = replace(path.cwd, "/^.*(terraform.*)$/", "$1")
  }), var.tags)
}

resource "aws_eip" "ngw" {
  vpc = true

  tags = merge(tomap({
    "Name" = "${var.app_name}-nat"
    "Terraform" = replace(path.cwd, "/^.*(terraform.*)$/", "$1")
  }), var.tags)
}

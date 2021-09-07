# Create and Setup our Public Subnets
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_public_a
  availability_zone = var.availability_zone_a
  tags = merge(tomap({
    "Name" = "${var.app_name}-public-a"   
  }), var.tags)
}
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_public_b
  availability_zone = var.availability_zone_b
  tags = merge(tomap({
    "Name" = "${var.app_name}-public-b"
  }), var.tags)
}
resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_public_c
  availability_zone = var.availability_zone_c
  tags = merge(tomap({
    "Name" = "${var.app_name}-public-c"   
  }), var.tags)
}
# Create and Setup our Private Subnets
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_private_a
  availability_zone = var.availability_zone_a
  tags = merge(tomap({
    "Name" = "${var.app_name}-private-a"   
  }), var.tags)
}
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_private_b
  availability_zone = var.availability_zone_b
  tags = merge(tomap({
    "Name" = "${var.app_name}-private-b"  
  }), var.tags)
}
resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.cidr_private_c
  availability_zone = var.availability_zone_c
  tags = merge(tomap({
    "Name" = "${var.app_name}-private-c"  
  }), var.tags)
}

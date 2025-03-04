## Public Routes 
## Create our Public Route Table 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = var.route_public_cidr
    gateway_id = aws_internet_gateway.default.id
  }
  tags = merge(tomap({
    "Name" = "${var.app_name}-public" 
  }), var.tags)
}

## Associate our public routes with our public subnets
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

## Private Routes
## Create our private Route Table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block     = var.route_public_cidr
    nat_gateway_id = aws_nat_gateway.default.id
  }
  tags = merge(tomap({
    "Name" = "${var.app_name}-private"
  }), var.tags)
}
## Associate our private routes with our private subnets
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}
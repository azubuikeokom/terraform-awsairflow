resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.env-name}-public-route-table"
  }
}
resource "aws_route_table" "private-1-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1.id
  }


  tags = {
    Name = "${var.env-name}-private-1-route-table"
  }
}
resource "aws_route_table" "private-2-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-2.id
  }


  tags = {
    Name = "${var.env-name}-private-2-route-table"
  }
}
resource "aws_route_table_association" "ass-public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "ass-public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "ass-private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-1-rt.id
}
resource "aws_route_table_association" "ass-private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private-2-rt.id
}


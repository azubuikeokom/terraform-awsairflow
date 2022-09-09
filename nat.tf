resource "aws_nat_gateway" "nat-gw-1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public-1.id

  tags = {
    Name = "gw NAT1"
  }
  depends_on = [
    aws_eip.eip1
  ]
}
resource "aws_nat_gateway" "nat-gw-2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public-2.id

  tags = {
    Name = "gw NAT2"
  }
  depends_on = [
    aws_eip.eip2
  ]
}
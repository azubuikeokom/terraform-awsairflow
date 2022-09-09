resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-sub1-cidr
  availability_zone       = var.az[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env-name}-pub-subnet"
  }
}
resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-sub2-cidr
  availability_zone       = var.az[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env-name}-pub-subnet"
  }
}
resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private-sub1-cidr
  availability_zone       = var.az[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env-name}-priv-subnet"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private-sub2-cidr
  availability_zone       = var.az[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.env-name}-priv-subnet"
  }
}
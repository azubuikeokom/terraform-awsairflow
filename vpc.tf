resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "${var.env-name}-vpc"
  }
}
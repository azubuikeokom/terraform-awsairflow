resource "aws_security_group" "mwaa-sg" {
  name        = "mwaa-security-group"
  description = "Security group with a self-referencing inbound rule"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "traffic from this SG"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_only_SG_traffic"
  }
}
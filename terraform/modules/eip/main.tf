resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}


resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "nat-gateway"
  }
}
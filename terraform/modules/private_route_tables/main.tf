resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table_association" "private_app" {
  count = length(var.private_app_subnet_ids)

  subnet_id      = var.private_app_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_db" {
  count = length(var.private_db_subnet_ids)

  subnet_id      = var.private_db_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
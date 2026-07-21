# create public/private subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = var.enablePublicIP

  tags = {
    Name = "${var.tag_name}-${count.index + 1}"
    env  = var.env
  }
}



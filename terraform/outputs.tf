output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cidr_block" {
  value = module.vpc.cidr_block
}


output "aws_route_table" {
  value = module.route_tables.aws_route_table_public_id
}

output "aws_internet_gateway_id" {
  value = module.vpc.aws_internet_gateway_id
}

output "aws_subnet" {
  value = module.subnets.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.subnets_app.public_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.subnets_db.public_subnet_ids
}

output "aws_nat_gateway_id" {
  value = module.eip.aws_nat_gateway_id
}

output "primary_db_identifier" {
  value = module.rds_read_replica.db_identifier
}

output "frontend_instances" {
  value = module.frontend_servers.aws_instance
}


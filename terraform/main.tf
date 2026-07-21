module "vpc" {
  source = "./modules/vpc"
  env    = var.env
  region = var.region
}




#create public subnets
module "subnets" {
  source              = "./modules/subnets"
  env                 = var.env
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = var.availability_zones
  enablePublicIP      = true
  vpc_id              = module.vpc.vpc_id
  tag_name            = "public-subnet"
}

module "subnets_app" {
  source              = "./modules/subnets"
  env                 = var.env
  public_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones  = var.availability_zones
  enablePublicIP      = false
  vpc_id              = module.vpc.vpc_id
  tag_name            = "Private App Subnet"
}

module "subnets_db" {
  source              = "./modules/subnets"
  env                 = var.env
  public_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
  availability_zones  = var.availability_zones
  enablePublicIP      = false
  vpc_id              = module.vpc.vpc_id
  tag_name            = "Private DB Subnet"
}


#create public route table
module "route_tables" {
  depends_on        = [module.subnets, module.subnets_app, module.subnets_db]
  source            = "./modules/route_tables"
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.aws_internet_gateway_id
  public_subnet_ids = module.subnets.public_subnet_ids
}


#create nat gateway
module "eip" {
  source           = "./modules/eip"
  public_subnet_id = module.subnets.public_subnet_ids[0]
}

#create private route tables
module "private_route_tables" {
  depends_on             = [module.eip]
  source                 = "./modules/private_route_tables"
  vpc_id                 = module.vpc.vpc_id
  nat_gateway_id         = module.eip.aws_nat_gateway_id
  private_app_subnet_ids = module.subnets_app.public_subnet_ids
  private_db_subnet_ids  = module.subnets_db.public_subnet_ids
}

#create security groups
module "security_groups" {
  source    = "./modules/security_groups"
  env       = var.env
  vpc_id    = module.vpc.vpc_id
  public_ip = ["10.0.1.0/24", "10.0.2.0/24"]
}


#create RDS instance
module "rds" {
  source                = "./modules/rds"
  db_username           = var.db_username
  db_password           = var.db_password
  rds_sg_id             = module.security_groups.rds_sg_id
  private_db_subnet_ids = module.subnets_db.public_subnet_ids
}

#create RDS read replica
module "rds_read_replica" {

  source = "./modules/rds_read_replica"

  primary_db_identifier = module.rds.db_identifier

  depends_on = [
    module.rds
  ]
}

#Create IAM role for backend servers
module "iam" {
  source = "./modules/iam"
}



#create backend servers
module "backend_servers" {
  source           = "./modules/backendServer"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_ids       = module.subnets_db.public_subnet_ids
  backend_sg_id    = module.security_groups.backend_security_group_id
  instance_profile = module.iam.private_instance_profile_name

}

#create frontend servers
module "frontend_servers" {
  source           = "./modules/frontendServer"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_ids       = module.subnets_app.public_subnet_ids
  frontend_sg_id   = module.security_groups.frontend_security_group_id
  instance_profile = module.iam.private_instance_profile_name

}

#create externam load balancer
module "alb" {
  source              = "./modules/alb"
  alb_name            = "my-alb"
  target_group_name   = "my-target-group"
  target_port         = 80
  target_protocol     = "HTTP"
  vpc_id              = module.vpc.vpc_id
  security_group_ids  = [module.security_groups.alb_security_group_id]
  subnet_ids          = module.subnets.public_subnet_ids
  instance_id         = module.frontend_servers.aws_instance
  internal            = false
}


#create auto scaling group for frontend servers
module "frontend_asg" {
  source           = "./modules/frontend_asg"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  frontend_sg_id   = module.security_groups.frontend_security_group_id
  instance_profile = module.iam.private_instance_profile_name
  private_subnet1  = module.subnets_app.public_subnet_ids[0]
  private_subnet2  = module.subnets_app.public_subnet_ids[1]
  target_group_arn = module.alb.target_group_arn
}

module "project_vpc" {
  source = ".//vpc-module"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
  app_tier_subnet_cidr = var.app_tier_subnet_cidr
  db_tier_subnet_cidr = var.db_tier_subnet_cidr
}


module "websg" {
  source = ".//sg-module"
  sg_name = "SG for Web tier"
  vpc_id = module.project_vpc.vpc_id
  ingress_rules   = var.web_and_app_inbound_rules
  tags = {
    Name = "web server sg"
  }
}

module "appsg" {
  source = ".//sg-module"
  sg_name = "SG for App tier"
  vpc_id = module.project_vpc.vpc_id
  ingress_rules   = var.web_and_app_inbound_rules
  tags = {
    Name = "app server sg"
  }
}

module "dbsg" {
  source = ".//sg-module"
  sg_name = "SG for db tier"
  vpc_id = module.project_vpc.vpc_id
  ingress_rules   = var.db_inbound_rules
  tags = {
    Name = "db tier sg"
  }
}

# Creating Web-Tier
module "Web-Tier" {
  source = ".//ASG-module"
  alb_name = var.web_alb_name
  scheme =  var.web_alb_scheme
  tg_name = var.web_tg_name
  vpc_id = module.project_vpc.vpc_id
  name_prefix = var.web_name_prefix
  ami-id = data.aws_ami.amzlinux.id
  instance_type = var.web_instance_type
  sg-id = [module.websg.security_group_id]
  user_data = base64encode(file("amzninstall.sh"))
  name = var.web_name
  min_size = var.web_min_size
  max_size = var.web_max_size
  desired_capacity = var.web_desired_capacity
  subnet_ids = module.project_vpc.public_subnet_ids
  tags = var.web_tags
}

# Creating App-Tier
module "App-Tier" {
  source = ".//ASG-module"
  alb_name = var.app_alb_name
  scheme =  var.app_alb_scheme
  tg_name = var.app_tg_name
  vpc_id = module.project_vpc.vpc_id
  name_prefix = var.app_name_prefix
  ami-id = data.aws_ami.ubuntu.id
  instance_type = var.app_instance_type
  sg-id = [module.appsg.security_group_id]
  user_data = ""
  name = var.app_name
  min_size = var.app_min_size
  max_size = var.app_max_size
  desired_capacity = var.app_desired_capacity
  subnet_ids = module.project_vpc.app_tier_subnet_ids
  tags = var.app_tags
}


# DB Subnet Group
# You MUST add both subnets here so RDS generally knows where it is allowed to exist.
resource "aws_db_subnet_group" "project_db_subnet" {
  name       = "my-db-subnet-group"
  subnet_ids = module.project_vpc.db_tier_subnet_ids
  tags = {
    Name = "My DB Subnet Group"
  }
}

# Writer Instance (Pinned to Subnet 1 via AZ)

resource "aws_db_instance" "writer_instance" {
  identifier = "mysql-writer-db"
  # Engine & Storage
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"
  # Credentials
  username = "admin"
  password = var.db_password
  db_name  = "appdb"
  # Placement Control
  db_subnet_group_name = aws_db_subnet_group.project_db_subnet.name
  availability_zone    = "ap-south-1a" # Forces placement into 'subnet_writer'
  # Network Security
  vpc_security_group_ids = [module.dbsg.security_group_id]
  publicly_accessible    = false
  # Backups (MANDATORY > 0 for Read Replicas)
  backup_retention_period = 1
  skip_final_snapshot     = true
  tags = {
    Name = "MySQL Writer"
  }
}

# Read Replica (Pinned to Subnet 2 ('subnet_reader') via AZ)

resource "aws_db_instance" "replica" {
  identifier = "mysql-reader-db"
  # Replication Link
  replicate_source_db = aws_db_instance.writer_instance.identifier
  # Instance Spec (Can match or differ from writer)
  instance_class = "db.t3.micro"
  storage_type   = "gp3"
  availability_zone = "ap-south-1b"
  # Network Security
  vpc_security_group_ids = [module.dbsg.security_group_id]
  publicly_accessible    = false
  # No backups needed for the replica itself usually
  backup_retention_period = 0
  skip_final_snapshot     = true
  tags = {
    Name = "MySQL Read Replica"
  }
}


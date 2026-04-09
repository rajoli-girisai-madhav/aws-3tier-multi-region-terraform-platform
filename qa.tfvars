aws_region = "ap-south-1"
vpc_cidr_block = "109.0.0.0/16"
public_subnet_cidr = ["109.0.10.0/24", "109.0.30.0/24"]
app_tier_subnet_cidr = ["109.0.50.0/24", "109.0.70.0/24"]
db_tier_subnet_cidr = ["109.0.90.0/24", "109.0.110.0/24"]
web_and_app_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  },
  {
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }
]
db_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  },
  {
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  },
  {
    port        = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow MYSQL/AURORA traffic"
  }
]

web_alb_name = "Web-Tier-ALB"
web_alb_scheme = false
web_tg_name = "web-Tier-tg"
web_name_prefix = "Web-Template"
web_instance_type = "t3.micro"
web_name = "Web-Tier-ASG"
web_min_size = 2
web_max_size = 4
web_desired_capacity = 2
web_tags = "Web-Instance"

 
app_alb_name = "App-Tier-ALB"
app_alb_scheme = true
app_tg_name = "App-Tier-tg"
app_name_prefix = "App-Template"
app_instance_type = "t3.medium"
app_name = "App-Tier-ASG"
app_min_size = 2
app_max_size = 4
app_desired_capacity = 2
app_tags = "App-Tier-Instance"

db_password = "SecurePassword123456!"

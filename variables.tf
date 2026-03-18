variable "aws_region_name" {
  description = "To specify region, where I wish to deploy my complete 3-tier project"
  type = string
}

variable "aws_profile_name" {
  description = "To provide the profile name of the IAM userof my aws account"
  type = string
}

variable "vpc_cidr_block" {
  description = "IPv4 CIDR block is for creating VPC for my 3-Tier Architecture Project"
  type        = string
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR list for creating Public Subnets in 3-Tier Architecture Project"
  type        = list(string)
}

variable "app_tier_subnet_cidr" {
  description = "IPv4 CIDR list for creating pvt Subnets for app-tier in 3-Tier Architecture Project"
  type        = list(string)
}

variable "db_tier_subnet_cidr" {
  description = "IPv4 CIDR list for creating pvt Subnets for db-tier in 3-Tier Architecture Project"
  type        = list(string)
}

variable "web_and_app_inbound_rules" {
  description = "Ingress rules for web and app security group"
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "db_inbound_rules" {
  description = "Ingress rules for db security group"
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "web_alb_name" {
  description = "Provide the name for web-tier application load balancer"
  type = string
}
variable "web_alb_scheme" {
  description = "Say false, since web-tier is Internet-facing."
  type = bool
}
variable "web_tg_name" {
  description = "Provide name for target group"
  type = string
}
variable "web_name_prefix" {
  description = "provide a name prefix for my launch template"
  type = string
}
variable "web_instance_type" {
  description = "Instance type for launched instances"
  type = string
}
variable "web_name" {
  description = "provide a name for my AutoScaling Group"
  type = string
}
variable "web_min_size" {
  description = "describing minimum number of instances required during launch of ASG"
  type = number
}
variable "web_max_size" {
  description = "describing maximum number of instances required during launch of ASG"
  type = number
}
variable "web_desired_capacity" {
  description = "describing number of instances required during launch of ASG"
  type = number
}
variable "web_tags" {
  description = "provide a name prefix for web launch template"
  type = string
}


variable "app_alb_name" {
  description = "Provide the name for app-tier application load balancer"
  type = string
}
variable "app_alb_scheme" {
  description = "Say true, since app-tier is Internet-facing."
  type = bool
}
variable "app_tg_name" {
  description = "Provide name for target group"
  type = string
}
variable "app_name_prefix" {
  description = "provide a name prefix for my launch template"
  type = string
}
variable "app_instance_type" {
  description = "Instance type for launched instances"
  type = string
}
variable "app_name" {
  description = "provide a name for my AutoScaling Group"
  type = string
}
variable "app_min_size" {
  description = "describing minimum number of instances required during launch of ASG"
  type = number
}
variable "app_max_size" {
  description = "describing maximum number of instances required during launch of ASG"
  type = number
}
variable "app_desired_capacity" {
  description = "describing number of instances required during launch of ASG"
  type = number
}
variable "app_tags" {
  description = "provide a name prefix for app launch template"
  type = string
}

variable "db_password" {
  description = "change password as you wish"
  type = string
  sensitive = true
}

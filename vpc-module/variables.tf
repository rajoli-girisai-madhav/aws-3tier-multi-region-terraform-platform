variable "vpc_cidr_block" {
  description = "IPv4 CIDR block is for creating VPC for my 3-Tier Architecture Project"
  type        = string
  default     = "132.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR list for creating Public Subnets in 3-Tier Architecture Project"
  type        = list(string)
  default     = ["132.0.10.0/24", "132.0.30.0/24"]
}

variable "app_tier_subnet_cidr" {
  description = "IPv4 CIDR list for creating pvt Subnets for app-tier in 3-Tier Architecture Project"
  type        = list(string)
  default     = ["132.0.50.0/24", "132.0.70.0/24"]
}

variable "db_tier_subnet_cidr" {
  description = "IPv4 CIDR list for creating pvt Subnets for db-tier in 3-Tier Architecture Project"
  type        = list(string)
  default     = ["132.0.90.0/24", "132.0.110.0/24"]
}


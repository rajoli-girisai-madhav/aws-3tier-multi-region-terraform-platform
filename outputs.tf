output "vpc_id" {
  value = module.project_vpc.vpc_id
}

output "Internet_gateway_id" {
  value = module.project_vpc.Internet_gateway_id
}

output "web_tier_subnet_ids" {
  value       = module.project_vpc.public_subnet_ids
}

output "app_tier_subnet_ids" {
  value       = module.project_vpc.app_tier_subnet_ids
}

output "db_tier_subnet_ids" {
  value       = module.project_vpc.db_tier_subnet_ids
}

output "elastc_ip" {
  value = module.project_vpc.elastc_ip
}

output "nat_gateway_id" {
  value = module.project_vpc.nat_gateway_id
}

output "Public_Route_table" {
  value = module.project_vpc.Public_Route_table
}

output "Private_Route_tables" {
  value = module.project_vpc.Private_Route_tables
}

output "web_security_group" {
  value = module.websg.security_group_id
}

output "app_security_group" {
  value = module.appsg.security_group_id
}

output "db_security_group" {
  value = module.dbsg.security_group_id
}

output "Web-Tier-ASG-id" {
  value = module.Web-Tier.ASG_id
}

output "App-Tier-ASG-id" {
  value = module.App-Tier.ASG_id
}

# Web Tier Outputs
output "web_alb_dns" {
  value = module.Web-Tier.alb_dns_name
}

output "web_asg_name" {
  value = module.Web-Tier.asg_name
}

# App Tier Outputs
output "app_alb_dns" {
  value = module.App-Tier.alb_dns_name
}

output "app_asg_name" {
  value = module.App-Tier.asg_name
}

output "writer_db_dns_hostname" {
  description = "DNS hostname of the writer RDS instance"
  value       = aws_db_instance.writer_instance.address
}

output "reader_db_dns_hostname" {
  description = "DNS hostname of the read replica RDS instance"
  value       = aws_db_instance.replica.address
}


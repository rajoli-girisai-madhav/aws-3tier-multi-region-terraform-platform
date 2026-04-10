
output "vpc_id" {
  description = "Capture the vpc id used in another blocks"
  value = aws_vpc.main.id
}

output "Internet_gateway_id" {
  description = "capture Internet Gateway ID"
  value = aws_internet_gateway.my_igw.id
}

# Output the list of public subnet IDs
output "public_subnet_ids" {
  description = "captures the output of public subnet IDs created"
  value       = aws_subnet.public-subnets[*].id 
}

# Output the list of app-tier-private subnet IDs
output "app_tier_subnet_ids" {
  description = "captures the output of app tier subnet IDs created"
  value       = aws_subnet.app-tier-subnets[*].id
}

# Output the list of db-tier-private subnet IDs
output "db_tier_subnet_ids" {
  description = "captures the output of app tier subnet IDs created"
  value       = aws_subnet.db-tier-subnets[*].id
}

output "elastc_ip" {
  description = "capture elastic IPs"
  value = aws_eip.eip_for_nat[*].id
}

output "nat_gateway_id" {
  description = "capture the NAT Gateway ID's"
  value = aws_nat_gateway.nat_gws[*].id
}

output "Public_Route_table" {
  description = "capture id of public route table"
  value = aws_route_table.custom_public_rt.id
}

output "Private_Route_tables" {
  description = "capture id of private route tables"
  value = aws_route_table.private_rtb[*].id
}

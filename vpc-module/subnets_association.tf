# Associate the Public Subnets with the Public Route Table
resource "aws_route_table_association" "pub_subnet_assoc" {
  count = length(aws_subnet.public-subnets)

  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.custom_public_rt.id
}


# Associate the Private Subnets with the Private Route Table

resource "aws_route_table_association" "app_tier_private_assoc" {
  count = length(aws_subnet.app-tier-subnets)

  subnet_id      = aws_subnet.app-tier-subnets[count.index].id
  route_table_id = aws_route_table.private_rtb[count.index].id
}


resource "aws_route_table_association" "db_tier_private_assoc" {
  count = length(aws_subnet.db-tier-subnets)

  subnet_id      = aws_subnet.db-tier-subnets[count.index].id
  route_table_id = aws_route_table.private_rtb[count.index].id
}

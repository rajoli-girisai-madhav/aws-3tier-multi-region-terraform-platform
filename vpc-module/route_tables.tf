# Creating Public Route table
resource "aws_route_table" "custom_public_rt" {
  vpc_id = aws_vpc.main.id
  # Add a route for all internet traffic (0.0.0.0/0) to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "Public-route-table"
  }
}

# Creating Private Route tables
resource "aws_route_table" "private_rtb" {
  count = 2
  vpc_id = aws_vpc.main.id
  # This route directs all outbound traffic (0.0.0.0/0) to the NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gws[count.index].id
  }
  tags = {
    Name = "private-route-table-${count.index + 1}"
  }
}

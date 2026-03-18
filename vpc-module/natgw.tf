# Create NAT Gateways, one in each specified public subnet

resource "aws_nat_gateway" "nat_gws" {
  count         = 2 # Create two NAT gateways
  allocation_id = aws_eip.eip_for_nat[count.index].id
  subnet_id     = aws_subnet.public-subnets[count.index].id
  tags = {
    Name = "NAT-Gateway-${count.index + 1}-${data.aws_availability_zones.available.names[count.index]}"
  }
}

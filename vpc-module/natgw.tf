# Create NAT Gateways, one in each specified public subnet

resource "aws_nat_gateway" "nat_gws" {
  count         = length(var.public_subnet_cidr)
  allocation_id = aws_eip.eip_for_nat[count.index].id
  subnet_id     = aws_subnet.public-subnets[count.index].id
  tags = {
    Name = "NAT-Gateway-${count.index + 1}-${data.aws_availability_zones.available.names[count.index]}"
  }
}

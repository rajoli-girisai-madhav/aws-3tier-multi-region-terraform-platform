# Allocate an EIP for each NAT Gateway

resource "aws_eip" "eip_for_nat" {
  count = 2 # Create two EIPs
  domain = "vpc"
  depends_on = [aws_internet_gateway.my_igw]
  tags = {
    Name = "nat-gateway-eip-${count.index+1}"
  }
}

# Creating Internet Gateway (IGW) for the above VPC

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Terraform-3-Tier-Project-IGW"
  }
}

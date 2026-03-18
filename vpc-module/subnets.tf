# Public Subnets for Web-Tier

resource "aws_subnet" "public-subnets" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true  # Auto-assign public-ipv4
  tags = {
    Name = "Public Subnet-${count.index+1}"
  }
}

# Private Subnets for App-Tier

resource "aws_subnet" "app-tier-subnets" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_tier_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false  # Private subnets doesn't need of public-ipv4
  tags = {
    Name = "App Tier Private Subnet-${count.index+1}"
  }
}

# Private Subnets for DataBase-Tier

resource "aws_subnet" "db-tier-subnets" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_tier_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false  # private subnets doesn't need public-ipv4
  tags = {
    Name = "DB Tier Private Subnet-${count.index+1}"
  }
}

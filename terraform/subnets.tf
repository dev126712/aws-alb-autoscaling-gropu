
variable "vpc_availability_zones" {

  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-2a", "us-east-2b"]

}

resource "aws_subnet" "subnets" {
  vpc_id                  = aws_vpc.vpc1.id
  count                   = length(var.vpc_availability_zones)
  cidr_block              = cidrsubnet(aws_vpc.vpc1.cidr_block, 8, count.index + 1)
  availability_zone       = element(var.vpc_availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "test-subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "test-subnets-rt"
  }
}


resource "aws_route_table_association" "route-table-association" {
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.subnets[*].id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}

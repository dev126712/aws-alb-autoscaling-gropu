/*resource "aws_route_table" "public-route-table" {
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
  subnet_id = element(aws_subnet.subnet1[*].id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}
*/

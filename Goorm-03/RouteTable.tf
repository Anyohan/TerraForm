resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.groom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.groom_igw.id
  }

  tags = {
    Name = "WebRouteTable"
  }
}

resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.groom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "AppRouteTable"
  }
}

resource "aws_route_table" "DB_rt" {
  vpc_id = aws_vpc.groom_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "web_a_rta" {
  subnet_id      = aws_subnet.public_Web_a.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_c_rta" {
  subnet_id      = aws_subnet.public_Web_c.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "app_a_rta" {
  subnet_id      = aws_subnet.private_APP_a.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table_association" "app_c_rta" {
  subnet_id      = aws_subnet.private_APP_c.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table_association" "DB_a_rta" {
  subnet_id      = aws_subnet.private_DB_a.id
  route_table_id = aws_route_table.DB_rt.id
}

resource "aws_route_table_association" "DB_c_rta" {
  subnet_id      = aws_subnet.private_DB_c.id
  route_table_id = aws_route_table.DB_rt.id
}
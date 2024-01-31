resource "aws_internet_gateway" "groom_igw" {
  vpc_id = aws_vpc.groom_vpc.id

  tags = {
    Name = "groomIGW"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_Web_a.id
  depends_on    = [aws_internet_gateway.groom_igw]

  tags = {
    Name = "groomNATGateway"
  }
}
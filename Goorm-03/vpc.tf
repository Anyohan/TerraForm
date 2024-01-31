resource "aws_vpc" "groom_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "groomVPC"
  }
}

resource "aws_subnet" "public_Web_a" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicWebA"
  }
}
resource "aws_subnet" "private_APP_a" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "privateAppA"
  }
}
resource "aws_subnet" "private_DB_a" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "privateDbA"
  }
}

resource "aws_subnet" "public_Web_c" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicWebC"
  }
}

resource "aws_subnet" "private_APP_c" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "privateAppC"
  }
}

resource "aws_subnet" "private_DB_c" {
  vpc_id            = aws_vpc.groom_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "privateDbC"
  }
}


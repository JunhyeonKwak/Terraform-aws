
# VPC 생성
resource "aws_vpc" "groomVPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "groomVPC"
  }
}

# public subnet 생성
resource "aws_subnet" "public-web-a" {
  vpc_id     = aws_vpc.groomVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone =  "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Web a"
  }
}
resource "aws_subnet" "public-web-c" {
  vpc_id     = aws_vpc.groomVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone =  "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Web c"
  }
}

# private subnet 생성
resource "aws_subnet" "private-app-a" {
  vpc_id     = aws_vpc.groomVPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone =  "ap-northeast-2a"

  tags = {
    Name = "Private App a"
  }
}
resource "aws_subnet" "private-app-c" {
  vpc_id     = aws_vpc.groomVPC.id
  cidr_block = "10.0.4.0/24"
  availability_zone =  "ap-northeast-2c"

  tags = {
    Name = "Private App c"
  }
}
resource "aws_subnet" "private-db-a" {
  vpc_id            = aws_vpc.groomVPC.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Private DB a"
  }
}

resource "aws_subnet" "private-db-c" {
  vpc_id            = aws_vpc.groomVPC.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "Private DB c"
  }
}
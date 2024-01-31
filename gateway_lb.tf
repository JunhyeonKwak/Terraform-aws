# Internet Gateway 생성
resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.groomVPC.id

  tags = {
    Name = "Internet GW"
  }
}

# Elastic IP 생성
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway 생성
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-web-a.id

  tags = {
    Name = "Nat Gateway"
  }

  depends_on = [aws_internet_gateway.internet-gw]
}

# Web ALB 생성
resource "aws_lb" "web-lb" {
  name               = "Web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = [aws_subnet.public-web-a.id,aws_subnet.public-web-c.id]
  security_groups = [aws_security_group.web_security.id]

  tags = {
    Environment = "production"
  }
}

# App ALB 생성
resource "aws_lb" "app-lb" {
  name               = "App-lb"
  internal           = true
  load_balancer_type = "application"
  subnets = [aws_subnet.private-app-a.id,aws_subnet.private-app-c.id]

  tags = {
    Environment = "production"
  }
}
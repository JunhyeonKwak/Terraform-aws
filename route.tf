# web route table 생성
resource "aws_route_table" "web-route-table" {
  vpc_id = aws_vpc.groomVPC.id

  # 인터넷 게이트웨이를 통한 외부 트래픽 라우팅 (퍼블릭 서브넷용)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  
  # IPv6 인터넷 게이트웨이 라우팅 (퍼블릭 서브넷용, IPv6가 활성화된 경우)
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name = "Web Route Table"
  }
}

# 서브넷 구성
resource "aws_route_table_association" "web-a" {
  subnet_id      = aws_subnet.public-web-a.id
  route_table_id = aws_route_table.web-route-table.id
}

resource "aws_route_table_association" "web-c" {
  subnet_id      = aws_subnet.public-web-c.id
  route_table_id = aws_route_table.web-route-table.id
}

# app route table 생성
resource "aws_route_table" "app-route-table" {
  vpc_id = aws_vpc.groomVPC.id

  # NAT 게이트웨이를 통한 외부 트래픽 라우팅 (프라이빗 서브넷용)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "App Route Table"
  }
}

resource "aws_route_table_association" "app-a" {
  subnet_id      = aws_subnet.private-app-a.id
  route_table_id = aws_route_table.app-route-table.id
}

resource "aws_route_table_association" "app-c" {
  subnet_id      = aws_subnet.private-app-c.id
  route_table_id = aws_route_table.app-route-table.id
}

# db route table 생성
resource "aws_route_table" "db-route-table" {
  vpc_id = aws_vpc.groomVPC.id

  tags = {
    Name = "DB Route Table"
  }
}

resource "aws_route_table_association" "db-a" {
  subnet_id      = aws_subnet.private-db-a.id
  route_table_id = aws_route_table.db-route-table.id
}

resource "aws_route_table_association" "db-c" {
  subnet_id      = aws_subnet.private-db-c.id
  route_table_id = aws_route_table.db-route-table.id
}
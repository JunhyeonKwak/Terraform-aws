# web sequrity
resource "aws_security_group" "web_security" {
  name        = "web_security"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.groomVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // HTTP 접근 허용
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // HTTPS 접근 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  // 모든 아웃바운드 트래픽 허용
  }

  tags = {
    Name = "web_security"
  }
}

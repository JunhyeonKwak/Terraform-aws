# web target group 생성
resource "aws_lb_target_group" "web-target" {
  name     = "wep-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.groomVPC.id
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-target.arn
  }
}

# app target group 생성
resource "aws_lb_target_group" "app-target" {
  name     = "app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.groomVPC.id
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-target.arn
  }
}
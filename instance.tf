# web ec2 템플릿 생성
resource "aws_launch_template" "web-foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-09eb4311cbaecf89d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_security.id]
}

# app ec2 템플릿 생성
resource "aws_launch_template" "app-foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-09eb4311cbaecf89d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_security.id]
}

# web Auto Scaling 그룹 생성
resource "aws_autoscaling_group" "web" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  name               = "Web-Auto-Scaling-group"
  vpc_zone_identifier       = [aws_subnet.public-web-a.id, aws_subnet.public-web-c.id]
  target_group_arns = [aws_lb_target_group.web-target.arn]

  launch_template {
    id      = aws_launch_template.web-foobar.id
    version = "$Latest"
  }
}

# app Auto Scaling 그룹 생성
resource "aws_autoscaling_group" "app" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  name               = "App-Auto-Scaling-group"
  vpc_zone_identifier       = [aws_subnet.private-app-a.id, aws_subnet.private-app-c.id]
  target_group_arns = [aws_lb_target_group.app-target.arn]

  launch_template {
    id      = aws_launch_template.app-foobar.id
    version = "$Latest"
  }
}
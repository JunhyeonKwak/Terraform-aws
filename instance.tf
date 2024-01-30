# ec2 템플릿 생성
resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-0bc4327f3aabf5b71"
  instance_type = "t2.micro"
}

# web Auto Scaling 그룹 생성
resource "aws_autoscaling_group" "web" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  name               = "Web-Auto-Scaling-group"
  vpc_zone_identifier       = [aws_subnet.public-web-a.id, aws_subnet.public-web-c.id]

  launch_template {
    id      = aws_launch_template.foobar.id
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

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}
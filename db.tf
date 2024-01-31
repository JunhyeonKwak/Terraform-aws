# RDS 생성
resource "aws_db_instance" "primary" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  backup_retention_period = 7
  availability_zone    = "ap-northeast-2a"
  final_snapshot_identifier = "my-db-final-snapshot"
  skip_final_snapshot       = false
}

# read repplica 생성
resource "aws_db_instance" "read-replica" {
  instance_class       = "db.t3.micro"
  availability_zone    = "ap-northeast-2c"
  replicate_source_db  = aws_db_instance.primary.arn

  depends_on = [aws_db_instance.primary]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "saikrishna"
  password             = "krishna123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
resource "aws_instance" "instance1" {
  ami                         = "ami-06c68f701d8090592"
  instance_type               = "t2.micro"
  count                       = 1
  key_name                    = "test"
  vpc_security_group_ids     = ["sg-01aaac6b43fd22d1a"]
  subnet_id                   = "subnet-0de5d353d87f41a09"
  associate_public_ip_address = true
  user_data                   = "${file("data.sh")}"

  tags = {
    Name = "demoinstance"
  }
}


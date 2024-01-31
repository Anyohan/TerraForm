resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "mydb-subnet-group"
  subnet_ids = [aws_subnet.private_DB_a.id, aws_subnet.private_DB_c.id]

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_db_instance" "primary_db" {
  identifier           = "primary-db"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"  # Specify the version you want to use
  instance_class       = "db.t2.small"
  db_name              = "test"
  username             = "admin"
  password             = "12345678"
  parameter_group_name = "default.mysql5.7"
  backup_retention_period = 7
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  availability_zone      = "ap-northeast-2a"
  skip_final_snapshot  = true  

  tags = {
    Name = "PrimaryDBInstance"
  }
}

resource "aws_db_instance" "read_replica_db" {
  identifier          = "mydb-read-replica"
  replicate_source_db = aws_db_instance.primary_db.arn
  instance_class      = "db.t2.small"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true  

  tags = {
    Name = "ReadReplicaDBInstance"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS database instance"
  vpc_id      = aws_vpc.groom_vpc.id

  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_asg_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}


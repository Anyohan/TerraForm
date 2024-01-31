resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = aws_launch_configuration.Web_lc.id
  vpc_zone_identifier  = [aws_subnet.public_Web_a.id, aws_subnet.public_Web_c.id]
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
}

resource "aws_security_group" "web_asg_sg" {
  name        = "web-asg-sg"
  description = "Security group for ASG instances"
  vpc_id      = aws_vpc.groom_vpc.id

  ingress {
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]  
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WebASGInstanceSG"
  }
}


resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.App_lc.id
  vpc_zone_identifier  = [aws_subnet.private_APP_a.id, aws_subnet.private_APP_c.id]
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
}

resource "aws_security_group" "app_asg_sg" {
  name        = "app-asg-sg"
  description = "Security group for ASG instances"
  vpc_id      = aws_vpc.groom_vpc.id

  ingress {
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.nlb_sg.id] 
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # security_groups = [aws_security_group.rds_sg.id] 
  }

  tags = {
    Name = "AppASGInstanceSG"
  }
}
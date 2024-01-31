resource "aws_lb" "web_alb" {
  name               = "groom-web-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_Web_a.id, aws_subnet.public_Web_c.id]
  security_groups    = [aws_security_group.alb_sg.id]  

  tags = {
    Name = "groomWebALB"
  }
}
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.groom_vpc.id
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_autoscaling_attachment" "web_attach"{
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn   = aws_lb_target_group.web_tg.arn
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.groom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as necessary
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "alb-sg"
  }
}
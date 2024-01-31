resource "aws_lb" "app_nlb" {
  name               = "groom-app-nlb"
  load_balancer_type = "network"
  subnets            = [aws_subnet.private_APP_a.id, aws_subnet.private_APP_c.id]
  security_groups    = [aws_security_group.nlb_sg.id]  

  tags = {
    Name = "groomWebNLB"
  }
}
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.groom_vpc.id
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_autoscaling_attachment" "app_attach"{
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
  lb_target_group_arn   = aws_lb_target_group.app_tg.arn
}

resource "aws_security_group" "nlb_sg" {
  name        = "generic-security-group"
  description = "generic security group"
  vpc_id      = aws_vpc.groom_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "generic-sg"
  }
}
# ALB Configuration
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  enable_deletion_protection = false

  tags = {
    Name = "example-alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name     = "example-targets"
  port     = "443"
  protocol = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "Replace it with the existed one"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 4
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
  }
}

resource "aws_lb_target_group_attachment" "example_1" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.example_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "example_2" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.example_2.id
  port             = 80
}

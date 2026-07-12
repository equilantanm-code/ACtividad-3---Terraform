# Application Load Balancer (ALB)
resource "aws_lb" "alb_mean" {
  name               = "alb-mean-stack"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_alb_id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]

  tags = {
    Name = "ALB-MEAN"
  }
}

# Target Group: apunta al servidor de App en el puerto 80
resource "aws_lb_target_group" "tg_app" {
  name     = "tg-app-mean"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "TG-App-MEAN"
  }
}

# Listener HTTP: reenvía el tráfico del ALB al Target Group
resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb_mean.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_app.arn
  }
}

# Registra el servidor de App en el Target Group
resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.tg_app.arn
  target_id        = var.app_instance_id
  port             = 80
}

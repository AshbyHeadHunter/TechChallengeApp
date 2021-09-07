# Create our Application Load Balancer which is assigned to our public subnets.
resource "aws_alb" "main" {
  name            = "${var.app_name}-ecs-load-balancer"
  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.lb.id]
  tags = merge(tomap({
    "Name" = "${var.app_name}-ecs-load-balancer"
  }), var.tags)
}
resource "aws_alb_target_group" "app" {
  name        = "${var.app_name}-ecs-target-group"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
  tags = merge(tomap({
    "Name" = "${var.app_name}-ecs-target-group" 
  }), var.tags)
}
# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

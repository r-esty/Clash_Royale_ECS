resource "aws_lb" "this" {
 name               = "${var.project_name}-alb"
 internal           = false
 load_balancer_type = "application"
 security_groups    = [var.alb_security_group_id]
 subnets            = var.public_subnet_ids
 
 enable_deletion_protection = false
}

resource "aws_lb_target_group" "this" {
 name        = "${var.project_name}-tg"
 target_type = "ip"
 port        = 5000
 protocol    = "HTTP"
 vpc_id      = var.vpc_id
 
 health_check {
   enabled             = true
   healthy_threshold   = 2
   unhealthy_threshold = 2
   timeout             = 5
   interval            = 30
   path                = "/"
   matcher             = "200"
 }
}

resource "aws_lb_listener" "http" {
 load_balancer_arn = aws_lb.this.arn
 port              = "80"
 protocol          = "HTTP"
 
 default_action {
   type = "redirect"
   
   redirect {
     port        = "443"
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
 }
}

resource "aws_lb_listener" "https" {
 load_balancer_arn = aws_lb.this.arn
 port              = "443"
 protocol          = "HTTPS"
 certificate_arn   = var.certificate_arn
 ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
 
 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.this.arn
 }
}

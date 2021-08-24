resource "aws_lb" "network_lb" {
  name               = "networkLb"
  internal           = false
  load_balancer_type = "network"
  subnet_mapping {
    subnet_id     = aws_subnet.prod-subnet-public-1.id
    allocation_id = aws_eip.eip_nlb.id
  }

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "tf-lb-tg1"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "instance"
  health_check {
    healthy_threshold   = 3
    interval            = 30
    port                = 80
    protocol            = "TCP"
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type             = "forward"
  }
}

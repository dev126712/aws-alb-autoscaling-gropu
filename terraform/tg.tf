resource "aws_lb_target_group" "tg-test" {
  name     = "test-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id

}

resource "aws_lb_listener" "alb_listener" {

  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-test.arn
  }
  tags = {
    name = "alb-listener"

  }
}

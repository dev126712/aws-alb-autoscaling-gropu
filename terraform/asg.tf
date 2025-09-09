
resource "aws_autoscaling_group" "ec2_asg" {

  max_size            = 3
  min_size            = 2
  desired_capacity    = 2
  name                = "web-asg"
  target_group_arns   = [aws_lb_target_group.tg-test.arn]
  vpc_zone_identifier = aws_subnet.subnets[*].id
  launch_template {
    id      = aws_launch_template.test-launch_template.id
    version = "$Latest"
  }

  health_check_type = "EC2"

}

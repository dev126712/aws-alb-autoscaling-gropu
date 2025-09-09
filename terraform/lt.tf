resource "aws_launch_template" "test-launch_template" {

  name = "test-lt"

  image_id      = "ami-0b016c703b95ecbe4"
  instance_type = "t2.micro"
  key_name      = "keyyp"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = filebase64("userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      name = "ec2-web-server"
    }
  }
}

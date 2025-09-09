resource "aws_security_group" "ec2_sg" {

   name = "ec2-alb-sg"
   description = "security group for ec2 instance"
   vpc_id = aws_vpc.vpc1.id

   ingress {
      from_port = 0
      to_port = 0
     protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
      from_port = 0
      to_port = 0
     protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
    name = "ec2-sg"
   }
}

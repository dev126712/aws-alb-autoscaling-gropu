/*resource "aws_instance" "ec2-1" {
  ami                    = "ami-0b016c703b95ecbe4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "keyyp"

  tags = {
    Name = "webtier-instance1"
  }
}

resource "aws_instance" "ec2-2" {
  ami                    = "ami-0b016c703b95ecbe4"       
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "keyyp"

  tags = {
    Name = "webtier-instance2"
  }
}

resource "aws_securirty_group" "ec2_sg" {

   name = "test-ec2-sg"

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
}
*/

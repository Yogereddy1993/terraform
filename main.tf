// main.tf
provider "aws" {
  region = "us-west-2" 
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro" 
}

resource "aws_security_group" "instance" {
  name        = "instance_sg"
  description = "Security group for the instance"
  
  // Define the necessary ingress and egress rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.instance.id]

  subnets = ["subnet-0bb1c79de3EXAMPLE", "subnet-07e12b1f461EXAMPLE"]
}

resource "aws_lb_target_group" "example" {
  name     = "example-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0c2d300eEXAMPLE" 
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.example.arn
    type             = "forward"
  }
}

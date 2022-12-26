provider "aws" { 
    region = "us-east-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SecGroup.id]

  user_data                   = <<-EOF
#!/bin/bash
      echo "Hello, Terraform World" >index.html
      nohub busybox httpd -f -p 8080 &
      EOF
    
  user_data_replace_on_change = true
  tags = {
    "Name" = "Terraform-Abhinav"
  }
}

resource "aws_security_group" "SecGroup" {
  name = "Terraform-Abhinav-SecGroup"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
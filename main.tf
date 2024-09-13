provider "aws" {
  region = "us-east-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80  # Apache uses port 80 by default
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0182f373e66f89c85"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd   # Install Apache
                sudo systemctl start httpd  # Start Apache service
                sudo systemctl enable httpd # Enable Apache to start on boot
                echo "Hello, World" | sudo tee /var/www/html/index.html  # Create index.html
                EOF

  user_data_replace_on_change = true

  tags = {
    Name = "jenkins-example"
  }
}

output "public_ip" {
  value       = aws_instance.jenkins.public_ip
  description = "The public IP address of the web server"
}

#################################################################


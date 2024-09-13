# Provider configuration
provider "aws" {
  region = "us-east-2"  # Specify your preferred AWS region
}

# Security Group allowing HTTP traffic on port 8080
resource "aws_security_group" "instance" {
  name = "web-server-sg"

  # Inbound rule to allow traffic on port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP address
  }

  # Outbound rule to allow all traffic (necessary for the instance to access the internet)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance configuration
resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"  # Ubuntu 20.04 AMI for us-east-2 region
  instance_type          = "t2.micro"               # Free Tier instance
  vpc_security_group_ids = [aws_security_group.instance.id]  # Attach the security group

  # User Data script to start a simple web server that responds with "Hello, World"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true  # Replace the instance if user_data changes

  tags = {
    Name = "terraform-web-server"  # Tag for easier identification
  }
}

# Output the EC2 instance public IP address for easy access
output "instance_public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the web server instance"
}

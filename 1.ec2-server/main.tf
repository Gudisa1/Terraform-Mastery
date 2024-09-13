# Provider configuration
provider "aws" {
  region = "us-east-2"  # Replace with your preferred AWS region
}

# EC2 instance definition
resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"  # Ubuntu 20.04 AMI for us-east-2
  instance_type = "t2.micro"               # Free tier eligible instance type

  # Adding a name tag for better identification
  tags = {
    Name = "terraform-example"             # Name tag for the EC2 instance
  }
}

# Terraform Variables in AWS: A Comprehensive Guide

Terraform is a powerful Infrastructure as Code (IaC) tool that enables you to define and provision infrastructure using a declarative configuration language. One of the key features of Terraform is its ability to use variables, which makes your configurations more flexible, reusable, and easier to manage. In this guide, we'll explore how to use Terraform variables in the context of provisioning AWS resources, focusing on a real-world example.

## Introduction

Variables in Terraform allow you to parameterize your configurations, making it possible to customize and reuse your Terraform code for different environments or scenarios without altering the core configuration. By using variables, you can define values that are passed into your Terraform configuration, enabling dynamic and modular infrastructure setups.

In this example, we'll demonstrate how to use variables in a Terraform configuration to create an AWS Virtual Private Cloud (VPC) with associated subnet, security group, and an EC2 instance. This setup will showcase how variables can streamline the provisioning process and make your Terraform code more maintainable.

## Example Scenario

Let's assume we want to create a simple AWS infrastructure setup that includes:

1. A VPC with a specified CIDR block.
2. A subnet within the VPC.
3. A security group to control inbound and outbound traffic.
4. An EC2 instance running a basic web server.

We'll define our Terraform configuration in a `main.tf` file, using variables to specify the VPC CIDR block, subnet CIDR block, instance type, and other parameters.

## Defining Variables

We'll start by defining the variables in our Terraform configuration. These variables will be declared in a separate file named `variables.tf`, but for simplicity, we'll include them in our `main.tf` file in this example.

```hcl
# main.tf

# Define provider
provider "aws" {
  region = "us-east-1"
}

# Define variables
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet"
  }
}

# Create Security Group
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

# Create EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_sg.name]

  tags = {
    Name = "my-instance"
  }
}
```

## Explanation

1. **Provider Configuration**:
   The `provider "aws"` block specifies the AWS region where the resources will be provisioned.

2. **Variable Definitions**:
   - `vpc_cidr`: The CIDR block for the VPC.
   - `subnet_cidr`: The CIDR block for the subnet.
   - `instance_type`: The type of EC2 instance to launch.
   - `ami_id`: The AMI ID for the EC2 instance. This is an optional variable and should be provided during the execution.

   Variables are defined using the `variable` block and can include descriptions, types, and default values.

3. **Resource Definitions**:
   - **VPC**: The `aws_vpc` resource creates a VPC with the CIDR block specified by `var.vpc_cidr`.
   - **Subnet**: The `aws_subnet` resource creates a subnet within the VPC with the CIDR block specified by `var.subnet_cidr`.
   - **Security Group**: The `aws_security_group` resource creates a security group with rules for SSH (port 22) and HTTP (port 80) access.
   - **EC2 Instance**: The `aws_instance` resource creates an EC2 instance with the AMI ID specified by `var.ami_id` and the instance type specified by `var.instance_type`.

## Usage

To use this configuration, you'll need to create a `terraform.tfvars` file to provide values for the variables. Here's an example of how to specify these values:

```hcl
# terraform.tfvars

ami_id = "ami-0abcdef1234567890"
```

After setting up your variable values, you can initialize and apply your Terraform configuration using the following commands:

```bash
terraform init
terraform apply
```

Terraform will prompt you to confirm the changes before provisioning the resources.

## Conclusion

Using variables in Terraform allows you to create more dynamic and flexible configurations. By parameterizing your infrastructure code, you can easily adapt it to different environments and scenarios. In this example, we demonstrated how to define and use variables to create a basic AWS infrastructure setup, including a VPC, subnet, security group, and EC2 instance.

For more complex scenarios, you can expand your variable definitions and usage to include additional parameters, default values, and validation rules. Terraform's support for variables makes it an excellent tool for managing infrastructure in a scalable and maintainable way.


---


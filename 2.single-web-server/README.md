To deploy a simple web server that responds to HTTP requests using Terraform, we'll expand upon the EC2 instance setup by adding a basic web server configuration. We'll use a Bash script to create a simple web server that returns "Hello, World" and set up a security group to allow HTTP traffic on port 8080. Below is an expanded version of your initial instructions, organized step by step.

---

# Deploy a Single Web Server with Terraform

This guide will show you how to deploy a single web server in AWS using Terraform. The server will respond to HTTP requests with "Hello, World."

## Prerequisites

Before proceeding, ensure you have the following:

- **Terraform installed**: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **AWS Account**: If you don’t have one, sign up [here](https://aws.amazon.com/free/)
- **AWS CLI configured**: Run `aws configure` to set up your access credentials

---

## Step 1: Provider Configuration

We need to define the AWS provider and the region where we want to deploy our infrastructure.

1. Create a directory for your project, e.g., `terraform-web-server`.
2. Inside this directory, create a file called `main.tf` with the following content:

```hcl
provider "aws" {
  region = "us-east-2"
}
```

This block specifies that AWS is our cloud provider, and the region is `us-east-2` (Ohio). You can change the region based on your preference.

---

## Step 2: Define the Web Server

Next, let's define an EC2 instance and configure a simple web server. We will use **User Data** to run a script on the EC2 instance that serves "Hello, World" via a web server on port 8080.

Add the following code to `main.tf`:

```hcl
resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"  # Ubuntu 20.04 AMI in us-east-2
  instance_type          = "t2.micro"               # AWS Free Tier instance type

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-web-server"
  }
}
```

### Explanation:

- **user_data**: A script that runs when the instance is launched for the first time. It sets up a simple web server using BusyBox to serve the "Hello, World" content on port 8080.
- **user_data_replace_on_change**: Ensures that if the `user_data` changes, the EC2 instance is replaced, so the new script is run.
- **tags**: Adds a name tag to the EC2 instance for easier identification in the AWS Management Console.

---

## Step 3: Configure Security Group

AWS EC2 instances are protected by firewalls called **Security Groups**. By default, no incoming traffic is allowed. To allow HTTP requests on port 8080, we need to configure a security group.

Add the following block to `main.tf`:

```hcl
resource "aws_security_group" "instance" {
  name = "web-server-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }
}
```

### Explanation:

- **aws_security_group**: Defines a security group resource that allows incoming traffic on port 8080 (HTTP).
- **cidr_blocks = ["0.0.0.0/0"]**: This allows traffic from any IP address. In a production environment, you'd likely want to restrict this to known IP ranges.

---

## Step 4: Associate the Security Group with the Instance

To apply the security group to the EC2 instance, we need to reference the security group in the `aws_instance` block.

Modify the `aws_instance` block to include the following:

```hcl
vpc_security_group_ids = [aws_security_group.instance.id]
```

This associates the EC2 instance with the security group that allows traffic on port 8080. The final `aws_instance` block should look like this:

```hcl
resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-web-server"
  }
}
```

---

## Step 5: Initialize and Apply the Configuration

Now, initialize and apply the Terraform configuration to deploy your web server.

1. **Initialize Terraform**:
   In your project directory, run:

   ```bash
   terraform init
   ```

   This downloads the necessary provider plugins (AWS) and sets up the project.

2. **Plan the deployment**:
   To see what changes Terraform will make, run:

   ```bash
   terraform plan
   ```

   Terraform will show you what resources will be created.

3. **Apply the configuration**:
   To deploy the resources, run:

   ```bash
   terraform apply
   ```

   Terraform will ask for confirmation. Type `yes` and hit Enter. It will then create the EC2 instance and security group.

---

## Step 6: Access the Web Server

After the EC2 instance is created, you can find its public IP address in the AWS console or output from the Terraform apply command.

1. Open your browser and navigate to:

   ```
   http://<EC2_INSTANCE_PUBLIC_IP>:8080
   ```

2. You should see the text:

   ```
   Hello, World
   ```

Alternatively, you can use `curl` to verify the response:

```bash
curl http://<EC2_INSTANCE_PUBLIC_IP>:8080
```

---

## Step 7: Clean Up

When you're done, it's a good practice to clean up the resources to avoid incurring charges.

1. Run the following command to destroy the infrastructure:

```bash
terraform destroy
```

This will terminate the EC2 instance and delete the security group.

---


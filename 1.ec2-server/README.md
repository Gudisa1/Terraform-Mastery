# Deploy a Single EC2 Server with Terraform

This guide demonstrates how to use Terraform, a powerful Infrastructure as Code (IaC) tool, to deploy a single EC2 instance in AWS. It will walk you through setting up your provider, configuring the instance, and managing your code in version control using GitHub.

## Prerequisites

Before you start, make sure you have the following:

- **Terraform installed**: [Follow this guide to install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli). Terraform is the tool that will allow you to define and provision your cloud infrastructure.
- **AWS Account**: You need access to an AWS account to deploy your infrastructure. Sign up at [AWS](https://aws.amazon.com/free/) if you don’t have one already.
- **AWS CLI configured**: Set up the AWS CLI on your machine with proper credentials to allow Terraform to communicate with your AWS account. Run `aws configure` to set it up. [AWS CLI Setup](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

---

## Step 1: Provider Configuration

Terraform needs to know which cloud provider to work with and which region to deploy resources in. You specify this in your Terraform configuration files.

1. Create a directory for your project, e.g., `terraform-ec2-instance`.
2. Inside that directory, create a file called `main.tf`. This file will contain all of your infrastructure code.
3. In `main.tf`, specify the AWS provider:

```hcl
provider "aws" {
  region = "us-east-2"
}
```

### Explanation:
- **provider "aws"**: This block tells Terraform that we are working with the AWS cloud provider.
- **region**: Here, we are specifying the AWS region where we want to deploy resources. In this example, `us-east-2` corresponds to the Ohio region in AWS. You can choose other regions based on your needs, such as `eu-west-1` for Ireland or `ap-southeast-2` for Sydney.

---

## Step 2: Define the EC2 Instance

Once the provider is configured, the next step is to define the EC2 instance you want to launch.

1. In the same `main.tf` file, add the following block to define the EC2 instance resource:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"  # Ubuntu 20.04 AMI in us-east-2
  instance_type = "t2.micro"               # AWS Free Tier eligible instance type
}
```

### Explanation:
- **resource "aws_instance" "example"**: This block defines the creation of an AWS EC2 instance resource. The resource type (`aws_instance`) and the name (`example`) are how you reference this resource within your Terraform configuration.
- **ami**: This specifies the Amazon Machine Image (AMI) ID, which contains the OS and software to launch on your instance. In this example, `ami-0fb653ca2d3203ac1` corresponds to Ubuntu 20.04 in the `us-east-2` region. Note: AMI IDs vary by region, so if you use a different region, you'll need to find the corresponding AMI.
- **instance_type**: Specifies the type of EC2 instance you want. The `t2.micro` instance type is part of the AWS Free Tier and is great for testing as it provides 1 vCPU and 1 GB of memory.

---

## Step 3: Initialize Terraform

Before you can deploy your infrastructure, Terraform needs to initialize the project. This downloads the necessary provider plugins and sets up your local environment.

1. Open a terminal and navigate to the folder where your `main.tf` file is located.
2. Run the following command to initialize Terraform:

```bash
terraform init
```

### Explanation:
- **terraform init**: This command sets up the working directory with all necessary files for Terraform. It will download the AWS provider plugin and any other required files. The `.terraform` folder and `.terraform.lock.hcl` file will be created in the directory as part of this process.

---

## Step 4: Plan Your Deployment

Terraform allows you to preview the changes that will be made to your infrastructure before actually applying them. This is useful to check what will be created, modified, or destroyed.

1. Run the following command to see a plan of what Terraform will do:

```bash
terraform plan
```

### Explanation:
- **terraform plan**: This command scans your Terraform files and shows what infrastructure changes it will make. It helps you verify your configurations before making any real changes. In the output, you will see what resources will be added (`+`), changed (`~`), or removed (`-`).

---

## Step 5: Apply the Terraform Configuration

Once you are satisfied with the plan, you can apply the changes and deploy the infrastructure to AWS.

1. Run the following command to apply the configuration and deploy the EC2 instance:

```bash
terraform apply
```

2. Terraform will ask for confirmation before proceeding. Type `yes` and press Enter to create the resources.

### Explanation:
- **terraform apply**: This command actually makes the changes to your cloud environment based on your `main.tf` configuration. After entering `yes`, Terraform will create the EC2 instance and any other resources defined in your code. You’ll see the instance creation progress in real time in the terminal.

---

## Step 6: Add a Name Tag to the EC2 Instance

To make your EC2 instance easier to identify in the AWS Management Console, you can add tags, such as a name tag.

1. Modify the `aws_instance` resource block in `main.tf` to include a `tags` block:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}
```

2. Apply the changes with the `terraform apply` command:

```bash
terraform apply
```

### Explanation:
- **tags**: The `tags` block allows you to assign metadata to your AWS resources. Tags are key-value pairs. In this case, we're assigning a `Name` tag to the EC2 instance with the value `"terraform-example"`. This makes it easier to identify your instance in the AWS EC2 dashboard.

---






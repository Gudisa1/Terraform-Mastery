
# Setting Up AWS CLI on Your Local Machine

## Overview

The **AWS Command Line Interface (CLI)** is a powerful tool that allows you to interact with AWS services directly from your terminal. With AWS CLI, you can manage resources, automate tasks, and streamline your AWS workflow.

This guide walks you through the installation and configuration of the AWS CLI on your local machine.

---

## Prerequisites

Before you begin, ensure you have the following:
- An **AWS Account**.
- **Access keys** (Access Key ID and Secret Access Key) created from the AWS Management Console.

---

## 1. Install AWS CLI

### For macOS or Linux:

You can install the AWS CLI using the following commands:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### For Windows:

- Download the AWS CLI MSI installer from [AWS CLI Installer for Windows](https://awscli.amazonaws.com/AWSCLIV2.msi).
- Run the installer and follow the setup wizard.

Once installed, verify that AWS CLI is correctly installed by running:

```bash
aws --version
```

You should see output like this:

```
aws-cli/2.4.0 Python/3.8.8 Linux/4.14.209-160.339.amzn2.x86_64 exe/x86_64.ubuntu.20
```

---

## 2. Configure AWS CLI

After installing the AWS CLI, you need to configure it to use your AWS credentials.

Run the following command to start the configuration:

```bash
aws configure
```

You will be prompted to enter:
1. **AWS Access Key ID**: Your AWS access key.
2. **AWS Secret Access Key**: Your AWS secret key.
3. **Default Region Name**: The AWS region you want to operate in (e.g., `us-east-1`).
4. **Default Output Format**: The format you want the CLI to return results in (e.g., `json`, `text`, or `table`).

Example:

```bash
$ aws configure
AWS Access Key ID [None]: <Your-Access-Key-ID>
AWS Secret Access Key [None]: <Your-Secret-Access-Key>
Default region name [None]: us-east-1
Default output format [None]: json
```

### Configuration File Locations

Once you've configured the CLI, your credentials and settings are saved in two files:
- **Credentials File**: `~/.aws/credentials`
- **Config File**: `~/.aws/config`

You can manually edit these files later if needed.

---

## 3. Verify AWS CLI Setup

To verify the AWS CLI is working properly, you can run a simple command to list your current S3 buckets:

```bash
aws s3 ls
```

If configured correctly, you will see a list of all your S3 buckets in your AWS account.

---

## 4. Managing Multiple AWS Profiles

If you manage multiple AWS accounts, you can create different profiles by using the `--profile` flag.

### Example:

```bash
aws configure --profile <profile_name>
```

To use a specific profile in a command:

```bash
aws s3 ls --profile <profile_name>
```

### Diagram: AWS CLI Workflow (Optional)

```plaintext
+----------------------------------+
|      AWS Management Console      |
|   (Generate Access Keys Here)    |
+----------------------------------+
               |
               v
+----------------------------------+
|         Local Machine            |
|      AWS CLI Installed           |
| Configure with Access Keys:      |
| - aws configure                  |
|                                  |
| Run Commands:                    |
| - aws s3 ls                      |
+----------------------------------+
```

---

## 5. Useful AWS CLI Commands

Here are some common AWS CLI commands you can start using right away:

### EC2 Instances
- List EC2 instances:
  ```bash
  aws ec2 describe-instances
  ```

- Start an EC2 instance:
  ```bash
  aws ec2 start-instances --instance-ids <instance_id>
  ```

### S3 Buckets
- List S3 buckets:
  ```bash
  aws s3 ls
  ```

- Upload a file to S3:
  ```bash
  aws s3 cp myfile.txt s3://mybucket/myfile.txt
  ```

### IAM Users
- List IAM users:
  ```bash
  aws iam list-users
  ```

---

## 6. Troubleshooting

If you encounter issues:
- Ensure your AWS credentials are correctly configured by running `aws configure`.
- Check for typos in your AWS Access Key ID or Secret Access Key.
- Verify that the correct region is set in the configuration.

---

## 7. Further Reading

- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- [Managing Access Keys](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)

---

By following these steps, you should have the AWS CLI installed and fully configured on your local machine, ready to manage AWS resources directly from the command line.




# Installing Terraform on Your Local Machine

## Overview

**Terraform** is an open-source infrastructure as code tool by HashiCorp that allows you to define and provision infrastructure across various cloud platforms. This guide will walk you through installing Terraform on your local machine and verifying that it's set up correctly.

---

## 1. Install Terraform

### For macOS/Linux (using package manager):

1. **Install using Homebrew** (for macOS):

    ```bash
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    ```

2. **Install using APT (for Ubuntu/Linux)**:

    First, update your system and install the necessary dependencies:

    ```bash
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    ```

    Add the HashiCorp GPG key:

    ```bash
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    ```

    Add the official HashiCorp Linux repository:

    ```bash
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    ```

    Now, install Terraform:

    ```bash
    sudo apt-get update && sudo apt-get install terraform
    ```

### For Windows:

- Download the Terraform Windows installer from the [official Terraform website](https://www.terraform.io/downloads.html).
- Run the installer and follow the installation instructions.

---

## 2. Verify Terraform Installation

Once installed, you can verify that Terraform is installed correctly by running the following command in your terminal:

```bash
terraform -version
```

You should see output similar to this:

```
Terraform v1.1.7
on linux_amd64
```

This confirms that Terraform is successfully installed on your system.

---

## Conclusion

Now that you have Terraform installed and verified, you're ready to start managing infrastructure! For further steps, refer to the official [Terraform documentation](https://www.terraform.io/docs).

---


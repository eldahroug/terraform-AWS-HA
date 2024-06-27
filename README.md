# terraform-AWS-HA

AAWS Infrastructure with Terraform

This project sets up an AWS infrastructure using Terraform, including a VPC, subnets, an internet gateway, a NAT gateway, security groups, EC2 instances, and an Application Load Balancer (ALB).
Prerequisites

    Terraform
    AWS credentials configured

Usage

Clone the repository:
``
https://github.com/eldahroug/terraform-AWS-HA.git
cd terraform-AWS-HA
``

Initialize Terraform:

  ```terraform init```

Plan the infrastructure:

```terraform plan```

Apply the configuration:


```    terraform apply ```

Infrastructure Overview

VPC and Subnets

    VPC: Your diagram shows a VPC, which matches the aws_vpc resource in the code with the CIDR block 10.0.0.0/16.
    Subnets:
        Public Subnet 1 (10.0.1.0/24) in AZ 2a
        Public Subnet 2 (10.0.3.0/24) in AZ 2b
        Private Subnet 1 (10.0.2.0/24) in AZ 2a
        Private Subnet 2 (10.0.4.0/24) in AZ 2b

These subnets match the subnets defined in the Terraform code.
Internet Gateway and NAT Gateway

    Internet Gateway: The diagram shows an Internet Gateway, which corresponds to aws_internet_gateway.main.
    NAT Gateway: The diagram places the NAT Gateway in Public Subnet 1, which aligns with the aws_nat_gateway.main definition using an Elastic IP from aws_eip.nat.

Route Tables and Associations

    Public Route Table: The diagram shows public subnets with a route to the Internet Gateway, matching aws_route_table.public and its associations.
    Private Route Table: The diagram shows private subnets with a route to the NAT Gateway, matching aws_route_table.private and its associations.

Security Groups

    ALB Security Group: Allows HTTPS (443) traffic, which matches aws_security_group.alb_sg.
    Instance Security Group: Allows HTTP (80) traffic from the ALB, which matches aws_security_group.instance_sg.

Load Balancer

    ALB: The diagram includes an ALB in the public subnets, corresponding to aws_lb.example.
    Listener: The listener is set for HTTPS on port 443, as defined in aws_lb_listener.https.
    Target Group: The target group is configured to forward traffic to instances on port 80, matching aws_lb_target_group.example.

EC2 Instances

    EC2 Instances: Two instances running Nginx in the private subnets, corresponding to aws_instance.example_1 and aws_instance.example_2.


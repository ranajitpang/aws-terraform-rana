# aws-terraform-rana
This is a personal self learning project 1

In this project 1, we are trying to acheive below steps through AWS terraform

Objectives are mentions in below steps:

Steps 1-5 are done in <a href="https://github.com/ranajitpang/aws-terraform-rana/blob/main/project1-lb-ec2-vpc/vpc.tf">vpc.tf</a>
1. Create a default VPC
2. Create 2 Public Subnet in different available zone say us-east-1a and us-east-1b.
3. Associate 2 subnet in default main route table
4. Creating an internet gateway and attached to above VPC.
5. Associate Internet gateway to the main route table.

Steps 6: Create 2 EC2 intances in each subnet and adding script to create static web page and health check page. <a href="https://github.com/ranajitpang/aws-terraform-rana/blob/main/project1-lb-ec2-vpc/ec2intances.tf">ec2intances.tf</a>

Steps 7-9 are done in <a href="https://github.com/ranajitpang/aws-terraform-rana/blob/main/project1-lb-ec2-vpc/alb.tf">alb.tf</a>
7. Create a Load balancer, load balancer security group, target group.
8. Add load balancer lister to the load balancer.
9. Test the whole set up by hitting to the load balancer domain url.

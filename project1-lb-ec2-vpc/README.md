# aws-terraform-rana
This is a personal self learning project 1

In this project 1, we are trying to acheive below steps through AWS terraform

steps 
1. Create a default VPC
2. Create 2 Public Subnet in different available zone say us-east-1a and us-east-1b.
3. Associate 2 subnet in default main route table
4. Creating an internet gateway and attached to above VPC.
5. Associate Internet gateway to the main route table.
6. Create 2 EC2 intances in each subnet and adding script to create static web page and health check page.
7. Create a Load balancer, load balancer security group, target group.
8. Add load balancer lister to the load balancer.
9. Test the whole set up by hitting to the load balancer domain url.
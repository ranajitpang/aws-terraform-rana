
#creating a default VPC
# Creating 2 subnet
# creating internet gateway
#associate subnet and internet gateway with default route table
# adding ingress and egress on default main network


#Setting provider
provider "aws" {
  region = "us-east-1"
}


#Creating Private vpc

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "demo-vpc"
    }
}

# Creating Public subnets under demovpc

resource "aws_subnet" "public-subnet1" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "public-subnet1"
    }
}

resource "aws_subnet" "public-subnet2" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "public-subnet2"
    }
}

#Creating an internet gatway and attach to demo-vpc

resource "aws_internet_gateway" "vpc-igw" {
    vpc_id = aws_vpc.demo-vpc.id

    tags = {
        Name = "Internet-gateway"
    }
}


#Association of route table with subnet

resource "aws_route_table_association" "demo-rtb-association1" {
  route_table_id = aws_vpc.demo-vpc.main_route_table_id
  subnet_id = aws_subnet.public-subnet1.id
}

resource "aws_route_table_association" "demo-rtb-association2" {
  route_table_id = aws_vpc.demo-vpc.main_route_table_id
  subnet_id = aws_subnet.public-subnet2.id
}

# adding internet gatway to the main route table


resource "aws_route" "route" {
  route_table_id         = aws_vpc.demo-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc-igw.id
}

#association of ingress and egress to main nacl

resource "aws_network_acl_rule" "bar1" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "bar2" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "bar3" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "bar4" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "bar5" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
resource "aws_network_acl_rule" "bar6" {
  network_acl_id = aws_vpc.demo-vpc.default_network_acl_id
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}


#Creating nacl 



#using deafult security group and adding inbound and outbound rules.


resource "aws_security_group_rule" "rule1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}

resource "aws_security_group_rule" "rule2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}

resource "aws_security_group_rule" "rule3" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}


resource "aws_security_group_rule" "rule4" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}

resource "aws_security_group_rule" "rule5" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}

resource "aws_security_group_rule" "rule6" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.demo-vpc.default_security_group_id
}

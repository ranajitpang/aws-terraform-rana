#Creating an EC2 instance in subnet1 and adding user_data to create simple html page

resource "aws_instance" "web-server1" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_vpc.demo-vpc.default_security_group_id}"]
    key_name = "devenv"
    user_data = "${file("script.sh")}"
    subnet_id = aws_subnet.public-subnet1.id
    associate_public_ip_address = "true"
    
    tags = {
        name = "Linux-app1"
    }
}

#Creating an EC2 instance in subnet2 and adding user_data to create simple html page
resource "aws_instance" "web-server2" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_vpc.demo-vpc.default_security_group_id}"]
    key_name = "devenv"
    user_data = "${file("script2.sh")}"
    subnet_id = aws_subnet.public-subnet2.id
    associate_public_ip_address = "true"
    
    tags = {
        name = "Linux-app2"
    }
}

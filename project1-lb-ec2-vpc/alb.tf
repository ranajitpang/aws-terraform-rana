# creating a LB security_group

  resource "aws_security_group" "lb-sg" {
    name = "loadbalancerSG"
    description = "Security group for my ALB"
    vpc_id = aws_vpc.demo-vpc.id

    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }


#creating loadbalacer and target group and attach to a listener.

resource "aws_lb_target_group" "web-it-tg" {
    target_type = "instance"
    name = "webtg"
    port = "80"
    protocol = "HTTP"
    vpc_id = "${aws_vpc.demo-vpc.id}"
}

resource "aws_lb_target_group_attachment" "web-tg-attach1" {
    target_group_arn = "${aws_lb_target_group.web-it-tg.arn}"
    target_id = "${aws_instance.web-server1.id}"
    port = "80"
}

resource "aws_lb_target_group_attachment" "web-tg-attach2" {
    target_group_arn = "${aws_lb_target_group.web-it-tg.arn}"
    target_id = "${aws_instance.web-server2.id}"
    port = "80"
}

resource "aws_lb" "web-lb" {
    name = "weblb"
    internal = "false"
    load_balancer_type = "application"
    subnets = ["${aws_subnet.public-subnet1.id}", "${aws_subnet.public-subnet2.id}"]
    security_groups = ["${aws_security_group.lb-sg.id}"]
}

resource "aws_lb_listener" "web-lb-listener" {
    load_balancer_arn = "${aws_lb.web-lb.id}"
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.web-it-tg.id}"
    }
}

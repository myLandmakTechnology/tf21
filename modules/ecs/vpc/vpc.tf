resource "aws_vpc" "main" {
    cidr_block      = var.vpc_cidr
    tags = {
        Name = "Blitline2${var.Blitline2_env}Stack-${var.vpc_cidr}"
    }

}

resource "aws_network_acl" "Blitline2Stack-Public" {
    vpc_id = aws_vpc.main.id

    egress {
        protocol    = "-1"
        rule_no     = 99
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = "0"
        to_port     = "0"
    }

    ingress{
        protocol    = "-1"
        rule_no     = 99
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   =  "0"
        to_port     =  "0"

    }
    tags = {

        Name = "Blitline2${var.Blitline2_env}Stack-Public"
        Reach = "public"
    }
}


resource "aws_network_acl" "Blitline2Stack-Private" {
    vpc_id = aws_vpc.main.id

    egress {
        protocol    = "-1"
        rule_no     = 99
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   =  "0"
        to_port     =  "0"

    }

    ingress{
        protocol    = "-1"
        rule_no     = 99
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   =  "0"
        to_port     =  "0"
    }
    tags = {
        Name = "Blitline2${var.Blitline2_env}Stack-Private"
        Reach = "private"
    }
}

resource "aws_vpc_peering_connection" "Blitline2-dev-peer" {
  peer_vpc_id   = var.peer_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true
  

}
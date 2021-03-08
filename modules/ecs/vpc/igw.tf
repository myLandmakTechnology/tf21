#Internet gateway resource
resource "aws_internet_gateway" "gw" {
  vpc_id    =   aws_vpc.main.id
  tags = {
      Name = "Blitline2${var.Blitline2_env}Stack-${var.vpc_cidr}"
  }
}



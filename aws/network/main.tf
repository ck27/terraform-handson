resource "random_integer" "random" {
  min = 1
  max = 9
}

resource "aws_vpc" "mtc_vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "mtc-vpc-${random_integer.random.id}"
  }
}


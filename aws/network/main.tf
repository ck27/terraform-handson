data "aws_availability_zones" "available" {

}

resource "random_integer" "random" {
  min = 1
  max = 9
}
resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}
resource "aws_vpc" "mtc_vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "mtc-vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "mtc_public_subnet" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "mtc-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "mtc_private_subnet" {
  count                   = length(var.private_cidrs)
  vpc_id                  = aws_vpc.mtc_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "mtc-private-subnet-${count.index + 1}"
  }
}
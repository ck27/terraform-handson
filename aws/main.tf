module "network" {
  source = "./network"

  vpc_cidr = "10.0.0.0/18"
  max_subnets = 10
  public_cidrs  = [for i in range(2, 6, 2) : cidrsubnet("10.0.0.0/16", 8, i)]
  private_cidrs = [for i in range(1, 6, 2) : cidrsubnet("10.0.0.0/16", 8, i)]
}
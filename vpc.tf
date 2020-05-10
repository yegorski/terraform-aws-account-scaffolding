data "aws_availability_zones" "available" {
  state = "available"
}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "2.9.0"

#   name = "VPC"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#  tags = "${ merge(
#     map( "Name", "VPC" ),
#     var.tags}"
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.66.0"

  name = "Main"
  cidr = "10.0.0.0/16"
#   cidr = "${ var.vpc_cidr }"

  azs = "${ slice( data.aws_availability_zones.available.names, 1, var.vpc_number_of_azs ) }"

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true

#   map_public_ip_on_launch = true

  tags = "${ var.tags }"
}

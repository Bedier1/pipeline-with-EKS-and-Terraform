#create  vpc module
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
   version = "3.19.0"
    name = "vpc-dev"
    cidr= "12.0.0.0/16"
    azs = ["eu-central-1a","eu-central-1b"]
    private_subnets = ["12.0.1.0/24","12.0.3.0/24"]
    public_subnets = ["12.0.5.0/24","12.0.7.0/24"]
    public_route_table_tags = {
        Name = "public"
    }
    public_subnet_names = ["public"]
    private_subnet_names = ["private"]
    create_database_subnet_group =  true 
    create_database_subnet_route_table = true 
    database_subnets = ["12.0.15.0/24","12.0.16.0/24"]
    enable_dns_hostnames = true 
    enable_dns_support =  true
    public_subnet_tags = {
        "Name" = "public"
        "kubernetes.io/role/elb" = 1
        "kubernetes.io/cluster/eksdemo" = "shared"
    }
    private_subnet_tags = {
        "Name" = "private"
        "kubernetes.io/role/internal-elb" = 1
        "kubernetes.io/cluster/eksdemo" = "shared"
    }
    database_subnet_tags = {
        "Name" = "database"
    }
    vpc_tags = {
        Name = "myvpccc"
    }
}
output "vpc_id" {
    value = module.vpc.vpc_id
} 
output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
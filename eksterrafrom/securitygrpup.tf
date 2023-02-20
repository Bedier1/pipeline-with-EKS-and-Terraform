module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  name        = "bastion_security_wtih_ssh"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["ssh-tcp"]
  egress_rules = ["all-all"]
  tags = {
    "Name" = "bastion_security_wtih_ssh"
  }

  }

output "mysg" {
    value = module.security-group.security_group_id
  
}
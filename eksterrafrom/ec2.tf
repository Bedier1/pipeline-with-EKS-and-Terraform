/*module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
    name = "bastion"
      version = "~> 3.0"


  ami                    = data.aws_ami.amzn.id
  instance_type          = "t2.micro"
  key_name               = "bedier"
  monitoring             = false
  vpc_security_group_ids = [module.security-group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  
   
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
*/
data "aws_ami" "amzn" {
  
  most_recent      = true
  owners           = ["amazon"]
 
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}
output "mymi" {
  value = data.aws_ami.amzn.id
}
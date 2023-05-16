data "aws_vpc" "pkVpc" {
  #id = "vpc-8c4afcf4"
  id = var.vpc_id
}

resource "aws_security_group" "apacheMod-SG" {
  name        = "apacheMod-SG"
  description = "Apache Kucas Server Security Group flex"
  vpc_id      = data.aws_vpc.pkVpc.id

  ingress {
		description      = "HTTP"
		from_port        = 80
		to_port          = 80
		protocol         = "tcp"
		cidr_blocks      = ["0.0.0.0/0"]
		ipv6_cidr_blocks = []
	  }
	  
  ingress {
		description      = "SSH"
		from_port        = 22
		to_port          = 22
		protocol         = "tcp"
		cidr_blocks      = [var.my_id_with_cidr]
		ipv6_cidr_blocks = []
	  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "PK_Sec_Group"
  }
}

resource "aws_instance" "apacheInstance" {
	ami           = "ami-0889a44b331db0194"
	instance_type = var.instance_type
	key_name = "${aws_key_pair.deployerApache.key_name}"
	vpc_security_group_ids = [aws_security_group.apacheMod-SG.id]
	user_data = data.template_file.user_data.rendered
  tags = {
	Name = var.server_name
  }
}


resource "aws_key_pair" "deployerApache" {
  key_name   = "deployer-key-apache"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAxSNXQ7O+l+LicSK4t96vg0rE0qgOJXl91AD6ZRVGVLev1sQMP9ZNcHL97h6q5OfCTPoK9+FGex+h7m/rUrkjxOm8C9VKH0WDzNg+Apnh0ZS9FxwpMNEHord526vX8YDlvl2teWL0Rkc4XuFX2z1o0WLs+042lOzmGeDXjIS62YcmFAhKfrGm/zukAHH0XjU8Xv4Ew73r6NKFXG2rhj00gjqh4VAc/CR16TlQOr0mDPX29e8UI1b35mtzxJf0korE0iEQBj1aarDfMu5v4tWkQA87nt7RzBkPcUGl36vXesu+P1eSENGf9XLFiXlBWquInc+2SPr3D/NLBrhGEsZ1 rsa-key-20230516"
}


data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

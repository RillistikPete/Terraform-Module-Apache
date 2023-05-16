Terraform module to provision an EC2 instance that is running Apache.

Not intended for production use. Just showcasing how to create a custom module on Terraform Registry.


```hcl
terraform {

}

provider "aws" {
     region = "us-east-1"
}

module "apache-Guy" {
	source = ".//terraform-aws-apache-module"
	vpc_id = "vpc-00000000x"
	my_id_with_cidr = "my IP here /32"
	public_key = "ssh-rsa AAA...."
	instance_type = "t2.micro"
	server_name = "Apache pk Server"
}

output "public_ip" {
	value = module.apache-Guy.public_ip
}

```
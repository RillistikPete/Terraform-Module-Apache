variable "vpc_id" {
	type = string
}

variable "my_id_with_cidr" {
	type = string
	description = "Provide your IP here 199.231.199.21 not 136.56.71.63/32"
}

variable "public_key" {
	type = string
}

variable "instance_type" {
	type = string
	default = "t2.micro"
}

variable "server_name" {
	type = string
	default = "Apache pk Server"
}
variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0080e4c5bc078760e"
}

variable "ebs_optimized" {
	default = true
}

variable "instance_type" {
	default = "t2.micro"
}

variable "volume_type" {
	default = "gp2"
}

variable "volume_size" {
	default = "1"
}

variable "device_name" {
	default = "/dev/sdc"
}

variable "encrypted" {
	default = false
}

variable "delete_on_termination" {
	default = false
}

variable "iam_instance_profile" {
	default = "Jenkins-role"
}

variable "admin_acct" {
	default = "admin-jnk"
}

variable "ssh_key" {
	default = ""
}
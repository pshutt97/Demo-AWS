provider "aws" {
  region  = var.region
}

terraform {
  required_version = ">= 0.12"
}

resource "aws_iam_user" "instanceManageUser" {
  name = var.admin_acct
}
resource "aws_iam_access_key" "instanceManageUser" {
  user = "${aws_iam_user.instanceManageUser.name}"
}
resource "aws_iam_user_policy" "instanceManageUser_assume_role" {
  name = "InstanceManagePolicy"
  user = "${aws_iam_user.instanceManageUser.name}"
policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                 "ec2:DisassociateAddress",
                 "ec2:DeleteSubnet",
                 "ec2:DescribeAddresses",
                 "ec2:DescribeInstances",
                 "ec2:DescribeInstanceAttribute",
                 "ec2:CreateVpc",
                 "ec2:AttachInternetGateway",
                 "ec2:DescribeVpcAttribute",
                 "ec2:AssociateRouteTable",
                 "ec2:DescribeInternetGateways",
                 "ec2:DescribeNetworkInterfaces",
                 "ec2:CreateInternetGateway",
                 "ec2:CreateSecurityGroup",
                 "ec2:DescribeVolumes",
                 "ec2:DescribeAccountAttributes",
                 "ec2:ModifyVpcAttribute",
                 "ec2:DescribeKeyPairs",
                 "ec2:DescribeNetworkAcls",
                 "ec2:DescribeRouteTables",
                 "ec2:DescribeInstanceStatus",
                 "ec2:ReleaseAddress",
                 "ec2:ImportKeyPair",
                 "ec2:DescribeTags",
                 "ec2:DescribeVpcClassicLinkDnsSupport",
                 "ec2:CreateRouteTable",
                 "ec2:DetachInternetGateway",
                 "ec2:DisassociateRouteTable",
                 "ec2:AllocateAddress",
                 "ec2:DescribeInstanceCreditSpecifications",
                 "ec2:DescribeSecurityGroups",
                 "ec2:DescribeVpcClassicLink",
                 "ec2:DescribeImages",
                 "ec2:DescribeVpcs",
                 "ec2:DeleteVpc",
                 "ec2:AssociateAddress",
                 "ec2:CreateSubnet",
                 "ec2:DescribeSubnets",
                 "ec2:DeleteKeyPair",
                 "route53:CreateHostedZone",
                 "route53:ListHostedZones",
                 "sts:GetCallerIdentity"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::dummy_bucket"
        }
    ]
}
EOF
}


module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "deployer"
  public_key = var.ssh_key

}

resource "aws_instance" "ec2_example" {
  iam_instance_profile = var.iam_instance_profile
  ebs_optimized = var.ebs_optimized
  availability_zone = "us-east-1a"
  ami           = var.ami
  instance_type = var.instance_type
  ebs_block_device {
  	delete_on_termination = var.delete_on_termination
  	volume_size = var.volume_size
  	volume_type = var.volume_type
  	device_name = var.device_name
  	encrypted = var.encrypted
  }
}

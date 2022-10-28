#########################  AWS PROFILE  #########################

provider "aws" {
  region     = var.aws_region
  profile    = var.aws_profile != "" ? var.aws_profile : null
  access_key = var.aws_profile == "" ? var.aws_access_key : null
  secret_key = var.aws_profile == "" ? var.aws_secret_key : null
}

#########################  AWS RESOURCES  #########################

resource "aws_instance" "openvpn" {
  ami                         = var.openvpn_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.openvpn.name]
  key_name                    = var.enable_ssh_access ? aws_key_pair.openvpn[0].key_name : null
  user_data = templatefile(
    "${path.module}/userdata.sh",
    {
      vpn_username = var.vpn_username,
      vpn_password = var.vpn_password == "" ? random_string.vpn_password.result : var.vpn_password
    }
  )
  #  user_data                   = data.template_file.userdata.rendered

  tags = {
    Name = "OpenVPN Access Server"
  }
}

resource "aws_security_group" "openvpn" {
  name        = "OpenVPN Server Security Group"
  description = "This security group is based on recommended settings for OpenVPN Access Server provided by OpenVPN Inc."

  tags = {
    Name = "OpenVPN Server Security Group"
  }

  ingress {
    description = "Web access to the portal"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access to the server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP ports"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 945
    to_port     = 945
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "openvpn" {
  count      = var.enable_ssh_access ? 1 : 0
  key_name   = "openvpn-key"
  public_key = var.public_key
}


#########################  VARIABLES #########################

variable "aws_profile" {
  default = ""
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "openvpn_ami" {
  default = "ami-0764964fdfe99bc31"
}

variable "enable_ssh_access" {
  default = false
}

variable "public_key" {
  default = ""
}

variable "vpn_username" {
  default = "openvpn"
}

variable "vpn_password" {
  default = ""
}

resource "random_string" "vpn_password" {
  length = 16
}

#########################  OUTPUTS  #########################

output "public_ip" {
  value = aws_instance.openvpn.public_ip
}

output "vpn_username" {
  value = var.vpn_username
}

output "vpn_password" {
  value = random_string.vpn_password.result
}

variable "REGION" {
  default = "us-east-1"
}
variable "AZ" {
  default = "us-east-1a"
}
variable "PUB_KEY" {
  default = "servers_key.pub"
}
variable "PRIV_KEY" {
  default = "servers_key"
}

variable "JENKINS_UBUNTU_AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-09cd747c78a9add63"
  }
}
variable "SONAR_UBUNTU_AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0263e4deb427da90e"
  }
}
variable "NEXUS_CENT_OS_AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-002070d43b0a4f171"
  }
}
variable "TOMCAT_UBUNTU_AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-09cd747c78a9add63"
  }
}

variable "UBUNTU_USER" {
  default = "ubuntu"
}
variable "CENT_OS_USER" {
  default = "ec2-user"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
resource "aws_key_pair" "cicd-key" {
  key_name   = "servers_key"
  public_key = file("servers_key.pub")
}

# Jenkins EC2 Instance Ubuntu 20
resource "aws_instance" "Jenkins_Ubuntu_Server" {
  ami                    = var.JENKINS_UBUNTU_AMIS[var.REGION]
  instance_type          = "t2.medium"
  availability_zone      = var.AZ
  key_name               = aws_key_pair.cicd-key.key_name
  vpc_security_group_ids = [aws_security_group.Jenkins_Server_sg.id]
  tags = {
    Name    = "Jenkins_Server"
    Project = "JavaWebApp01"
  }
  provisioner "file" {
    source      = "jenkins_web.sh"
    destination = "/tmp/jenkins_web.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod u+x /tmp/jenkins_web.sh", "sudo /tmp/jenkins_web.sh"]
  }
  connection {
    type        = "ssh"
    user        = var.UBUNTU_USER
    private_key = file("servers_key")
    host        = self.public_ip
  }
}

# Sonarqube Ubuntu 18 Server
resource "aws_instance" "SonarQ_Ubuntu_Server" {
  ami                    = var.SONAR_UBUNTU_AMIS[var.REGION]
  instance_type          = "t2.medium"
  availability_zone      = var.AZ
  key_name               = aws_key_pair.cicd-key.key_name
  vpc_security_group_ids = [aws_security_group.Sonar_Server_sg.id]
  tags = {
    Name    = "SonarQ_Server"
    Project = "JavaWebApp01"
  }
  connection {
    type        = "ssh"
    user        = var.UBUNTU_USER
    private_key = file("servers_key")
    host        = self.public_ip
  }
}

# Nexus Cent OS 7 Server
resource "aws_instance" "Nexus_Cent_OS_Server" {
  ami                    = var.NEXUS_CENT_OS_AMIS[var.REGION]
  instance_type          = "t2.medium"
  availability_zone      = var.AZ
  key_name               = aws_key_pair.cicd-key.key_name
  vpc_security_group_ids = [aws_security_group.Nexus_Server_sg.id]
  tags = {
    Name    = "Nexus_Server"
    Project = "JavaWebApp01"
  }
  connection {
    type        = "ssh"
    user        = var.CENT_OS_USER
    private_key = file("servers_key")
    host        = self.public_ip
  }
}

# Tomcat Ubuntu 20 Server
resource "aws_instance" "Tomcat_Server" {
  ami                    = var.TOMCAT_UBUNTU_AMIS[var.REGION]
  instance_type          = "t2.medium"
  availability_zone      = var.AZ
  key_name               = aws_key_pair.cicd-key.key_name
  vpc_security_group_ids = [aws_security_group.Tomcat_Server_sg.id]
  tags = {
    Name    = "Tomcat_Server"
    Project = "JavaWebApp01"
  }
  connection {
    type        = "ssh"
    user        = var.UBUNTU_USER
    private_key = file("servers_key")
    host        = self.public_ip
  }
}

# Jenkins output
output "PublicIP_Jenkins" {
  value = aws_instance.Jenkins_Ubuntu_Server.public_ip
}
output "PublicDNS_Jenkins" {
  value = aws_instance.Jenkins_Ubuntu_Server.public_dns
}

# Sonar output
output "PublicIP_Sonar" {
  value = aws_instance.SonarQ_Ubuntu_Server.public_ip
}
output "PublicDNS_Sonar" {
  value = aws_instance.SonarQ_Ubuntu_Server.public_dns
}

# Nexus output
output "PublicIP_Nexus" {
  value = aws_instance.Nexus_Cent_OS_Server.public_ip
}
output "PublicDNS_Nexus" {
  value = aws_instance.Nexus_Cent_OS_Server.public_dns
}

# Tomcat output
output "PublicIP_Tomcat" {
  value = aws_instance.Tomcat_Server.public_ip
}
output "PublicDNS_Tomcat" {
  value = aws_instance.Tomcat_Server.public_dns
}
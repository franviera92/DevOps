# Configure the AWS Provider
provider "aws" {
  //version = "~> 2.0"
  region  = "us-east-1"
  access_key = "AKIA2I4MNFLYSXVIOPVA"
  secret_key = "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"
}
resource "aws_security_group" "public_sg" {
  name = "test_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops" {
  ami = "ami-04b9e92b5572fa0d1"
  instance_type = "t2.micro"
  key_name = "devops"
  security_groups = ["${aws_security_group.public_sg.name}"]
  
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 15
  }
  tags = {
    Name = "devops"
  }
  connection {
    type = "ssh"
    host= self.public_ip
    user = "ubuntu"
    private_key=file("./devops.pem")
    //agent = true
    timeout = "3m"
  }
  /*provisioner "remote-exec" {
  inline = ["sudo hostnamectl set-hostname devops.test"]
  }*/
  provisioner "file" {
    source      = "InstallAnsible.sh"
    destination = "/tmp/InstallAnsible.sh"
  }
  provisioner "file" {
    source      = "docker/hosts"
    destination = "/tmp/hosts"
  }
  provisioner "file" {
    source      = "docker/docker-install.yml"
    destination = "/tmp/docker-install.yml"
  }
  provisioner "file" {
    source      = "bennu_jobs_sh/Dockerfile"
    destination = "/tmp/Dockerfile"
  }
  provisioner "file" {
    source      = "bennu_jobs_sh/entrypoint.sh"
    destination = "/tmp/entrypoint.sh"
  }
  provisioner "file" {
    source      = "bennu_jobs_missing/Dockerfile"
    destination = "/tmp/Dockerfile-2"
  }
  provisioner "remote-exec" {
    inline = [
      #ERROR: /bin/bash^M: bad interpreter: No such file or directory
      #«/bin/bash^M», nos indica que tenemos los intros de DOS (Windows) posiblemente por haber sido editado con dicho sistema operativo.
      #Para corregirlo simplemente deberemos usar la utilidad dos2unix de la siguiente forma:
      #dos2unix nombrescript.sh
      #Si no tenemos instalada la herramienta podemos instalarla ejecutando el siguiente comando: yum -y install dos2unix
      "sudo apt-get update",
      "sleep 30",
      "sudo apt-get install dos2unix -y",
      "sudo dos2unix /tmp/InstallAnsible.sh",
      "sudo chmod +x /tmp/InstallAnsible.sh",
      "/tmp/InstallAnsible.sh args",
    ]
  }

  provisioner "file" {
    source      = "docker/hosts"
    destination = "/tmp/host"
  }
  provisioner "file" {
    source      = "docker/docker-install.yml"
    destination = "/tmp/docker-install.yml"
  }
  provisioner "remote-exec" {
    inline = ["ansible-playbook -i localhost -vv /home/ubuntu/docker/docker-install.yml" ]
  }
  
}
# Configure the AWS Provider
provider "aws" {
  //version = "~> 2.0"
  region  = "us-east-1"
  access_key = "AKIA6PWGRWWINURSZQ2D"
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
  
  connection {
    type = "ssh"
    host= self.public_ip
    user = "ubuntu"
    private_key=file("./devops.pem")
    //agent = true
    timeout = "3m"
  }
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
    inline = ["ansible-playbook -u root --private-key ./devops.pem -i localhost -vvvvv /home/ubuntu/docker/docker-install.yml" ]
  }
  
}
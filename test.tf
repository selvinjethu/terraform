provider "aws" {
  region = "us-east-1"
  profile = "dev"
}


resource "aws_instance" "web" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  count = 1
  vpc_security_group_ids = [
    "sg-043fa81204ac9ced3"
  ]
  user_data = <<EOF
#!/bin/bash
sudo echo "ubuntu:data2go!" | chpasswd
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart


EOF
  
}

output "instances" {
  value       = "${aws_instance.web.*.private_ip}"
  description = "PrivateIP address details"
}

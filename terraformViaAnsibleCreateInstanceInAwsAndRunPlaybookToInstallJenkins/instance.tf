resource "aws_security_group" "allow-ssh" {
  name        = "ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_instance" "instance_with_ebs" {
 
   ami = var.AMIS[var.AWS_REGION]
   instance_type = "t2.micro"
   key_name = aws_key_pair.mykey.key_name 
   vpc_security_group_ids = [aws_security_group.allow-ssh.id]
   subnet_id = aws_subnet.main-public-1.id
   
   provisioner "local-exec" {

   command = "sleep 60; ansible-playbook -u centos -i '${self.public_ip},' --private-key ${var.PATH_TO_PRIVATE_KEY} jenkins_server_preparation.yml --tags=jenkins"

   }



   tags = {

     Name= "InstanceWithEBS"   
 
   }

}

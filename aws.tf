provider "aws" {
  # Configure the AWS Provider
  region = "us-east-2"
  shared_credentials_file = "/root/awscredentials"
  profile = "testing"
}
resource "aws_instance" "web" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  user_data = "sudo apt update; sudo apt update; sudo apt install python3 -y; sudo apt install docker.io -y sudo apt install python3-docker -y sudo apt install python -y"
  count=2
  #subnet_id = "subnet-0b2ff3014f0507633"
  key_name = "aazw"
  vpc_security_group_ids = [aws_security_group.my_servers.id]

}

resource "aws_security_group" "my_servers" {
  name        = "my_security group"
  description = "my_security group 1"
  #vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

output "first_ip" {
  value = "${aws_instance.web[0].public_ip}"
}
output "second_ip" {
  value = "${aws_instance.web[1].public_ip}"
}

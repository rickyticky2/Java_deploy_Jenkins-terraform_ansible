provider "aws" {
  # Configure the AWS Provider
  access_key = "XXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXX"
  region = "us-east-2"
}
resource "aws_instance" "web" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  user_data = "sudo apt update; sudo apt-get update;  sudo apt install python3-y;"
  count=2
  #subnet_id = "subnet-0b2ff3014f0507633"
  key_name = "aazw"
  vpc_security_group_ids = [aws_security_group.my_servers.id]

}



output "first_ip" {
  value = "${aws_instance.web[0].public_ip}"
}
output "second_ip" {
  value = "${aws_instance.web[1].public_ip}"
}

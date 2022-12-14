### ec2 instance 
resource "aws_instance" "arday_ec2" {
  ami           = "ami-0beaa649c482330f7"
  instance_type = "t3.micro"
  key_name = "sandbox"
  vpc_security_group_ids =  [aws_security_group.arday_sg.id]

   root_block_device {
    volume_size = 16
  }
  tags = {
    Name = "ROOBLE-BEELO-WAAYE"
  }

}

output "instance_public_dns" {
  value = aws_instance.arday_ec2.public_dns
}

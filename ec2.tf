### ec2 instance 


resource "aws_instance" "arday_ec2" {
  # ami = "ami-0beaa649c482330f7"
  ami                    = data.aws_ami.ubuntu_server.id
  instance_type          = "t3.micro"
  key_name               = "sandbox"
  subnet_id              = aws_subnet.main-public.id
  vpc_security_group_ids = [aws_security_group.arday_sg.id]
  # get_password_data = true

  # user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 30
  }
  tags = {
    Name = "Ubuntu-server"
    # Name = "Windows-server"
  }

}


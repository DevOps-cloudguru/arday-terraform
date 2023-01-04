### ec2 instance 

# Get the latest Windows Server 2022 AMI
data "aws_ami" "windows_server" {
  most_recent = true
  owners      = ["801119661308"]
  # owners = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

# Get latest Ubuntu Server
data "aws_ami" "ubuntu_server" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "arday_ec2" {
  ami = "ami-0beaa649c482330f7"
  # ami           = data.aws_ami.ubuntu_server.id
  instance_type = "t3.micro"
  key_name      = "sandbox"
  # subnet_id = aws_subnet.main-public.id
  vpc_security_group_ids = [aws_security_group.arday_sg.id]
  # get_password_data = true

  # user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 30
  }
  tags {
    Name = "Ubuntu-server"
    # Name = "Windows-server"
  }

}

#the outputs will go to their dedicated files
output "instance_public_dns" {
  value = aws_instance.arday_ec2.public_dns
}

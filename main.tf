# 
# file: main.tf
# 
# Contains resources for the Ansible testing infrastructure

terraform {
  backend "s3" {
    bucket = "ansible-testing-tfstates"
    key = "state/ansible-testing-terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_ebs_volume" "playbook_test_data" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"

  tags {
    Name    = "playbook_tester"
    Project = "liatrio"
  }
}

resource "aws_instance" "momona" {
  ami = "ami-1853ac65"
  instance_type = "t2.micro"
}

resource "aws_volume_attachment" "momona_data" {
  device_name  = "/dev/sdh"
  volume_id    = "${aws_ebs_volume.playbook_test_data.volume_id}"
  instance_id  = "${aws_instance.momona.id}"
  skip_destroy = true
}



resource "aws_security_group" "ssh_sg" {
  name        = "allow_ssh"
  description = "All SSH traffic"

  tags {
    Project = "hackathon_pipeline"
    Name    = "hackathon_sg_ssh"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

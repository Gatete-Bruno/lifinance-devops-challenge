resource "aws_security_group" "k8s_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (adjust for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS
  }

  # Kubernetes Control Plane (Port 6443)
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust to trusted IPs for API server access
  }

  # NodePort Services (Ports 30000-32767)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow external access to NodePort services
  }

  # Longhorn Services (Ports 9500-9509)
  ingress {
    from_port   = 9500
    to_port     = 9509
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow external access to NodePort services
  }

 # Kubelet API Services (Ports 10250 - 10255)
  ingress {
    from_port   = 10250
    to_port     = 10255
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow external access to NodePort services
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "k8s-sg"
  }
}

resource "aws_instance" "k8s_nodes" {
  ami           = "ami-0182f373e66f89c85"  # Ubuntu Server 22.04 LTS AMI
  instance_type = "t3.medium"
  count         = 3  # Create 3 EC2 instances for Kubernetes

  key_name = "batman-key-pair"  # Replace with your actual key pair name

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  subnet_id              = aws_subnet.public.id

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl start docker
    usermod -aG docker $USER
  EOF

  tags = {
    Name = "k8s-node-${count.index}"
  }
}

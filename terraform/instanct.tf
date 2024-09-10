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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "k8s_nodes" {
  ami           = "ami-0dba2cb6798deb6d8"  # Ubuntu 20.04
  instance_type = "t3.medium"
  count         = 3  # Three EC2 nodes for Kubernetes cluster

  security_groups = [aws_security_group.k8s_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    # Install Docker
    apt-get update
    apt-get install -y docker.io

    # Install Kubernetes tools
    apt-get install -y kubelet kubeadm kubectl

    # Disable swap
    swapoff -a

    # Initialize the cluster (on master node)
    if [ "${count.index}" == "0" ]; then
      kubeadm init --pod-network-cidr=10.244.0.0/16
    fi
  EOF
}

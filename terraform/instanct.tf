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
  ami           = "ami-0a5c3558529277641"  # Amazon Linux 2 AMI (64-bit x86)
  instance_type = "t3.medium"
  count         = 3  # Three EC2 nodes for Kubernetes cluster

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]  # Use security group ID here
  subnet_id              = aws_subnet.public.id  # Ensure it uses the public subnet

  user_data = <<-EOF
    #!/bin/bash
    # Install Docker
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    usermod -a -G docker ec2-user

    # Install Kubernetes tools
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl

    # Disable swap (required for Kubernetes)
    swapoff -a

    # Initialize the cluster (on master node)
    if [ "${count.index}" == "0" ]; then
      kubeadm init --pod-network-cidr=10.244.0.0/16
    fi
  EOF
}

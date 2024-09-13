# Lifinance DevOps Challenge

This repository contains two APIs, `bird` and `birdImage`, which are Dockerized and deployed on AWS infrastructure. The project focuses on setting up production-grade infrastructure using Infrastructure as Code (IaC) and Kubernetes.

For a Detailed Documentation of the above, please check out my blog.

https://gatete.hashnode.dev/bird-api-written-in-golang-code-to-containerization-cicd-pipelines-deployed-aws-infra-with-kubernetes-and-monitoring

## Project Overview

- **bird API**: Provides bird-related data.
- **birdImage API**: Displays bird images that change with each refresh.

## Features

- Dockerized APIs for easy container management.
- AWS infrastructure using Terraform.
- Kubernetes manifests for running Golang APIs.
- Observability and scaling using Helm charts.
  
## Prerequisites

- **Docker**: Ensure Docker is installed on your local machine.
- **Terraform**: For managing AWS infrastructure.
- **AWS CLI**: Configure AWS credentials on your machine.
- **kubectl**: For managing Kubernetes clusters.
  
## Setup and Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/lifinance-devops-challenge.git
    cd lifinance-devops-challenge
    ```

2. **Docker Setup**:
   - Build the images:
     ```bash
     docker build -t bird-api ./bird
     docker build -t bird-image-api ./birdImage
     ```
   - Create Docker network:
     ```bash
     docker network create bird-net
     ```

## Access Locally

- Access the `bird API` at `http://localhost:4200`.
- Access the `birdImage API` at `http://localhost:4201`.


3. **Run Containers**:
    ```bash
    docker-compose up
    ```

4. **Terraform AWS Infrastructure**:
   - Navigate to the `terraform` directory and apply the configuration:
     ```bash
     cd terraform
     terraform init
     terraform apply
     ```

5. **Kubernetes Setup**:
   - Navigate to K8s-Bootstrap and then ensure you have setup the ssh keys as required
     ```bash
    ansible-playbook -i hosts.init ping.yaml
    ansible-playbook -i hosts.init setup-kubernete-cluster
     ```


6. **Kubernetes Deployment**:
   - Deploy the K8s manifests to your Kubernetes cluster using the provided manifests.
     ```bash
     kubectl apply -f k8s/
     ```




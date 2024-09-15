# Lifinance DevOps Challenge

This repository contains two APIs, `bird` and `birdImage`, which are Dockerized and deployed on AWS infrastructure. The project focuses on setting up production-grade infrastructure using Infrastructure as Code (IaC) and Kubernetes.

For detailed documentation and a step-by-step guide, please check out the accompanying blog post:

https://gatete.hashnode.dev/bird-api-written-in-golang-code-to-containerization-cicd-pipelines-deployed-aws-infra-with-kubernetes-and-monitoring

## Project Overview

- **bird API**: Provides bird-related data.
- **birdImage API**: Displays bird images that change with each refresh.

## Features

- Dockerized APIs for easy container management.
- AWS infrastructure setup using Terraform.
- Kubernetes manifests for deploying Golang APIs.
- Observability and scaling using Helm charts.

## Prerequisites

Ensure you have the following tools installed on your machine:

- **Docker**
- **Terraform**
- **AWS CLI**
- **kubectl**

## Setup and Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/lifinance-devops-challenge.git
    cd lifinance-devops-challenge
    ```

2. **Docker Setup**:
   - Build the Docker images:
     ```bash
     docker build -t bird-api ./bird
     docker build -t bird-image-api ./birdImage
     ```
   - Create a Docker network (only once):
     ```bash
     docker network create bird-net
     ```
   - Run both containers on the network:
     ```bash
     docker run -d --name bird-image-api --network bird-net -p 4200:4200 bruno74t/bird-image-api
     docker run -d --name bird-api --network bird-net -p 4201:4201 bruno74t/bird-api
     ```

3. **Terraform AWS Infrastructure Setup**:
   - Navigate to the `terraform` directory and apply the configuration:
     ```bash
     cd terraform
     terraform init
     terraform apply
     ```

4. **Kubernetes Cluster Setup**:
   - Set up your Kubernetes cluster using Ansible:
     ```bash
     ansible-playbook -i hosts.init ping.yaml
     ansible-playbook -i hosts.init setup-kubernete-cluster.yaml
     ```

5. **Kubernetes Deployment**:
   - Deploy the Kubernetes manifests:
     ```bash
     kubectl apply -f k8s/
     ```

## Access Publically

- Access the `bird API` at `http://3.88.157.155:32493/`.
- Access the `birdImage API` at `http://3.88.157.155:31708/`.

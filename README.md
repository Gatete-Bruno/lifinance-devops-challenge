# Lifinance DevOps Challenge

This repository contains two APIs, `bird` and `birdImage`, which are Dockerized and deployed on AWS infrastructure. The project focuses on setting up production-grade infrastructure using Infrastructure as Code (IaC) and Kubernetes.

## Project Overview

- **bird API**: Provides bird-related data.
- **birdImage API**: Displays bird images that change with each refresh.

## Features

- Dockerized APIs for easy container management.
- Production-grade AWS infrastructure using Terraform.
- Kubernetes manifests for running APIs.
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
   - Deploy the APIs to your Kubernetes cluster using the provided manifests.
     ```bash
     kubectl apply -f k8s/
     ```

## Usage

- Access the `bird API` at `http://localhost:8080`.
- Access the `birdImage API` at `http://localhost:8081`.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

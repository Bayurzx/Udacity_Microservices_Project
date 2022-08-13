#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="bayurzx/microserviceml:v1.0.0"
echo "This is your Docker ID/path: ${dockerpath}"

# Step 2
# Run the Docker Hub container with kubernetes
echo -e "\nRun the Docker Hub container with kubernetes"
kubectl run microproject --image=$dockerpath --port=80 --labels app=microserviceml

# Step 3:
# List kubernetes pods
echo -e "\nList kubernetes pods"
kubectl get po

# Step 4:
# Forward the container port to a host
echo -e "\nForward the container port to a host"
kubectl port-forward microproject 8000:80

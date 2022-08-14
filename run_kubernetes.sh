#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="bayurzxsmtp/microserviceml:v1.0.0"
echo "This is your Docker ID/path: ${dockerpath}"

# Step 2
# Run the Docker Hub container with kubernetes
echo -e "\nRun the Docker Hub container with kubernetes"
kubectl run microproject --image=$dockerpath --port=80 --labels app=microserviceml

# Step 3:
# List kubernetes pods
echo -e "\nList kubernetes pods"
kubectl get po

echo -e "\nSleep for 1min"
sleep 1m

echo -e "\nList kubernetes pods"
kubectl get po

# Step 4:
# Forward the container port to a host
echo -e "\nForward the container port to a localhost at port 8001"
kubectl port-forward microproject 8001:80

# Make the prediction
echo -e "Running the prediction script here\n"
./make_prediction2.sh


kubectl cp microproject:output_txt_files/kubernetes_out.txt output_txt_files/kubernetes_out.txt
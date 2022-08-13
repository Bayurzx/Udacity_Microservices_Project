#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="bayurzx/microserviceml:v1.0.0"
echo -e "Your docker path is ${dockerpath} \n" 

# Step 2:  
# Authenticate & tag
docker login
docker tag microserviceml ${dockerpath}

# Step 3:
# Push image to a docker repository
docker push ${dockerpath}
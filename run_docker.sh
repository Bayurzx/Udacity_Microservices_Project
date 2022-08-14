#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
echo "Build image and add a descriptive tag"

docker build -t microserviceml .

# Step 2: 
# List docker images
echo -e "\nList docker images"
docker images

# Step 3: 
# Run flask app
echo -e "\nRun flask app on port 8000"
echo -e "\nopen: http://localhost:8000"
docker run -p 8000:80 microserviceml &

echo "Waiting for 2 minutes"
sleep 2m

# Make the prediction
echo -e "Running the prediction script here\n"
./make_prediction.sh

sleep 30s

# Remember to add command to copy the docker_out.txt file
echo -e "Copying docker_out.txt from the running container \n"
docker cp $(docker ps | awk 'NR>1 {print $1, $2}' | grep "microserviceml" | awk '{print $1}'):/app/output_txt_files/docker_out.txt ./output_txt_files/docker_out.txt
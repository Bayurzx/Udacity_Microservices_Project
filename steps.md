## Environment
Used the AWS ec2 ssh environment to run most of the code
- CLoned and renamed the project folder with `git clone https://github.com/udacity/DevOps_Microservices.git project`
- Activate and create a virtual environment with this
``` sh
python3 -m venv ~/.devops
source ~/.devops/bin/activate
```
  - I had to used `pyenv` to use the python version `3.7.9`. I had issues using later version
- Installed make with `apt` and used it to configure my virtual environment with the Makefile present

### Lint Checks
- Installed hadolint with
``` sh
wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64
chmod +x /bin/hadolint
```
- run `make lint` to run lint checks on source code
![make lint](project\screenshots\make_lint.jpg)

### Docker
- I was using Docker Desktop to run my docker commands on linux Subsystem and Windows after numerous issue pulling my image from the hub with kubernetes, I decided to use a remote machine with the advantage of network speed
- To install docker on linux follow: [this link](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04#prerequisites)
- Checkout fireship's docker breakdown: [here](https://www.youtube.com/watch?v=gAkwW2tuIqE)
  
### Install Minikube
Followed this tutorial on minikube site
- Installed kubectl first on the [kubernetes main site](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- Then installed [docker too](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04#prerequisites)
- Finally [installed minikube](https://minikube.sigs.k8s.io/docs/start/)
- Checkout [this too](https://computingforgeeks.com/how-to-install-minikube-on-ubuntu-debian-linux/)


## Task1: Complete the Dockerfile
Docker can build images automatically by reading the instructions from a Dockerfile. The Dockerfile contains all the commands a user could call on the command line to assemble an image.

- `FROM` is provided for you; the FROM instruction initializes a new build stage and sets the base image for subsequent instructions. It specifies Python3 as the base image for this application. The rest of the Dockerfile instructions are left for you to complete.
- `WORKDIR`: Specify a working directory. (Sorta like `cd`)
- `COPY`: I copied all files from source code for the docker image with `COPY . .`
- `RUN`: Install any dependencies in requirements.txt (do not delete the commented # hadolint ignore statement).
  - Notice that `--no-cache-dir` was used. Check reasons [here](https://stackoverflow.com/a/45594808/10690280)
``` Dockerfile
RUN pip install --no-cache-dir --upgrade pip &&  pip install --no-cache-dir -r requirements.txt
```
- Expose a port when the container is created; port 80 is standard. `EXPOSE 80`
- Specify that the app runs at container launch. This is to run the app: `CMD ["python", "app.py"]`
  - `CMD` commands are run in arrays and arranged with precedence

## Task 2: Run a Container & Make a Prediction
In order to run a containerized application, you’ll need to build and run the docker image that you defined in the `Dockerfile`, and then you should be able to test your application, locally
- In `run_docker.sh` we will write the scripts to 
  - to build image from the Dockerfile 
  - Run the containerized Flask app and recieve it at port 8000 from 80
  - I add something of my own:
    - Added `sleep` to make the script wait for some thime and run `make_prediction`
    - Ran `docker cp ...` command to copy the log file '`docker_out.txt`' I automated in the `app.py` file
- Running the complete script:
  - run `./run_docker.sh`
![make prediction](project\screenshots\make_prediction.jpg)

## Task 3: Improve Logging & Save Output
- Added the command to log prediction in app.py
  - I will use `docker cp` to retrieve it
![make prediction](project\screenshots\make_prediction2.jpg)

## Task 4: Upload the Docker Image
- Upload your Docker image with the `upload_docker.sh`
  - Define a dockerpath
    - Recall that your docker username is your unique docker ID.
  - Authenticate and tag image `aka` `docker login` and `docker tag` `<image>`
  - push your docker image `docker push --[OPTIONS] NAME[:TAG]`
![running docker](project\screenshots\run_docker_pass.jpg)

## Task 5: Configure Kubernetes to Run Locally
We already installed minikube and kubectl so we are good to go

## Task 6: Deploy with Kubernetes and Save Output Logs
- `run_kubernetes.sh`: 
  - Define a dockerpath `"bayurzx/microserviceml:v1.0.0"`
  - Run the docker container with `kubectl`
  - List the kubernetes pods
  - Forward the container port to a host port, used port 8001 this time. I had 8000 running before

## Task 7: `[Important]` Delete Cluster
- delete the kubernetes cluster with a call to `minikube delete`.

## Task 8: CircleCI Integration
- Create new file @ `.circleci/config.yml`
- [status badge](https://circleci.com/docs/2.0/status-badges/) into the Github project's README.md file.
[![Bayurzx](https://circleci.com/gh/Bayurzx/Udacity_Microservices_Project.svg?style=svg)](https://app.circleci.com/pipelines/github/Bayurzx/Udacity_Microservices_Project)

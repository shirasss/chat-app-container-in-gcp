#!/bin/bash

read -p "enter the version to build and run: "  version

appname="chat-app"
image_name="${appname}:${version}"


docker volume create chat-app-data
# Connect to the instance via SSH
ssh -o StrictHostKeyChecking=shira_shani-instance-SA@34.0.67.27

artifact_registry_image=me-west1-docker.pkg.dev/grunitech-mid-project/shira-shani-chat-app-images/${appname}:${version}
# Pull&run the specified versioned image from the Artifact registry

# docker build -t  chat-app:$version .
# docker run -v chat-app-data:/chatApp/data -p 5000:5000 --name chat-app-container-$version chat-app:$version

gcloud compute ssh shira-shani-first-instance --project grunitech-mid-project --zone me-west1-a 
gcloud auth login
docker pull ${artifact_registry_image}
docker run -d ${artifact_registry_image}

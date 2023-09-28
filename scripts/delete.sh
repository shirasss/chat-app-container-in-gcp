#!/bin/bash

read -p "Enter the version to delete: " version

image_name="chat-app:$version"
container_name="chat-app-container-$version"

gcloud compute ssh shira-shani-first-instance --project grunitech-mid-project  --zone me-west1-a 
# # Stop and remove the container (if it exists)
# docker rm -f "$container_name" 

# # Remove the image (if it exists)
# docker rmi "$image_name"

echo "Cleanup completed, deleted all images and containers of the chat-app project of the given version."


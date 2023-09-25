#!/bin/bash

# Display Docker container information
echo "------ Docker Containers ------"
docker ps -a

# Display Docker image information
echo -e "\n------ Docker Images ------"
docker images

# Display Docker volume information
echo -e "\n------ Docker Volumes ------"
docker volume ls

# Display Docker network information
echo -e "\n------ Docker Networks ------"
docker network ls

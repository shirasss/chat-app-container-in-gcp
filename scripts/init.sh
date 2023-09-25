#!/bin/bash

read -p "enter the version to build and run: "  version


docker volume create chat-app-data
docker build -t  chat-app:$version .
docker run -v chat-app-data:/chatApp/data -p 5000:5000 --name chat-app-container-$version chat-app:$version
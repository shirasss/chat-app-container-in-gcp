#!/bin/bash

# Prune Docker containers
docker container prune -f

# Prune Docker images (including unused ones)
docker image prune -af

# Prune Docker volumes
docker volume prune -f

# Prune Docker networks
docker network prune -f

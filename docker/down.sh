#!/bin/bash

set -e

echo "Bringing down Docker Compose services..."
docker-compose down --volumes --remove-orphans

echo "Pruning unused Docker resources..."
docker system prune -f

echo "Removing dangling images..."
docker image prune -f

echo "Removing all stopped containers..."
docker container prune -f

echo "Removing unused volumes..."
docker volume prune -f

echo "Docker cleanup complete. Ready for fresh build."

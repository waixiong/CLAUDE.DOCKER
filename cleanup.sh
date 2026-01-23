#!/bin/bash

# Cleanup script for claude-code Docker images
# Removes old/dangling images related to this Dockerfile

set -e

IMAGE_NAME="claude-code"

echo "Cleaning up old $IMAGE_NAME Docker images..."

# Remove dangling images (untagged images from previous builds)
echo "Removing dangling images..."
docker image prune -f

# Remove all images with the claude-code name except the latest
echo "Checking for old $IMAGE_NAME images..."
OLD_IMAGES=$(docker images "$IMAGE_NAME" --format "{{.ID}}" | tail -n +2)

if [ -n "$OLD_IMAGES" ]; then
    echo "Removing old $IMAGE_NAME images..."
    echo "$OLD_IMAGES" | xargs -r docker rmi -f
else
    echo "No old $IMAGE_NAME images found."
fi

# Remove stopped containers using this image
echo "Removing stopped containers..."
STOPPED_CONTAINERS=$(docker ps -a --filter "ancestor=$IMAGE_NAME" --filter "status=exited" -q)

if [ -n "$STOPPED_CONTAINERS" ]; then
    echo "$STOPPED_CONTAINERS" | xargs -r docker rm
else
    echo "No stopped containers found."
fi

echo "Cleanup complete!"

# Show remaining images
echo ""
echo "Remaining $IMAGE_NAME images:"
docker images "$IMAGE_NAME"

docker run --name kokoro_service --restart always --network host --gpus all ghcr.io/remsky/kokoro-fastapi-gpu:v0.2.2

docker rm -f kokoro_service
docker network create app-network
docker network create crown-network

docker run --name kokoro_service --restart always --network app-network --network crown-network --gpus all ghcr.io/remsky/kokoro-fastapi-gpu:v0.2.2

docker-compose down

# Stop everything first
docker-compose -f docker/gpu/docker-compose.yaml down
docker rm -f kokoro_service audiobook_creator

# Clean up all related networks
docker network rm app-network crown-network gpu_app-network

# Create fresh networks
docker network create app-network
docker network create crown-network

# Start kokoro service with correct network and port
docker run --name kokoro_service \
    --restart always \
    --network app-network \
    --gpus all \
    -p 8880:8880 \
    ghcr.io/remsky/kokoro-fastapi-gpu:v0.2.2

# Verify network connection
docker network inspect app-network

# Verify port mapping
docker port kokoro_service
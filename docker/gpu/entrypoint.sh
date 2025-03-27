#!/bin/bash
set -e

# Install curl if not available
if ! command -v curl &> /dev/null; then
    echo "curl not found, installing..."
    apt-get update && apt-get install -y curl
fi

# Start Ollama in the background
ollama serve &

# Wait for Ollama to be ready
echo "Waiting for Ollama server to start..."
while ! curl -s http://localhost:11434/api/tags >/dev/null; do
  sleep 1
done

# First, list available models
echo "Available models from Ollama:"
ollama list

# Pull Llama 3.1 (8B) - newer and better than Llama 3
echo "Pulling Llama 3.1 (8B) model..."
ollama pull llama3.1:8b || echo "Failed to pull Llama 3.1, but continuing..."

# Pull Qwen 2.5 (7B) - for comparison and compatible with your GPU
echo "Pulling Qwen 2.5 (7B) model..."
ollama pull qwen2.5:7b || echo "Failed to pull Qwen 2.5, but continuing..."

# Remove older models if they exist to save space
echo "Checking for older models to remove..."
if ollama list | grep -q "llama3:latest"; then
  echo "Removing older Llama 3 model to save space..."
  ollama rm llama3 || echo "Failed to remove Llama 3, but continuing..."
fi

# List final available models
echo "Final available models:"
ollama list

# Keep the container running
wait
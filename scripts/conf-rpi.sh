#!/bin/bash

# Exit immediately if any command fails
set -e

echo "Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

echo "Installing Docker..."
sudo apt-get install -y docker.io

echo "Verifying Docker installation..."
sudo docker --version

echo "Setting up Docker to run without sudo..."
sudo usermod -aG docker $USER

echo "Installing Docker Compose..."
sudo apt-get install -y docker-compose

echo "Verifying Docker Compose installation..."
docker-compose --version

echo "Docker and Docker Compose have been installed successfully. Please log out and log back in to apply changes to user groups."

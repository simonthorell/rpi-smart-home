#!/bin/bash

# Exit immediately if any command fails
set -e

# Color codes
BOLD_GREEN="\033[1;32m"
RESET="\033[0m"

echo "${BOLD_GREEN}Updating system packages...${RESET}"
sudo apt-get update
sudo apt-get upgrade -y

# Let smarthome get access to zigbee dongle
echo "${BOLD_GREEN}Giving smarthome user access to dialout...${RESET}"
sudo usermod -a -G dialout $(whoami)

# Give smarthome user access to rpi-smart-home directory
echo "${BOLD_GREEN}Giving smarthome user access to rpi-smart-home directory...${RESET}"
sudo chown -R $(whoami):$(whoami) /home/smarthome/rpi-smart-home

echo "${BOLD_GREEN}Installing Docker...${RESET}"
sudo apt-get install -y docker.io

echo "${BOLD_GREEN}Verifying Docker installation...${RESET}"
sudo docker --version

echo "${BOLD_GREEN}Setting up Docker to run without sudo...${RESET}"
sudo usermod -aG docker $USER

echo "${BOLD_GREEN}Installing Docker Compose...${RESET}"
sudo apt-get install -y docker-compose

echo "${BOLD_GREEN}Verifying Docker Compose installation...${RESET}"
docker-compose --version

echo "${BOLD_GREEN}Docker and Docker Compose have been installed successfully. Please log out and log back in to apply changes to user groups.${RESET}"

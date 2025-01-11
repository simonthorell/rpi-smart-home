#!/bin/bash

# Exit on any error
set -e

# Variables
DOCKER_COMPOSE_FILE="$(dirname $(dirname $(realpath $0)))/docker-compose.yml"
ZIGBEE_SERVICE="zigbee2mqtt"
DEVICE_MAPPING="/dev/ttyACM0"

# Function to find ZigBee USB stick
detect_zigbee_device() {
  echo "Detecting ZigBee USB device..."
  local device=$(ls /dev/serial/by-id/ | grep 'usb-Texas_Instruments')
  if [ -z "$device" ]; then
    echo "Error: No ZigBee USB device found. Please ensure it is connected and try again."
    exit 1
  fi
  echo "$device"
}

# Detect ZigBee device path
DEVICE_PATH="/dev/serial/by-id/$(detect_zigbee_device)"
echo "ZigBee USB device detected at: $DEVICE_PATH"

# Update docker-compose.yml
if grep -q "$ZIGBEE_SERVICE" "$DOCKER_COMPOSE_FILE"; then
  echo "Updating $DOCKER_COMPOSE_FILE with device mapping..."
  sed -i "/services:/,/volumes:/ s#- /dev/serial/by-id/.*:$DEVICE_MAPPING#- $DEVICE_PATH:$DEVICE_MAPPING#" "$DOCKER_COMPOSE_FILE"
  echo "Updated device mapping for $ZIGBEE_SERVICE in docker-compose.yml."
else
  echo "Error: $ZIGBEE_SERVICE service not found in $DOCKER_COMPOSE_FILE."
  exit 1
fi

# Output success message
echo "Configuration updated successfully. You can now start the Docker Compose setup with the updated device mapping."
echo "Run the following command to start the services:"
echo "docker-compose up -d"

#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Define the directory containing the scripts
SCRIPT_DIR="./scripts"

# Make the scripts executable
chmod +x "$SCRIPT_DIR/conf-rpi.sh"
chmod +x "$SCRIPT_DIR/conf-zigbee.sh"
chmod +x "$SCRIPT_DIR/conf-boot.sh"

# Run the scripts in order
"$SCRIPT_DIR/conf-rpi.sh"
"$SCRIPT_DIR/conf-zigbee.sh"
"$SCRIPT_DIR/conf-boot.sh"

echo "Setup executed successfully!"
#!/bin/bash

# Exit on any error
set -e

# Variables
SERVICE_NAME="smarthome"
WORKING_DIR="$(dirname $(dirname $(realpath $0)))"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

# Create systemd service file
echo "Creating systemd service file at $SERVICE_FILE..."
sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=Smart Home Docker Compose Service
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=$WORKING_DIR
ExecStart=/usr/bin/docker-compose up -d
ExecStop=/usr/bin/docker-compose down
Restart=always
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd configuration
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling $SERVICE_NAME service..."
sudo systemctl enable $SERVICE_NAME

# Start the service immediately
echo "Starting $SERVICE_NAME service..."
sudo systemctl start $SERVICE_NAME

# Verify the service status
echo "Checking $SERVICE_NAME service status..."
sudo systemctl status $SERVICE_NAME --no-pager

# Prompt for reboot
echo "Setup complete. It is recommended to reboot your system to ensure everything works as expected."
read -p "Do you want to reboot now? (y/n): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
  echo "Rebooting..."
  sudo reboot
else
  echo "Reboot skipped. Please reboot manually to complete the setup."
fi

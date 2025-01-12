# SmartHome Scripts

# `conf-boot.sh`

This script replace running manual commands to run the docker-compose services on startup or reboot explained below:

### 1. Create a systemd service file

```sh
sudo nano /etc/systemd/system/homebridge.service
```

Add the following:

```sh
[Unit]
Description=Smart Home Docker Compose Service
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=/path/to/your/docker-compose-folder
ExecStart=/usr/bin/docker-compose up
ExecStop=/usr/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

Replace `/path/to/your/rpi-smart-home` with the full path to the directory containing your docker-compose.yml.

Save and exit the file (Press Ctrl+O to save and Ctrl+X to exit).

## 2. Reload systemd and enable the service

Reload systemd to recognize the new service file:

```sh
sudo systemctl daemon-reload
```

Enable the service to start on boot:

```sh
sudo systemctl enable smarthome
```

Start the service immediately:

```sh
sudo systemctl start smarthome
```

Verify the Service:

```sh
sudo systemctl status smarthome
```

## 3. Reboot and Test

Reboot your Raspberry Pi to ensure the service starts automatically:

```sh
sudo reboot
```

After rebooting, verify that all services are running using:

```sh
docker ps
```

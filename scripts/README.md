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
ExecStart=/usr/bin/docker-compose up -d
ExecStop=/usr/bin/docker-compose down
Restart=always
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

<br><br>

# `conf-zigbee.sh`

This script replace finding your attached Zigbee pheripheral/dongle as per process explained below:

### Locate your ZigBee Pheripheral

List connected devices to locate your ZigBee USB stick:

```sh
ls /dev/serial/by-id/
```

Look for an entry resembling:

```sh
# Example 1 (Skyconnect)
usb-Nabu_Casa_Home_Assistant_Connect_ZBT-1_eee059dfa939ef11b57253f454516304-if00
# Example 2 (Texas Instruments)
usb-Texas_Instruments_TI_CC2531_USB_CDC___0X00124B0018ED3DDF-if00
```

Check where the symlink points:

```sh
ls -l /dev/serial/by-id/usb-Nabu_Casa_Home_Assistant_Connect_ZBT-1_eee059dfa939ef11b57253f454516304-if00-port0
```

Open `docker-compose.yml` and update this line with your entry under zigbee2mqtt service:

```sh
devices:
      - /dev/serial/by-id/usb-Nabu_Casa_Home_Assistant_Connect_ZBT-1_eee059dfa939ef11b57253f454516304-if00:/dev/ttyUSB0
```

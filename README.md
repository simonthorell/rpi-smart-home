# rpi-smart-home

RaspberryPi Docker Compose Smart Home Configuration

## Configure ZigBee on RaspberryPi

### 1. SSH into your RPi

```sh
ssh pi@<IP-ADDRESS>
```

Replace <IP-ADDRESS> with the IP address of your Raspberry Pi.

Enter the default password (if unchanged): `raspberry`.

### 2. Locate your ZigBee Pheripheral

List connected devices to locate your ZigBee USB stick:

```sh
ls /dev/serial/by-id/
```

Look for an entry resembling:

```sh
usb-Texas_Instruments_TI_CC2531_USB_CDC___0X00124B0018ED3DDF-if00
```

Open `docker-compose.yml` and update this line with your entry under zigbee2mqtt service:

```sh
devices:
      - /dev/serial/by-id/usb-Texas_Instruments_TI_CC2531_USB_CDC___0X00124B0018ED3DDF-if00:/dev/ttyACM0
```

## Run Configuration on boot

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

# Links

- [Homebridge Docker](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Docker#install-homebridge)
- [Zigbe2MQTT Docker](https://www.zigbee2mqtt.io/guide/installation/02_docker.html#docker-compose)

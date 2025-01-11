# rpi-smart-home

RaspberryPi Docker Compose Smart Home Configuration

## Flash RaspberryOS to RPi

1. Download the [Rasberry Pi Imager](https://www.raspberrypi.com/software/)
2. Select the following:

- Device: _Select the appropriate RPi device you use_.
- OS: Raspberry Pi OS (64-bit).
- Storage: Mount an empty SD-card and select it.

3. When prompted to add custom settings, say `yes`and press `Edit Settings`:

- Set your hostname to `smarthome`
- Set a password of choice
- Enter your WIFI network SSID and password.
- Set locale settings as per your preference.
- Enable SSH with password authentication.

4. When flashing is complete, insert the SD-card in the RPi and boot it up.

## SSH into your RPi

```sh
ssh smarthome@smarthome.local

# If this would not work, you can also try with IP-address
ssh smarthome@<IP-ADDRESS>
```

Enter the password you set in the flash process.

## Clone the `rpi-smart-home` repository

```sh
git clone https://github.com/simonthorell/rpi-smart-home.git && cd rpi-smart-home
```

## Run the setup script

```sh
chmod +x setup.sh && ./setup.sh
```

# Links

- [Homebridge Docker](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Docker#install-homebridge)
- [Zigbe2MQTT Docker](https://www.zigbee2mqtt.io/guide/installation/02_docker.html#docker-compose)

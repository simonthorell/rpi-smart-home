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

## Update the RPi

```sh
sudo apt-get update && apt-get upgrade -y
```

Enter the password if prompted.

## Clone the `rpi-smart-home` repository

```sh
git clone https://github.com/simonthorell/rpi-smart-home.git && cd rpi-smart-home
```

## Run setup scripts

Make the scripts executable:

```sh
chmod +x ./scripts
```

1. Run the RPi config script:

```sh
./scripts/conf-rpi.sh
```

_*** You may get promted to reboot after this executed. If so, say `yes` and reboot. You will need to SSH back into the device as per previous step and continue from here. ***_

2. Run the Zigbee script:

```sh
./scripts/conf-zigbee.sh
```

3. Run the boot script:

```sh
./scripts/conf-boot.sh
```

_*** You may get promted to reboot after this executed. If so, say `yes` and reboot. You will need to SSH back into the device as per previous step and continue from here. ***_

## Get your RPi host IP address

Run the following command and note down the first IP-address in the list.

```sh
hostname -I
```

_It should look something like 192.168.XX.XXX_

# Links

- [Homebridge Docker](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Docker#install-homebridge)
- [Zigbe2MQTT Docker](https://www.zigbee2mqtt.io/guide/installation/02_docker.html#docker-compose)

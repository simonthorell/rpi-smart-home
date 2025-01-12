# rpi-smart-home

RaspberryPi Docker Compose Smart Home Configuration

---

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

---

## SSH into your RPi

```sh
ssh smarthome@smarthome.local

# If this would not work, you can also try with IP-address
ssh smarthome@<IP-ADDRESS>
```

Enter the password you set in the flash process.

---

## Update the RPi

```sh
sudo apt-get update && apt-get upgrade -y
```

Enter the password if prompted.

---

## Clone the `rpi-smart-home` repository

```sh
git clone https://github.com/simonthorell/rpi-smart-home.git && cd rpi-smart-home
```

---

## Run setup scripts

Make the scripts executable:

```sh
chmod +x ./scripts
```

#### 1. Run the RPi config script:

```sh
./scripts/conf-rpi.sh
```

_*** You may get promted to reboot after this executed. If so, say `yes` and reboot. You will need to SSH back into the device as per previous step and continue from here. ***_

#### 2. Run the boot script:

```sh
./scripts/conf-boot.sh
```

_*** You may get promted to reboot after this executed. If so, say `yes` and reboot. You will need to SSH back into the device as per previous step and continue from here. ***_

---

## Get your RPi host IP address

Run the following command and note down the first IP-address in the list.

```sh
hostname -I
```

_It should look something like 192.168.XX.XXX_

---

## Update Skyconnect Zigbee dongle

If you are using the HomeAssistant Skyconnect Zigbee dongle, make sure to follow this link and update it:

- https://connectzbt1.home-assistant.io/firmware-update/#from-skyconnect

---

## Access Web Interfaces

Open a web browser connected to the same network as the smarthome RaspberryPi.

**Zigbee2Mqtt**: `http://<RPI-IP-ADDRESS>:8080`  
**Homebridge**: `http://<RPI-IP-ADDRESS>:8581`

---

## MQTT Explorer

If you want to monitor the MQTT messages, install [MQTT Explorer](https://mqtt-explorer.com/) on a desktop computer on the network, and add the following config:

- **Encryption**: false (unless you have enabled TLS in mosquitto config file)
- **Host**: `<RPI-IP-ADDRESS>`
- **Port**: `1883`

---

## Connect Zigbee IoT devices

### Zigbee2MQTT

1. Open a browser and go to `http://<RPI-IP-ADDRESS>:8080`.
2. In the menubar, click the button `Permit join (All)`
3. Reset the state of your IoT device. Check this [link](https://www.zigbee2mqtt.io/guide/usage/pairing_devices.html) for details.
4. Set a name (also check 'Update Home Assistant entity ID').

### Homebridge

1. Open a browser and go to `http://<RPI-IP-ADDRESS>:8581`.
2. Set your login credentials if it's your first time logging in.
3. Go to `Plugins` and install `homebridge-z2m` (Homebridge Zigbee2MQTT).
4. Go to `Accessories` and make sure your IoT-device is visible.

### Apple Homekit

1. Click the `+` button on the top and select `Add Accessory`
2. Click `More options...`.
3. Select the Homebridge and Accessories you want to add and follow the HomeKit instructions.

_The Apple UI is a bit confusing, so if you add the bridge via settings, you will not see your IoT devices in HomeKit_

---

# Links

- [Homebridge Docker](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Docker#install-homebridge)
- [Zigbe2MQTT Docker](https://www.zigbee2mqtt.io/guide/installation/02_docker.html#docker-compose)

---

# Licence

As per attached `LICENCE` file.

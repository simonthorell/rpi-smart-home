# rpi-smart-home

## Introduction

Say goodbye to cluttered Smart Home IoT setups with multiple hubs/gateways. The `rpi-smart-home` project transforms a single Raspberry Pi into a unified smart home gateway. Using MQTT as the backbone, this setup provides seamless communication across devices, regardless of brand or protocol.

### Key Benefits:

- **Simplified Setup**: Replace all your IKEA, Aqara, Philips and other gateways with a single device.
- **Interoperability**: Use MQTT to connect and automate devices across ecosystems.
- **Custom Automation**: Build advanced workflows with for example NodeRED.
- **Cost-Effective**: Avoid expensive brand-specific gateways.

### Example Use Cases:

- **Apple HomeKit**: Integrate Zigbee devices via Homebridge, enabling control and automation through the Apple Home app.
- **Google Home**: Use MQTT with NodeRED or Home Assistant to bridge devices, allowing you to control non-Google devices through the Google Home app or voice commands.
- **Amazon Alexa**: Pair MQTT-connected devices with Alexa using Home Assistant or custom NodeRED flows for voice control.
- **NodeRED**: Create advanced automations and integrations by connecting MQTT topics to other services, such as sending alerts, controlling devices, or integrating with APIs like Slack or Telegram.
- **Home Assistant**: Combine MQTT with Home Assistant's powerful dashboard and automation tools to control and monitor all your devices in one place.
- **Dashboards and Visualizations**: Pair MQTT with platforms like Grafana for real-time visualizations of your IoT data.

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

#### 2. Run the boot script:

```sh
./scripts/conf-boot.sh
```

_*** You may get promted to reboot after these executed. If so, say `yes` and reboot. You will need to SSH back into the device as per previous step and continue from where you left off. ***_

---

## Get your RPi host IP address

Run the following command and note down the first IP-address in the list.

```sh
hostname -I
```

_It should look something like 192.168.XX.XXX which is your `<RPI-IP-ADDRESS>`_

---

## Access Web Interfaces

Open a web browser connected to the same network as the smarthome RaspberryPi.

**Zigbee2Mqtt**: `http://<RPI-IP-ADDRESS>:8080`  
**Homebridge**: `http://<RPI-IP-ADDRESS>:8581`

---

## Zigbee Dongle

### Update Skyconnect Zigbee Dongle

If you are using the HomeAssistant Skyconnect Zigbee dongle, connect the dongle to a desktop computer and follow this link and update it with latest firmware:

- https://connectzbt1.home-assistant.io/firmware-update/#from-skyconnect

### Locate ZigBee Dongle

List connected devices to locate your ZigBee USB stick:

```sh
ls /dev/serial/by-id/
```

Look for an entry resembling:

```sh
usb-Nabu_Casa_Home_Assistant_Connect_ZBT-1_eee059dfa939ef11b57253f454516304-if00-port0
```

Check where the symlink points:

```sh
ls -l /dev/serial/by-id/usb-Nabu_Casa_Home_Assistant_Connect_ZBT-1_eee059dfa939ef11b57253f454516304-if00-port0
```

Take a look at the last part that should say: `../../ttyUSB0`.

### [Optional] - Update Zigbee Dongle Port

#### 1. Open `docker-compose.yml` and update `ttyUSB0` with your dongle port under zigbee2mqtt service:

```sh
devices:
      - "/dev/ttyUSB0"
```

#### 2. Update the Zigbee2MQTT configuration:

```sh
nano zigbee2mqtt/data/configuration.yaml
```

Replace `ttyACM0` with your dongle port here:

```sh
mqtt:
  base_topic: zigbee2mqtt
  server: mqtt://mosquitto
  serial:
      port: /dev/ttyACM0
```

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
- [Zigbee2MQTT Docker](https://www.zigbee2mqtt.io/guide/installation/02_docker.html#docker-compose)

---

# Licence

As per attached `LICENCE` file.

# Homebridge

## Access Web Interface

#### Get the host IP address

SSH into the RaspberryPi server and run below
Take note of the first IP-address in the list.

```sh
hostname -I
```

_It should look something like 192.168.XX.XXX_

_If you are connect via both Ethernet and WiFi, make sure you are using the correct IP address as they will be different._

#### Open Web Interface

On the client device in the network, replace the IP address you got here and access in a browser:

```sh
http://<IP-ADRESS>:8581

# If you are accessing it directly from the Pi, use:
http://localhost:8581
```

## Additional Information [Optional]

#### Open a shell for the Docker instance

```sh
docker exec -it homebridge /bin/bash
```

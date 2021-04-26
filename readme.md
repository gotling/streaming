# Streaming
Start and stop Snapcast server depending on the hour.

# Prerequisite

## Operating system

Download Raspberry Pi OS Lite.

https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit

Flash it to a SD card using Balena Etcher.

https://www.balena.io/etcher/

Enable SSH by placing a file named `ssh`, without any extension, onto the boot partition of the SD card.

## Connect

Put the SD card in the Pi, connect it to network and connect power.

Allow the Pi a few minutes to start, then find the ip of the Pi from the router.

SSH to the ip using Putty.

https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

Username: **pi**

Password: **raspberry**

## Configure OS



## Configure HiFi Berry DAC+ADC


# Installation
```
cd /opt
sudo git clone https://github.com/gotling/streaming.git
cd streaming
sudo ./install.sh
```

# Configuration

Change start and stop hour in `streaming.conf`

# Troubleshooting

## Show service log

`journalctl -u streaming.service`

# Links

https://github.com/badaix/snapcast

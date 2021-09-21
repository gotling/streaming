# Streaming
Start and stop Snapcast server depending on the hour.

Instructions on how to set up a server and a client.
The server will be using a HiFi Berry DAC+ADC to get sound from line-in.

# Prerequisite

The first steps are the same for both server and client.

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

*Update software*

`sudo apt update && sudo apt -y upgrade`

*Change settings*

`sudo raspi-config`

### 1 System Options, S3 Password

Set a new password. This will be used for SSH access.

### 1 System Options, S4 Hostname

This is how the pi is shown in the network.

Hostname: **streaming-server** or **streaming-kitchen**

### 5 Localisation Options, L1 Locale

Just select OK to accept defaults and generate locale for **en_GB.UTF-8**.

### 5 Localisation Options, L2 Timezone

Choose correct time zone.

When everything is set, select *Finish* and reboot the device.

## Configure server

*Enable HiFi Berry DAC+ADC*

Edit `/boot/config.txt`

Comment `dtparam=audio=on`

Add `dtoverlay=hifiberry-dacplusadc`

### Install Snapcast Server

Download the latest snapserver armhf.deb from https://github.com/badaix/snapcast/releases/latest.

`wget https://github.com/badaix/snapcast/releases/download/v0.24.0/snapserver_0.24.0-1_armhf.deb`

Install it:

`sudo apt install ./snapserver*.deb`

### Configure Snapcast server

Edit `/etc/snapserver.conf`

In section *[stream]*

Comment `source = pipe:///tmp/snapfifo?name=default`

Add `source = alsa://?name=analog&sampleformat=44100:16:2&device=hw:0,0&send_silence=false&idle_threshold=100`

## Configure client

### Install Snapcast Client

Download the latest snapclient without-pulse_armhf.deb from https://github.com/badaix/snapcast/releases/latest.

`wget https://github.com/badaix/snapcast/releases/download/v0.24.0/snapclient_0.24.0-1_without-pulse_armhf.deb`

Install it:

`sudo apt install ./snapclient*.deb`

Increase sound volume:

`alsamixer`

Change it to 86% or higher.

### If using fixed ip

If ip of the server is fixed, configure it in the client:

`sudo nano /etc/default/snapclient`

Change `SNAPCLIENT_OPTS=""`

To `SNAPCLIENT_OPTS="-h <ip>"`

# Installation of this project on the server

Install Git

`sudo apt install -y git`

Check out and install this project.

```
cd /opt
sudo git clone https://github.com/gotling/streaming.git
cd streaming
sudo ./install.sh
```

# Configuration

Change start and stop hour in `streaming.conf`

Reboot and make sure snapcast is started or not according to setting.

# Write protect SD cards

To prevent SD card wear and tear, write protection can be enabled using **Overlay File System**. With that enabled, all changes made to the system like writing to log files will be lost when the machine is restarted.

`sudo raspi-config`

## 4 Performance Options, P3 Overlay File System

Select **Yes** when asked to enable Overlay File System and write protect boot partition.

To disable write protection, run the command again but instead answer **No**.

# Troubleshooting

## Show service log

`journalctl -u streaming.service`

## Show network usage

```
sudo apt install iftop
sudo iftop
```

# Links

https://github.com/badaix/snapcast

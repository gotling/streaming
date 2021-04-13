# Streaming
Start and stop Snapcast server depending on the hour.

# Installation
```
cd /opt
sudo git clone https://github.com/gotling/streaming.git
cd streaming
sudo ./install.sh
```

# Configuration

Change start and stop hour in `streaming.bash`

# Troubleshooting

## Show service log

`journalctl -u streaming.service`

# Links

https://github.com/badaix/snapcast

#!/bin/sh

APP=/opt/streaming
SYSTEMD=/etc/systemd/system
CONFIG=streaming.conf
SERVICE=streaming.service
TIMER=streaming.timer

if [ -f "$CONFIG" ]; then
    echo "$CONFIG exists."
else
    echo "Creating $CONFIG"
    touch $CONFIG
    chown pi:pi $CONFIG
    printf "START=%s\nSTOP=%s" 4 7 >> $CONFIG
fi


if [ ! -f "$SYSTEMD/$SERVICE" ]; then
    ln -s $APP/$SERVICE $SYSTEMD
fi

if [ ! -f "$SYSTEMD/$TIMER" ]; then
    ln -s $APP/$TIMER $SYSTEMD
fi

systemctl disable snapserver
systemctl enable streaming
systemctl enable streaming.timer
systemctl daemon-reload
systemctl start streaming
systemctl start streaming.timer

#systemctl status streaming
systemctl list-timers streaming.timer

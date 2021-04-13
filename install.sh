#!/bin/sh

ln -s /opt/streaming/streaming.service /etc/systemd/system/
ln -s /opt/streaming/streaming.timer /etc/systemd/system/
systemctl enable streaming
systemctl enable streaming.timer
systemctl daemon-reload
systemctl start streaming
systemctl start streaming.timer
systemctl status streaming
systemctl list-timers

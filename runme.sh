#!/bin/bash
export DISPLAY=localhost:10.0
export $(dbus-launch)

pantalaimon -c /data/pantalaimon.conf --data-path /data


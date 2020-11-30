#!/bin/bash

## clear existing containers
./stop.sh

echo "-- starting constellation --"
./dns.start.sh
./pxe.start.sh
./ntp.start.sh
sleep 5
./prx.start.sh

## show running containers
docker ps

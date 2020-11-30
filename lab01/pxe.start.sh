#!/bin/bash

# parameters
SERVICENAME="pxe"
IMAGENAME="control-pxe"
VOLMOUNTS="-v ${PWD}/dhcpd.conf:/etc/dhcp/dhcpd.conf"

# stop old instance
./pxe.stop.sh

# launch & persist
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/${SERVICENAME}] not running - now starting\n" 1>&2
	docker run -d -P --net host \
		${VOLMOUNTS} \
		--name "${SERVICENAME}" \
	"apnex/${IMAGENAME}"
fi

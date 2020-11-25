#!/bin/bash

# parameters
SERVICENAME="prx"
IMAGENAME="nginx"
VOLMOUNTS="-v ${PWD}/nginx.conf:/etc/nginx/nginx.conf -v ${PWD}/lb.conf:/etc/nginx/tcpconf.d/lb.conf -v ${PWD}/default.conf:/etc/nginx/conf.d/default.conf"

# stop old instance
./prx.stop.sh

# launch & persist
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/${SERVICENAME}] not running - now starting\n" 1>&2
	docker run -d -P --net host \
		${VOLMOUNTS} \
		--name "${SERVICENAME}" \
	"${IMAGENAME}"
fi
#	"apnex/${IMAGENAME}"

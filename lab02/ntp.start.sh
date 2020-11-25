#!/bin/bash

# params
SERVICENAME="ntp"
IMAGENAME="apnex/control-ntp"
DOCKER_OPTS="--cap-add SYS_NICE --cap-add SYS_RESOURCE --cap-add SYS_TIME"
VOLMOUNTS="-v ${PWD}/ntp.conf:/etc/ntp.conf"

# stop old instance
./ntp.stop.sh

# launch & persist
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[${IMAGENAME}] not running - now starting\n" 1>&2
	DOCKERRUN="docker run"
	if [[ $0 =~ ^[.] ]]; then # if local
		DOCKERRUN+=" -d"
	fi
	${DOCKERRUN} \
		--name=${SERVICENAME}	\
		-p 123:123/udp		\
		${VOLMOUNTS}		\
		${DOCKER_OPTS}		\
	${IMAGENAME}
fi

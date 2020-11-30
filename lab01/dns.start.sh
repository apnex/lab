#!/bin/bash
if [[ $(readlink -f $0) =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
	CALLED="${BASH_REMATCH[2]}"
fi

# parameters
SERVICENAME="dns"
IMAGENAME="control-dns"
VOLMOUNTS="-v ${WORKDIR}/named.conf:/etc/bind/named.conf -v ${WORKDIR}/records.json:/usr/lib/node_modules/bind-cli/lib/records.json"

# stop existing instance
./dns.stop.sh

# pre-requisites
function health {
	HEALTH=$(docker inspect --format='{{json .State.Health}}' dns | jq -r '."Status"')
	while [[ $HEALTH == "healthy" || $HEALTH == "starting" ]]; do
		printf "%s\n" "health: ${HEALTH}"
		sleep 2
		HEALTH=$(docker inspect --format='{{json .State.Health}}' dns | jq -r '."Status"')
	done
	printf "%s\n" "health: ${HEALTH}"
	case "${HEALTH}" in
		healthy|starting)
			exit 0
		;;
		*)
			exit 1
		;;
	esac
}

# check if running
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[${SERVICENAME}] not running - now starting\n" 1>&2
	touch /etc/resolv.conf
	docker run -d -P --net host \
		--name "${SERVICENAME}" \
		${VOLMOUNTS}		\
	apnex/"${IMAGENAME}"
	#health
fi

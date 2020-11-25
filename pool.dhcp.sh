#!/bin/bash
NETWORK="10.30.0.0"
NETMASK="255.255.255.0"
GATEWAY="10.30.0.254"
BROADCAST="10.30.0.255"
DNSIP="10.30.0.30"
NETSTART="10.30.0.51"
NETEND="10.30.0.99"
DOMAIN="nest"

function makeNode {
read -r -d '' BODY <<CONFIG
host esx${1} {
	option host-name "esx${1}";
	hardware ethernet 00:de:ad:be:${1}:01;
	fixed-address 10.30.0.1${1};
}
CONFIG
echo "${BODY}"
}

function makeSubnet {
read -r -d '' BODY <<CONFIG
# global options
include "/etc/dhcp/ipxe.options";
default-lease-time 600;
max-lease-time 7200;
authoritative;

# mgmt subnet
subnet ${NETWORK} netmask ${NETMASK} {
	range ${NETSTART} ${NETEND};
	next-server ${DNSIP};
	option subnet-mask ${NETMASK};
	option broadcast-address ${BROADCAST};
	option routers ${GATEWAY};
	option domain-name "${DOMAIN}";
	option domain-name-servers ${DNSIP};
}

# mac bindings
CONFIG
echo "${BODY}"
}

makeSubnet
for LAB in {1..9}; do # Lab ID
	for NODE in {1..9}; do # Node ID
		makeNode "${LAB}${NODE}"
	done
done

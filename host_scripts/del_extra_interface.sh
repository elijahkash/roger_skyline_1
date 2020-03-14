#!/bin/sh

source defines.sh

vboxmanage modifyvm $VMNAME --nic1 none

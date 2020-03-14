#!/bin/bash

source ../defines.sh

cp /home/$VMUSER/roger/vm_scripts/netplan_conf.yaml /etc/netplan/interface.yaml

sudo netplan apply

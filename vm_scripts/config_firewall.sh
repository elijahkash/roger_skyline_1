#!/bin/bash

source ../defines.sh

ufw disable

ufw limit 22/tcp
ufw limit 2002/tcp
# ufw limit 4321/tcp

ufw allow 4321/tcp


sed "s/IPV6=yes/IPV6=no/" -i /etc/default/ufw

ufw enable

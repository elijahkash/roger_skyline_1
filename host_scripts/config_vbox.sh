#!/bin/bash

source defines.sh

NATNAME=servernat

if vboxmanage list vms | grep -q $VMNAME
then
	vboxmanage unregistervm $VMNAME
fi
rm -rf ~/VirtualBox\ VMs/$VMNAME

vboxmanage createvm --name $VMNAME --ostype Ubuntu_64 --register

vboxmanage modifyvm $VMNAME --cpus 1 --memory 512 --audio none \
	  --usb off --acpi on --vram 16

vboxmanage storagectl $VMNAME --name ide-controller --add ide
vboxmanage storageattach $VMNAME --storagectl ide-controller \
	--port 0 --device 0 --type hdd \
	--medium $VMVDI

vboxmanage modifyvm $VMNAME --natpf1 "ssh-nat1,tcp,127.0.0.1,$VMPORT,,22"

if vboxmanage natnetwork list | grep -q $NATNAME
then
	vboxmanage natnetwork remove --netname $NATNAME
fi

vboxmanage natnetwork add --netname $NATNAME --network 10.0.4.0/30 \
  --enable --dhcp off --ipv6 off

vboxmanage natnetwork modify --netname $NATNAME --port-forward-4 "ssh-nat2:tcp:[127.0.0.1]:$VMNEWPORT:[10.0.4.1]:$SSHNEWPORT"

vboxmanage natnetwork modify --netname $NATNAME --port-forward-4 "web-serv:tcp:[127.0.0.1]:4321:[10.0.4.1]:4321"

vboxmanage modifyvm $VMNAME --nic2 natnetwork --nat-network2 $NATNAME

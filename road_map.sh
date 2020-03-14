#!/bin/bash

source ./defines.sh

set -x

./host_scripts/config_vbox.sh

vboxmanage startvm $VMNAME
sleep 30

./host_scripts/ssh_set_rsa.sh

./host_scripts/load_to_vm.sh

# configure VM

# Config ssh locale (to avoid arrors)
ssh -t -p $VMPORT $VMUSER@localhost "sudo sed -e '/AcceptEnv LANG/ s/^#*/#/' -i /etc/ssh/sshd_config; sudo systemctl restart sshd"

ssh -t -p $VMPORT $VMUSER@localhost "cd /home/$VMUSER/roger/vm_scripts/ ; sudo ./vm_init_config.sh"

ssh -t -p $VMNEWPORT $VMUSER@localhost "sudo shutdown now"
sleep 7

./host_scripts/del_extra_interface.sh

vboxmanage startvm $VMNAME

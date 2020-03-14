#!/bin/bash

if (("$EUID" != 0))
	then echo "Please run as root"
	exit
fi

source ../defines.sh

INITLOG=/var/log/roger_config.log
CMDLOG=/var/log/apt_install.log

exec 2>1

echo "" | tee -a  $INITLOG
echo "=========================================" | tee -a $INITLOG
date | tee -a $INITLOG
echo "=========================================" | tee -a $INITLOG
echo "" | tee -a $INITLOG

sleep 1

echo "Running update_script ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/update_script.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/update_script.sh &> >(tee -a $INITLOG)
echo "Done. Look at /var/log/update_script.log" | tee -a $INITLOG

echo "Install mailutils ..." | tee -a $INITLOG
echo "> DEBIAN_FRONTEND=noninteractive apt -yq install mailutils" | tee -a $INITLOG
DEBIAN_FRONTEND=noninteractive apt -yq install mailutils &>> $CMDLOG
echo "Done. Look at $CMDLOG" | tee -a $INITLOG

echo "Install pip3 and venv ..." | tee -a $INITLOG
echo "> apt -y install python3-pip" | tee -a $INITLOG
apt -y install python3-pip &>> $CMDLOG
echo "> apt -y install python3-venv" | tee -a $INITLOG
apt -y install python3-venv &>> $CMDLOG
echo "Done. Look at $CMDLOG" | tee -a $INITLOG

sleep 5

echo "Configure cron ..." | tee -a $INITLOG
echo "> crontab -u root crontab.conf" | tee -a $INITLOG
sed -i '' -e "s/VMUSER=.*/VMUSER=$VMUSER/" /home/$VMUSER/roger/vm_scripts/crontab.conf
crontab -u root /home/$VMUSER/roger/vm_scripts/crontab.conf &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Establish monitoring at crontab config ..." | tee -a $INITLOG
echo "> md5sum /etc/crontab | cut -d' ' -f 1 > /home/$VMUSER/roger/vm_scripts/CHECKSUM" | tee -a $INITLOG
md5sum /etc/crontab | cut -d" " -f 1 > /home/$VMUSER/roger/vm_scripts/CHECKSUM &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Config ssh port ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/config_sshport.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/config_sshport.sh &> >(tee -a $INITLOG)
echo "Done. Reload ssh sessions to apply changes!" | tee -a $INITLOG

echo "Config network inteerface ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/config_interface.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/config_interface.sh &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Disable unused servised ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/disable_services.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/disable_services.sh &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Configure firewall ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/config_firewall.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/config_firewall.sh &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Configure iptables ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/config_iptables.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/config_iptables.sh &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG

echo "Configure webserver ..." | tee -a $INITLOG
echo "> /home/$VMUSER/roger/vm_scripts/config_web.sh" | tee -a $INITLOG
/home/$VMUSER/roger/vm_scripts/config_web.sh &> >(tee -a $INITLOG)
echo "Done." | tee -a $INITLOG


echo -e "\n\nComplete configuration script. Look at $INITLOG" | tee -a $INITLOG

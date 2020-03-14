#!/bin/sh

# RUN FROM /roger

source defines.sh

mkdir roger
# add files to send here with cp
cp ./defines.sh ./roger/
cp -R ./vm_scripts ./roger/
cp -R ./web ./roger/

tar -cvf roger.tar roger

scp -P $VMPORT ./roger.tar $VMUSER@localhost:/home/$VMUSER/

ssh -p $VMPORT $VMUSER@localhost "tar -xvf /home/$VMUSER/roger.tar; rm /home/$VMUSER/roger.tar"

rm roger.tar
rm -rf roger

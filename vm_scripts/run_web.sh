#!/bin/bash

source ../defines.sh

source /home/$VMUSER/webenv/bin/activate

python3 /home/$VMUSER/roger/web/app.py

deactivate

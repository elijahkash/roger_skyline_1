#!/bin/bash

source ../defines.sh

python3 -m venv /home/$VMUSER/webenv

source /home/$VMUSER/webenv/bin/activate

pip3 install Flask

deactivate

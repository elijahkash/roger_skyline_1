#!/bin/bash

systemctl disable apparmor.service
systemctl disable apport-autoreport.path
systemctl disable apport.service
systemctl disable apport-forward.socket

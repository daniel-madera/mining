#!/bin/bash

if [ $EUID -ne 0  ]; then
  echo "Not running as root"
  exit 2
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! $DIR -ef /opt/mining ]]; then
  echo "Move repository to location /opt/mining"
  exit 2
fi

apt install linux-headers-`uname -r` lightdm gcc

if [ ! -d /var/log/mining/ ]; then
  mkdir /var/log/mining
  chown daniel:daniel /var/log/mining -R
fi

update-pciids

service lightdm stop
echo "Done..."
echo "Install nvidia driver and Cuda toolkit."
echo "Then run command: echo '/usr/local/cuda/lib64' > /etc/ld.so.conf.d/cuda && ldconfig"
echo "Reboot and check if service lightdm is running."

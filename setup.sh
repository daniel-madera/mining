#!/bin/bash

if [ $EUID -ne 0  ]; then
      echo "Not running as root"
      exit 2
fi

apt install gcc build-essential linux-headers-`uname -r` \
  dpkg-dev software-properties-comon git wget
service lightdm stop

echo "Done..."
echo "Install nvidia driver and Cuda toolkit."
echo "Then run command: echo '/usr/local/cuda/lib64' > /etc/ld.so.conf.d/cuda && ldconfig"

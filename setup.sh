#!/bin/bash

if [ $EUID -ne 0  ]; then
      echo "Not running as root"
      exit 2
fi

apt install linux-headers-`uname -r`
service lightdm stop

if [ ! -d /var/log/mining/ ]; then
  mkdir /var/log/mining
fi

if [ ! -d /opt/mining/ ]; then
  mkdir /opt/mining/
fi

dir=$(dirname "$0")

cp $dir/* /opt/mining/ -r

echo "Done..."
echo "Install nvidia driver and Cuda toolkit."
echo "Then run command: echo '/usr/local/cuda/lib64' > /etc/ld.so.conf.d/cuda && ldconfig"

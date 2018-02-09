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

apt install linux-source
# apt source linux-image-$(uname -r)
apt install linux-headers-$(uname -r) lightdm gcc cmake build-essential make

rm ./linux* -rf

update-pciids

# create service
ln -s /opt/mining/miner /etc/init.d/miner
systemctl daemon-reload

# start service on boot
update-rc.d miner defaults
update-rc.d miner enable

echo '/usr/local/cuda/lib64' > /etc/ld.so.conf.d/cuda
ldconfig

service lightdm stop
echo "Done..."
echo "Install nvidia driver and Cuda toolkit."
echo "Then run command: ldconfig"
echo "Reboot and check if service lightdm is running."

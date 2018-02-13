# Mining service for Debian

Mining service uses Claymore or Ethminer, CUDA Toolkit and NVIDIA.

## Instructions 
```bash
su
git clone https://github.com/daniel-madera/mining.git
mv ./mining /opt/
cd /opt/mining
./install.sh
# download and install CUDA
ldconfig
reboot
service miner status
# service should be running
```

After editting miner file (service) run as root command: 
```bash
systemctl daemon-reload
```

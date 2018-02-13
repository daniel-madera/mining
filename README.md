# Mining service for Debian

Mining service uses Claymore or Ethminer, CUDA Toolkit and NVIDIA.

## Requirements
- installed lightdm or gdm (if you prefer other DM, customize overclock/nvidia.sh for valid XAUTHORITY and DISPLAY constants.)
- ve /opt/ethminer/ethminer
- nebo /opt/claymore/ethdrcminer64


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

#!/bin/bash

filename=$(basename -- "$0")
name="${filename%.*}"
LOG="/var/log/mining/$name.log"
exec 2>&1 | tee -a $LOG

dir=$(dirname "$0")
$dir/overclock/overclock-nvidia.sh

# etherium mining at ethermine
POOL1="eu1.ethermine.org:4444"
POOL2="us1.ethermine.org:4444"
ETH_WALLET="0xbFD2176872B0e3826784561Dbd507cB95eAb3f4C"

WORKER=$(hostname)
MINER="/opt/claymore/ethdcrminer64"

filename=$(basename -- "$0")
name="${filename%.*}"
LOG="/var/log/mining/$name.log"

$MINER -epool $POOL1 -ewal $ETH_WALLET.$WORKER -epsw x

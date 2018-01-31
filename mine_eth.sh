#!/bin/bash

# etherium mining at ethermine
POOL1="eu1.ethermine.org:4444"
POOL2="us1.ethermine.org:4444"
ETH_WALLET="0xbFD2176872B0e3826784561Dbd507cB95eAb3f4C"

WORKER=$(hostname)
MINER="/opt/mining/claymore/ethdcrminer64"

filename=$(basename -- "$0")
name="${filename%.*}"
LOG="/var/log/mining/$name.log"

$MINER -epool $POOL1 -ewal $ETH_WALLET.$WORKER -epsw x  > $LOG 2>&1

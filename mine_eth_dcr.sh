#!/bin/bash

dir=$(dirname "$0")
$dir/overclock/overclock-nvidia.sh

# etherium mining at ethermine
POOL1="eu1.ethermine.org:4444"
POOL2="us1.ethermine.org:4444"
ETH_WALLET="0xbFD2176872B0e3826784561Dbd507cB95eAb3f4C"

DCR_POOL="stratum+tcp://dcr.pool.mn:4801"
DCR_USER="delanroth"
DCR_WALLET="Dsdh81D9mSDGjZ3YCwrq5iFGLfBVLHZvRmf"

WORKER=$(hostname)
MINER="/opt/claymore/ethdcrminer64"

$MINER -epool $POOL1 -esm 1 -ewal $ETH_WALLET.$WORKER -epsw x -dpool $DCR_POOL -dwal $DCR_USER.$WORKER -dpsw x

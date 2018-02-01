#!/bin/bash
dir=$(dirname "$0")

service lightdm start

$dir/overclock/nvidia.sh
# $dir/overclock/amd.sh

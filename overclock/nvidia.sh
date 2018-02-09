#!/bin/bash
dir=$(dirname "$0")

for f in $dir/config/nvidia-*
do
	. $f

	if [[ -z $GPU_NAME_CONTAINS ]] ; then echo "set variable GPU_NAME_CONTAINS" && exit 2 ; fi

	echo "Performing overclock NVIDIA gpus: ${GPU_NAME_CONTAINS}"

	if [ $EUID -ne 0 ]; then
		echo "Not running as root"
		exit 2
	fi

  if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
  fi

  if [ -z "$XAUTHORITY" ]; then
    export export XAUTHORITY=/var/run/lightdm/root/:0
  fi

	gpus_status='nvidia-smi --query-gpu=index,gpu_name,clocks.sm,clocks.mem,temperature.gpu	--format=csv | grep "${GPU_NAME_CONTAINS}" | column -s, -t'

	if [[ -z $(eval $gpus_status) ]] ; then
		echo "No devices '${GPU_NAME_CONTAINS}' found"
		continue
	fi

	echo "Found devices:"
	eval $gpus_status
  nvidia-xconfig -a --cool-bits=28 --allow-empty-initial-configuration
	nvidia-smi -pm 1

	for i in $(eval $gpus_status | grep ^[[:digit:]] -Eo) ; do
		echo "Overclocking device with index: $i."
		nvidia-settings -a [gpu:$i]/GpuPowerMizerMode=1

	  if [[ ! -z $GPU_MAX_POWER ]] ; then
      nvidia-smi -i $i -pl ${GPU_MAX_POWER}
    fi

	  if [[ ! -z $GPU_FAN_SPEED ]] ; then
		  nvidia-settings -a [gpu:$i]/GPUFanControlState=1
  		nvidia-settings -a [fan:$i]/GPUTargetFanSpeed=${GPU_FAN_SPEED}
    fi

	  if [[ ! -z $GPU_CLOCK_OFFSET ]] ; then
		  nvidia-settings -a [gpu:$i]/GPUGraphicsClockOffset[3]=${GPU_CLOCK_OFFSET}
    fi

	  if [[ ! -z $GPU_MEM_CLOCK_TRANSFER_OFFSET ]] ; then
		  nvidia-settings -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=${GPU_MEM_CLOCK_TRANSFER_OFFSET}
    fi

	done
	eval $gpus_status
	echo "Done for ${GPU_NAME_CONTAINS}!"

done

export GPU_FORCE_64BIT_PTR=0
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

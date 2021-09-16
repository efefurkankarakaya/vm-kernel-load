#!/bin/bash

DEV="/dev"
KERNELS=(vmci vmmon vmnet0 vmnet1 vmnet8 vsock)

load_kernels(){ sudo modprobe -a vmw_vmci; }

compile_kernels() { sudo vmware-modconfig --console --install-all; }

count=0
while [ $count -lt "${#KERNELS[@]}" ]; 
do
    echo "$DEV/${KERNELS[count]}"
    if [ ! -c "$DEV/${KERNELS[count]}" ]; then # If character device not exists.
        echo "${KERNELS[count]} not found"
        echo "Loading kernels"
        load_kernels
        echo "Compiling kernels"
        compile_kernels
        break
    fi
    ((++count))
done
vmplayer # VMware workstation player must be installed, before run this script.

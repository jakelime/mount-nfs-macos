#!/bin/bash

source ./00.utils.sh
load_env ".env"

eval LOCAL_MOUNT_REAL=$LOCAL_MOUNT_POINT

if mount | grep -q "$LOCAL_MOUNT_REAL"; then
    echo "Unmounting $LOCAL_MOUNT_REAL..."
    sudo umount -f "$LOCAL_MOUNT_REAL"

    if [ $? -eq 0 ]; then
        echo "Successfully unmounted."
    else
        diskutil unmount force "$LOCAL_MOUNT_REAL"
    fi
else
    echo "No mount found at $LOCAL_MOUNT_REAL."
fi

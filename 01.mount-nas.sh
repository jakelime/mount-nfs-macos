#!/bin/bash

# Import the utility function
source ./00.utils.sh

# Load the environment variables
load_env ".env"

# Ensure the local mount point directory exists (handles tilde ~ correctly)
eval LOCAL_MOUNT_REAL=$LOCAL_MOUNT_POINT
mkdir -p "$LOCAL_MOUNT_REAL"

echo "Mounting $NAS_IP:$REMOTE_PATH to $LOCAL_MOUNT_REAL..."

sudo mount -t nfs -o resvport,rw,intr,locallocks "$NAS_IP:$REMOTE_PATH" "$LOCAL_MOUNT_REAL"

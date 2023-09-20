#!/bin/bash

# Define the target partition device and the mount point
target_partition="/dev/sdXN"  # Replace with the appropriate partition device (e.g., /dev/sdb1)
mount_point="/var/log"

# Check if the target partition is already mounted
if grep -qs "$target_partition $mount_point" /proc/mounts; then
    echo "A separate /var/log partition already exists."
    exit 0
fi

# Check if the partition exists
if [ -b "$target_partition" ]; then
    echo "Creating a separate /var/log partition..."
    
    # Create a file system on the partition (You can choose a different file system type if needed)
    mkfs.ext4 "$target_partition"
    
    # Create the mount point if it doesn't exist
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi
    
    # Mount the partition
    mount "$target_partition" "$mount_point"
    
    # Add an entry to /etc/fstab for automatic mounting at boot
    echo "$target_partition $mount_point ext4 defaults 0 0" >> /etc/fstab
    
    echo "Separate /var/log partition created and mounted successfully."
else
    echo "Error: The specified partition '$target_partition' does not exist."
    exit 1
fi

# Exit with success status
exit 0

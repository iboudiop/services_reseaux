#!/bin/bash

# ./create_partition.sh volume_group_name partition_name partition_size filesystem
# Call script Example :
# ./create_partition.sh vg0 rootvar 1M ext4 var  


volume_group_name=$1
partition_name=$2
# Partition size Format : 13G, 2M, 1K ...
partition_size=$3
# Filesystem Format : ext4, fat32 ...
filesystem=$4

folder_base_name=$5

#Create partition
echo Partition loading...
lvcreate -n $partition_name $volume_group_name -L $partition_size

# Format partition
echo Configuration filesystem...
mkfs.$filesystem /dev/$volume_group_name/$partition_name
echo Partition $partition_name was created successfully\nFilesystem : $filesystem\nPartition size : $partition_size

# Create a folder where partition will be mounted
mkdir $folder_base_name

# Mount partition
mount /dev/$volume_group_name/$partition_name $folder_base_name
echo Partition $partition_name mounted in folder $folder_base_name


# Added partition in configuration file /etc/fstab
echo Partition mounted permanently...
echo /dev/$volume_group_name/$partition_name $folder_base_name ext4 defaults 0 2 >> /etc/fstab
mount -a

#! /bin/bash

CONFIG_DIR="$HOME/.config"

# check if the script is run as root
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

# Install the necessary packages
# Distribution-specific commands should be provided
# TODO: Add distribution-specific commands

# bind mount all necessary directories

# get all directory names
directories=$(ls -d */)

# bind mount all directories
for dir in $directories; do
	mount --bind $dir $CONFIG_DIR/$dir
done

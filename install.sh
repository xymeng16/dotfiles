#! /bin/bash

# check if the script is run as root
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

# check if the script is not invoked by "sudo -E" (preserve environment)
if [ "$HOME" = "/root" ]; then
	echo "Please use sudo -E to avoid installing into /root"
	exit
fi

CONFIG_DIR="$HOME/.config"

# Install the necessary packages
# Distribution-specific commands should be provided
# TODO: Add distribution-specific commands

# bind mount all necessary directories

# get all directory names
directories=$(ls -d */)

# bind mount all directories
for dir in $directories; do
	# don't mount the install.win directory
	if [ "$dir" == "install.win/" ]; then
		continue
	fi

	# get the directory name
	dir_name=$(echo $dir | sed 's/\///g')

	# check if the directory is already mounted
	# magic logic here, idk why the original path does not
	# appear in my /proc/mounts, instead it is dotfiles/fish, etc.
	if grep -qs "dotfiles/$dir_name" /proc/mounts; then
		echo "$CONFIG_DIR/$dir_name is already mounted"
	else
		mount --bind "$dir" "$CONFIG_DIR/$dir_name"
		echo "Mounting $dir to $CONFIG_DIR/$dir_name"
	fi
done

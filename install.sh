#!/usr/bin/env bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname $SCRIPT)

CONFIG_DIR="$HOME/.config/"

CONFIGS_TO_BE_INSTALLED="fish gdb nvim rime tex wezterm"

# Install the necessary packages
# Distribution-specific commands should be provided
# TODO: Add distribution-specific commands

# bind mount all necessary directories

# get all directory names
# directories=$(ls -d $SCRIPT_DIR/*/)

# bind mount all directories
for dir in $CONFIGS_TO_BE_INSTALLED; do
	ln -s "$SCRIPT_DIR/$dir" $CONFIG_DIR
done

#!/bin/bash

if (ps -a | grep tofi-drun >/dev/null); then
	killall -q tofi-drun
else
	tofi-drun --drun-launch=true
fi

#!/bin/bash

if [[ "$1" == "-f" ]]; then
	shift
	docker build -f "$@"
else
	docker "$@"
fi

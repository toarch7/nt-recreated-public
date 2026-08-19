#!/usr/bin/env bash
set -xe

all_good=true

if command -v node >/dev/null 2>&1; then
    echo "node installation found ($(node --version))"
else
    echo "node is not found"
	$all_good = false
fi

if command -v npm >/dev/null 2>&1; then
    echo "npm installation is found ($(npm --version))"
else
    echo "npm is not found"
fi

if [ ! $all_good ] then
	echo "Missing or incomplete node.js setup! Please, make sure that you have proceeded with installing node and npm before running the script: https://nodejs.org/en"
	exit 1
fi



#!/bin/bash
# A simple script to manage server side 1m actions.
#
# Syntax:
# ./server.sh api action param1 param2 ...
#
# Notes:
# action - [publish]
#
# Commands:
# publish version-code version-name
# - Advertise given build to clients (artifacts has to exist already on github)

api="api"
action="publish"
param1=$1
param2=$2

versions="v1"
flavors="prod"

function runPublish {
    for v in $versions; do
	for f in $flavors; do
		cp $api/$v/$f/repo-template $api/$v/$f/repo.txt
		sed -i -- "s/{version-code}/$param1/g" $api/$v/$f/repo.txt
		sed -i -- "s/{version-name}/$param2/g" $api/$v/$f/repo.txt
	done
    done
}

echo "api: $api"
echo "action: $action"
echo "param1: $param1"
echo "param2: $param2"
echo ""

read -p "Continue? (y/n) " choice
if [ "$choice" = "y" ]; then
    echo "Running..."
    runPublish
    tree $api/
    cat $api/$param1/prod/repo.txt
    echo "Done."
else
    echo "Cancelled"
fi

#!/bin/bash
set -e

cd $(dirname "${BASH_SOURCE[0]}")
WD=$(pwd)

if [ ! -f "tile38-server" ];then 
	echo missing tile38-server binary
	exit 1
fi

TMP="$(mktemp -d -t data-test)"
./tile38-server -p 9876 -d "$TMP" -q &
PID=$!
function end {
  	rm -rf "$TMP"
  	kill $PID &
}
trap end EXIT

go test $(go list ./... | grep -v /vendor/)
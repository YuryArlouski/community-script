#!/usr/bin/env bash
curl https://raw.githubusercontent.com/YuryArlouski/community-script/main/RemoveSymantecMacFiles.command -o /tmp/RemoveSymantecMacFiles.sh
sudo chmod 700 /tmp/RemoveSymantecMacFiles.sh
cd /tmp
./RemoveSymantecMacFiles.sh

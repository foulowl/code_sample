#!/bin/bash

# Usage: ./deploy.sh [host]

host="$1"

tar cj . | ssh "$host" '
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash install.sh'


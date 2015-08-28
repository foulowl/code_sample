#!/bin/bash

# This runs as root on the server
chef_binary=chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    apt-get update &&
    apt-get -o Dpkg::Options::="--force-confnew" \
        --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    apt-get install -y ruby ruby-dev make ruby-ffi gcc &&
    sudo gem install --no-rdoc --no-ri chef
fi

"$chef_binary" -c solo.rb -j solo.json


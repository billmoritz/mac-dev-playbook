#!/usr/bin/env bash

# Simple Install Script to Set Up a New Mac with One Command Using Curl
# What it does:
# - Install pip (if needed) and then install Ansible with pip
# - Install the xcode command line tools
# - Clone Ansible Playbook with git
# - Run Ansible Playbook to Configure New Mac

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ ! -x "$(command -v pip)" ]; then
    sudo easy_install pip
fi

if [ ! -x "$(command -v ansible)" ]; then
    sudo pip install ansible
fi

if [ ! -x "$(command -v cc)" ]; then
    sudo xcode-select --install
fi

git clone https://github.com/billmoritz/mac-dev-playbook.git ~/mac-dev-playbook || exit

cd ~/mac-dev-playbook || exit

ansible-galaxy install -r requirements.yml

ansible-playbook main.yml -i inventory -K



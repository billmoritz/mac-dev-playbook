#!/usr/bin/env bash

if [ ! -x "$(command -v pip)" ]; then
    sudo easy_install pip
fi

if [ ! -x "$(command -v ansible)" ]; then
    sudo pip install ansible
fi

if [ ! -x "$(command -v cc)" ]; then
    sudo xcode-select --install
fi

if [ ! -d "$HOME/mac-dev-playbook/.git" ]; then
  git clone https://github.com/billmoritz/mac-dev-playbook.git "$HOME/mac-dev-playbook" || exit
fi

cd "$HOME/mac-dev-playbook" || exit

ansible-galaxy install -r requirements.yml

ansible-playbook main.yml -i inventory -K

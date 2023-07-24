#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
# check if git does not exists
if ! [ -x "$(command -v git)" ]; then
  sudo apt-get install git
fi

# install fzf
sudo apt install fzf
# install ripgrep
sudo apt-get install ripgrep
# install fd
sudo apt-get install fd-find

#install tmux
sudo apt-get install -y tmux

# install configuration sync-er
# sh -c "$(curl -fsLS get.chezmoi.io)"

#!/bin/bash
# This script is run on startup when the following arguments arer supplied to devpod:
#
# --dotfiles git@github.com:timdeklijn/nvim.git

# install neovim
sudo ./scripts/install_nvim.sh

echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >>~/.bashrc
echo 'alias vim="nvim"' >>~/.bashrc

cd ..
mv dotfiles/ $HOME/.config/nvim

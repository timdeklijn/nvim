#!/bin/bash

# install neovim
sudo ./scripts/install_nvim.sh

echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >>~/.bashrc

cd ..
mv dotfiles/ $HOME/.config/nvim

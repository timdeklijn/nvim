#!/usr/bin/env bash

install_nvim() {
	curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
	tar xvf nvim-linux-x86_64.tar.gz
	sudo mv nvim-linux-x86_64/ /opt/nvim
	sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
	rm nvim-linux-x86_64.tar.gz
}

install_nvim

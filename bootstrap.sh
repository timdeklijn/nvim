#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

install_nvim() {
  local version="v0.11.5"
  local archive="nvim-linux-x86_64.tar.gz"
  local url="https://github.com/neovim/neovim/releases/download/${version}/${archive}"

  (
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT

    curl -fsSL -o "${tmp_dir}/${archive}" "$url"
    tar -C "$tmp_dir" -xzf "${tmp_dir}/${archive}"

    mkdir -p "$HOME/.local/bin" "$HOME/.local/opt"
    rm -rf "$HOME/.local/opt/nvim"
    mv "${tmp_dir}/nvim-linux-x86_64" "$HOME/.local/opt/nvim"
    ln -sfn "$HOME/.local/opt/nvim/bin/nvim" "$HOME/.local/bin/nvim"

    if ! command -v nvim >/dev/null 2>&1; then
      echo "Installed Neovim to $HOME/.local/bin/nvim (ensure ~/.local/bin is in PATH)"
    fi
  )
}

install_nvim_config() {
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local target_dir="${config_home}/nvim"

  mkdir -p "$config_home"

  if [ -e "$target_dir" ] && [ ! -L "$target_dir" ]; then
    local backup_dir
    backup_dir="${target_dir}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target_dir" "$backup_dir"
    echo "Backed up existing config: $backup_dir"
  fi

  ln -sfn "$repo_root" "$target_dir"
  echo "Linked Neovim config: $repo_root -> $target_dir"
}

main() {
  install_nvim_config

  if ! command -v nvim >/dev/null 2>&1; then
    install_nvim
  fi
}

main "$@"

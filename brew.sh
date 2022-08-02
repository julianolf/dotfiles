#!/usr/bin/env zsh

# Update packages list.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install some other useful tools.
brew install htop tmux neovim jq rgbds pyenv qemu awscli aws-sam-cli 

# Remove outdated versions from the cellar.
brew cleanup

#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install some other useful tools.
brew install openssl readline xz zlib pyenv tmux htop

# Remove outdated versions from the cellar.
brew cleanup

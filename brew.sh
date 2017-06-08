#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install more recent versions of VIM.
brew install vim --with-override-system-vi

# Install some other useful tools.
brew install tmux htop links git-flow python3

# Remove outdated versions from the cellar.
brew cleanup

#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install some other useful tools.
brew install tmux htop links git-flow irssi zlib python3 pipenv elixir rbenv

# Install more recent versions of VIM.
brew install vim --with-override-system-vi

# Remove outdated versions from the cellar.
brew cleanup

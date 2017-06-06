#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
brew install coreutils

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi

# Install some other useful tools.
brew install tmux htop links git-flow python3

# Remove outdated versions from the cellar.
brew cleanup

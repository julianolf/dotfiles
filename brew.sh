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
brew install tmux htop git-flow

# Install zsh and set it as the default command line shell.
brew install zsh zsh-completions

# Remove outdated versions from the cellar.
brew cleanup

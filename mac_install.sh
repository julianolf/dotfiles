#!/usr/bin/env bash

# Installation script for Mac OS Systems
echo "Running Mac OS installation";

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `mac_install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make use of Homebrew for your own sanity
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if which brew > /dev/null; then
	# Install command-line tools using Homebrew
	source ./brew.sh
fi;

# Install Pathogen VIM plugin
mkdir -p ~/.vim/autoload && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# That's all :)
echo "Done. Note that some of these changes requires you to reopen some applications or even logout/restart the system to take effect."

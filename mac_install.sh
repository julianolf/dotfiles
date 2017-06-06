#!/usr/bin/env bash

# Installation script for Mac OS Systems.
echo "Running Mac OS installation";

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `mac_install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make use of Homebrew for your own sanity.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if which brew > /dev/null; then
	# Install command-line tools using Homebrew.
	source ./brew.sh

	# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
	if [ -d "$(brew --prefix coreutils)/libexec/gnubin" ]; then
		export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
	fi;
fi;

# Install Pathogen VIM plugin
mkdir -p ./vim/autoload && curl -fsSLo ./vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## OSX specific tweaks

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

## SSD specific tweaks

# Disable hibernation (speeds up entering sleep mode).
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space...
sudo rm /private/var/vm/sleepimage

# ...create a zero-byte file instead...
sudo touch /private/var/vm/sleepimage

# ...and make sure it can’t be rewritten.
sudo chflags uchg /private/var/vm/sleepimage

# Disable the sudden motion sensor as it’s not useful for SSDs.
sudo pmset -a sms 0

## Finder specific tweaks

# Show the ~/Library folder
chflags nohidden ~/Library

## Time Machine specific tweaks

# Prevent Time Machine from prompting to use new hard drives as backup volume.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups.
hash tmutil &> /dev/null && sudo tmutil disablelocal

## TextEdit specific tweaks

# Use plain text mode for new TextEdit documents.
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

## Photos

# Prevent Photos from opening automatically when devices are plugged in.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# That's all :)
echo "Done. Note that some of these changes requires you to reopen some applications or even logout/restart the system to take effect."

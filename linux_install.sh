#!/usr/bin/env bash

# Installation script for GNU Linux Systems
echo "Running Linux installation";

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `mac_install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if which apt > /dev/null; then
	# Install command-line tools using apt
	source ./apt.sh
fi;

# Install Pathogen VIM plugin
mkdir -p ~/.vim/autoload && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install awesome terminal fonts
mkdir -p ~/.fonts
cd ./awesome-terminal-fonts
git checkout patching-strategy
cp -v ./patched/*.{ttf,sh} ~/.fonts/
git checkout master
cd -
fc-cache -fv ~/.fonts

if ! grep -q "# Awesome terminal fonts maps" ~/.bashrc; then
	echo "" >> ~/.bashrc
	echo "# Awesome terminal fonts maps" >> ~/.bashrc
	echo "source ~/.fonts/*.sh" >> ~/.bashrc
fi

# PROFILE_ID=`dconf list /org/gnome/terminal/legacy/profiles:/`
# dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_IDfont "'SourceCodePro+Powerline+Awesome Regular 11'"
# dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_IDuse-system-font "false"

# Add oh-my-git to bash profile
if ! grep -q "# Initialize oh-my-git" ~/.bashrc; then
	echo "" >> ~/.bashrc
	echo "# Initialize oh-my-git" >> ~/.bashrc
	echo "source ~/.oh-my-git/prompt.sh" >> ~/.bashrc
fi

# That's all :)
echo "Done. Note that some of these changes requires you to reopen some applications or even logout/restart the system to take effect."

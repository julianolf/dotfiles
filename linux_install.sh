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
mkdir -p ~/.config/fontconfig/conf.d

cp -v ./awesome-terminal-fonts/build/*.{ttf,sh} ~/.fonts/
fc-cache -fv ~/.fonts

if [ ! -f ~/.config/fontconfig/conf.d/10-symbols.conf ]; then
	cat ./awesome-terminal-fonts/config/10-symbols.conf | sed 's/PragmataPro/UbuntuMono/' > ~/.config/fontconfig/conf.d/10-symbols.conf
fi

if ! grep -q "# Awesome terminal fonts maps" ~/.bashrc; then
	echo "" >> ~/.bashrc
	echo "# Awesome terminal fonts maps" >> ~/.bashrc
	echo "source ~/.fonts/*.sh" >> ~/.bashrc
fi

# That's all :)
echo "Done. Note that some of these changes requires you to reopen some applications or even logout/restart the system to take effect."

#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync	--exclude ".git/" \
			--exclude ".gitignore" \
			--exclude ".gitmodules" \
			--exclude ".editorconfig" \
			--exclude ".DS_Store" \
			--exclude "README.md" \
			--exclude "LICENSE" \
			--exclude "*.sh" \
			-avh --no-perms . ~;

	# Choose proper installation script
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		source ./linux_install.sh;
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		source ./mac_install.sh
	else
		echo "Sorry, OS not supported yet";
	fi;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

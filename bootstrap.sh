#!/usr/bin/env zsh

git pull origin main;

function doIt() {
	rsync	--exclude ".git" \
		--exclude ".gitignore" \
		--exclude ".gitmodules" \
		--exclude ".editorconfig" \
		--exclude ".DS_Store" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "mac_install.sh" \
		-avh --no-perms . ~;

	source ./mac_install.sh
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

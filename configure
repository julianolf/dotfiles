#!/usr/bin/env zsh

rsync	--exclude ".git" \
	--exclude ".gitignore" \
	--exclude ".DS_Store" \
	--exclude "configure" \
	--exclude "LICENSE" \
	--exclude "README.md" \
	-avh --no-perms . ~

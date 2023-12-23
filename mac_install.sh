#!/usr/bin/env zsh

echo "Running installation";

# Install Xcode command line tools
xcode-select --install

# Use Homebrew for your own sanity
$SHELL -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if which brew > /dev/null; then
	# Install command-line tools using Homebrew
	source ./brew.sh
fi;

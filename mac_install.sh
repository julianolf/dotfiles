#!/usr/bin/env zsh

# Installation script for Mac OS Systems
echo "Running Mac OS installation";

# Install Xcode command line tools
xcode-select --install

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Use Homebrew for your own sanity
$SHELL -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if which brew > /dev/null; then
	# Install command-line tools using Homebrew
	source ./brew.sh
fi;

echo "Done. Note that some of these changes requires you to reopen some applications or even logout/restart the system to take effect."

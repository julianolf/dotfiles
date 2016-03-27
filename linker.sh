#!/usr/bin/env bash

# For now let's just manually create the symlinks to the dotfiles.
echo "Linking the dotfiles";

# Start back'n up all existing dotfiles.
# Delete old backups and create a new one.
rm -rf ~/.old-dotfiles
mkdir -p ~/.old-dotfiles/tmux ~/.old-dotfiles/vim ~/.old-dotfiles/zsh

# Save config files.
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.old-dotfiles/tmux/
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.old-dotfiles/vim/
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.old-dotfiles/zsh/

# Save extra configuration files and plugins.
[ -d ~/.tmux/plugins/ ] && mv ~/.tmux/plugins/ ~/.old-dotfiles/tmux/
[ -d ~/.vim/autoload/ ] && mv ~/.vim/autoload/ ~/.old-dotfiles/vim/
[ -d ~/.vim/bundle/ ] && mv ~/.vim/bundle/ ~/.old-dotfiles/vim/
[ -d ~/.vim/colors/ ] && mv ~/.vim/colors/ ~/.old-dotfiles/vim/

# Create the symlinks
DOTFILES_DIR=$(pwd -P);

ln -s $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -s $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -s $DOTFILES_DIR/vim ~/.vim
ln -s $DOTFILES_DIR/zsh/zshrc ~/.zshrc

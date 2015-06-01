#! /bin/sh

ln -s dotfiles/zshrc.linux ~/.zshrc
ln -s dotfiles/vimrc.linux ~/.vimrc
ln -s dotfiles/vim ~/.vim
ln -s dotfiles/oh-my-zsh ~/.oh-my-zsh

vim +PluginInstall +qall

# vim: set ts=8 sw=2 tw=0 ft=sh et :

#!/bin/bash

rm -f ~/.gitconfig ~/.ssh/config ~/.vimrc ~/.vim ~/.tmux.conf
cwd="$(cd "$(dirname "$0")" && pwd)"

ln -s $cwd/gitconfig ~/.gitconfig

mkdir -p ~/.ssh && ln -s $cwd/sshconfig ~/.ssh/config
mkdir -p ~/.ssh/cm_socket

ln -s $cwd/vimrc ~/.vimrc
ln -s $cwd/dotvim ~/.vim
ln -s $cwd/tmux.conf ~/.tmux.conf

platform=`uname`
if [[ "$platform" == "Linux" ]]; then
    src="arch"
elif [[ "$platform" == "Darwin" ]]; then
    src="mac"
fi
rm -f ~/.zshrc && ln -s $cwd/ohmyzsh-$src/zshrc ~/.zshrc

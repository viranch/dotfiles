#!/bin/bash -e

rm -f ~/.gitconfig ~/.ssh/config ~/.vimrc ~/.vim ~/.tmux.conf
cwd="$(cd "$(dirname "$0")" && pwd)"

platform=`uname`
if [[ "$platform" == "Linux" ]]; then
    src=`cat /etc/*-release | grep "^ID=" | cut -d= -f2 | sed 's/"//g'`
elif [[ "$platform" == "Darwin" ]]; then
    src="mac"
fi

ln -s `find $cwd/{$src,common}/gitconfig 2>/dev/null | head -1` ~/.gitconfig

mkdir -p ~/.ssh && ln -s `find $cwd/{$src,common}/sshconfig 2>/dev/null | head -1` ~/.ssh/config
mkdir -p ~/.ssh/cm_socket

ln -s $cwd/vimrc ~/.vimrc
ln -s $cwd/dotvim ~/.vim
ln -s `find $cwd/{$src,common}/tmux.conf 2>/dev/null | head -1` ~/.tmux.conf

rm -f ~/.zshrc && ln -s $cwd/$src/ohmyzsh/zshrc ~/.zshrc

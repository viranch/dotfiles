#!/bin/bash

rm -f ~/.gitconfig ~/.ssh/config ~/.vimrc
cwd="$(cd "$(dirname "$0")" && pwd)"
ln -s $cwd/gitconfig ~/.gitconfig
mkdir -p ~/.ssh && ln -s $cwd/sshconfig ~/.ssh/config
ln -s $cwd/vimrc ~/.vimrc
platform=`uname`
if [[ "$platform" == "Linux" ]]; then
    rm -f ~/.zshrc && ln -s $cwd/ohmyzsh-arch/zshrc ~/.zshrc
elif [[ "$platform" == "Darwin" ]]; then
    rm -f ~/.zshrc && ln -s $cwd/ohmyzsh-mac/zshrc ~/.zshrc
fi

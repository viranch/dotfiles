#!/bin/bash

rm -f ~/.gitconfig ~/.ssh/config ~/.vimrc ~/.vim/plugin/dwm.vim
cwd="$(cd "$(dirname "$0")" && pwd)"

ln -s $cwd/gitconfig ~/.gitconfig

mkdir -p ~/.ssh && ln -s $cwd/sshconfig ~/.ssh/config

ln -s $cwd/vimrc ~/.vimrc
mkdir -p ~/.vim/plugin && ln -s $cwd/vimplugins/dwm.vim ~/.vim/plugin/dwm.vim

platform=`uname`
if [[ "$platform" == "Linux" ]]; then
    rm -f ~/.zshrc && ln -s $cwd/ohmyzsh-arch/zshrc ~/.zshrc
elif [[ "$platform" == "Darwin" ]]; then
    rm -f ~/.zshrc && ln -s $cwd/ohmyzsh-mac/zshrc ~/.zshrc
fi

# AWS-specific configuration
#if [[ "$(hostname)" =~ ^ip- ]]; then
#    mkdir -p ~/.config/transmission-daemon
#    for file in /etc/httpd/conf/httpd.conf /etc/ssh/sshd_config ~/.config/transmission-daemon/settings.json; do
#        sudo rm -f $file && sudo ln -s $cwd/aws_`basename $file` $file
#    done
#    if [[ -L /srv/http/stuff ]]; then
#        mkdir -p ~/Downloads
#        sudo ln -s ~/Downloads /srv/http/stuff
#    fi
#fi

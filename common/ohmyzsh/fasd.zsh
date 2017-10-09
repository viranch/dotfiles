export PATH=$PATH:$DOTFILES/bin

if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="$HOME/.fasd-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

  alias v="f -e vim"
fi

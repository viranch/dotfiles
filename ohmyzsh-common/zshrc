# Load all of the config files in ~/oh-my-zsh that end in .zsh
fpath=($PLATFORM_DOTFILES/completion $DOTFILES/ohmyzsh-common/completion $fpath)
for config_file ($DOTFILES/ohmyzsh-common/*.zsh) source $config_file
for config_file ($PLATFORM_DOTFILES/*.zsh) source $config_file

# Customize to your needs...
export EDITOR=vim

# Put ~/bin in PATH for dropping random binaries
test -d $HOME/bin && export PATH=$PATH:$HOME/bin

command -v fasd 2>&1 >/dev/null && eval "$(fasd --init auto)" # fasd

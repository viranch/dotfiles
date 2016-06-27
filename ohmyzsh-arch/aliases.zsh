# My useful aliases
alias iphone='mkdir /tmp/iphone && sudo ifuse /tmp/iphone'
alias uiphone='sudo fusermount -u /tmp/iphone'
alias shutdown='sudo shutdown -hP now'
alias fdisk='sudo fdisk -l'
alias ns='sudo netstat -ntp'
alias nsl='sudo netstat -ntlp'
alias lk='/usr/lib/kde4/libexec/kscreenlocker_greet --immediateLock'
# systemctl
alias sys='sudo systemctl'
alias start='sys start'
alias stop='sys stop'
alias restart='sys restart'
alias reload='sys reload'
alias status='sys status'
alias senable='sys enable'
alias sdisable='sys disable'
alias sys-reload='sys daemon-reload'
# monitors
alias monitor='xranr --output VGA1'
alias onmon='xrandr --output VGA1 --auto && xrandr --output LVDS1 --off && test -f ~/.fehbg && . ~/.fehbg'
alias offmon='xrandr --output LVDS1 --auto && xrandr --output VGA1 --off && test -f ~/.fehbg && . ~/.fehbg'
alias onmon1='xrandr --output VGA1 --auto --right-of LVDS1 && test -f ~/.fehbg && . ~/.fehbg'
alias offmon1='xrandr --output VGA1 --off'
alias onmons='xrandr --output DP1 --auto && xrandr --output LVDS1 --off && xrandr --output VGA1 --auto --right-of DP1 && test -f ~/.fehbg && . ~/.fehbg'
alias offmons='xrandr --output DP1 --off && xrandr --output LVDS1 --auto && xrandr --output VGA1 --off'
# openbox
alias obas='vim ~/.config/openbox/autostart'
alias obrc='vim ~/.config/openbox/rc.xml'
alias obmenu='vim ~/.config/openbox/menu.xml'
alias or='openbox --reconfigure'
# ssh
alias sa='ssh-add ~/.ssh/id_rsa-work'

# KDE aliases
alias ko='kde-open'
#alias e='kde-open .'

# Pacman aliases
alias p=pacman
compdef _pacman p=pacman
alias P='sudo pacman --noconfirm'
alias pi='P -S'
alias pq='p -Q'
alias psy='P -Sy'
alias psu='P -Su'
alias up='P -Syu'
alias clean='find /var/cache/pacman/pkg -name \*.part -type f -exec sudo rm -vf {} \; ; P -Sc'
alias pss='p -Ss'
alias pqs='pq -s'
alias pql='pq -l'
alias pqo='pq -o'
alias pqi='pq -i'
alias pr='P -Rs'
alias aur='pq -m'
whose() { pqo -q $(which -p $1) }
plist() { pacman -Qei|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}' }
compdef _which whose=which
alias ya=yaourt

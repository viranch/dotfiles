# My useful aliases
alias sysmon='echo "USER       PID %CPU %MEM  COMMAND" && "ps" aux | tail | cut -c1-25,65- | sort -n -k3'
alias mnt=pmount
alias umnt=pumount
alias mntcd='sudo mount -o loop,ro -t iso9660'
alias shutdown='sudo shutdown -hP now'
alias mencoder='mencoder -quiet -oac copy -ovc copy'
alias fdisk='sudo fdisk -l'
alias ns='sudo netstat -ntp'
alias nsl='sudo netstat -ntlp'
alias pb='(xdg-open `cpb`)'
# systemctl
sys() { sudo systemctl $1 $2.service }
start() { sys start $1 }
stop() { sys stop $1 }
restart() { sys restart $1 }
status() { sys status $1 }
senable() { sys enable $1 }
# monitors
alias monitor='xranr --output VGA1'
alias onmon='xrandr --output VGA1 --auto --right-of LVDS1'
alias offmon='xrandr --output VGA1 --off'
alias onmons='xrandr --output DP1 --auto && xrandr --output LVDS1 --off && xrandr --output VGA1 --auto --right-of DP1'
alias offmons='xrandr --output DP1 --off && xrandr --output LVDS1 --auto && xrandr --output VGA1 --off'
# aws
alias td='transmission-daemon'
alias kt='killall -INT transmission-daemon'
alias pa='cd /etc/puppet && sudo git pull && sudo puppet apply /etc/puppet/manifests/site.pp; cd -'
# openbox
alias obas='vim ~/.config/openbox/autostart'
alias obrc='vim ~/.config/openbox/rc.xml'
alias obmenu='vim ~/.config/openbox/menu.xml'
alias or='openbox --reconfigure'

# KDE aliases
alias killkde="kill -TERM `\ps aux|grep startkde$|awk '{print $2}'`"
alias killdr='killall -q drkonqi'
kcp() { kde-cp "$1" "$2" & }
kmv() { kde-mv "$1" "$2" & }
alias ko='kde-open'
alias kde='restart kdm'
alias e='kde-open .'
alias plasmoidpkg='zip -r widget.plasmoid metadata.desktop contents && plasmapkg -u widget.plasmoid && rm widget.plasmoid'
alias D='DISPLAY=:0'

# Pacman aliases
alias p=pacman
compdef _pacman p=pacman
alias P='sudo pacman --noconfirm'
alias pi='P -S'
alias pq='p -Q'
alias psy='P -Sy'
alias psu='P -Su'
alias up='P -Syu'
alias clean='P -Sc && sudo rm -f /var/cache/pacman/pkg/*.part'
alias pss='p -Ss'
alias psi='p -Si'
alias pqs='pq -s'
alias pql='pq -l'
alias pqo='pq -o'
alias pqi='pq -i'
alias pr='P -Rs'
alias aur='pq -m'
whose () { pqo -q $(which $1) }
plist() { pacman -Qei|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}' }
compdef _which whose=which

# script aliases
alias python=python2 # to make imdb and pb aliases work
alias aurman='`_fname aurman.sh`'
alias trunkman='`_fname trunkman.sh`'

# Howto's
alias howtomount='echo /usr/bin/mount.ntfs /dev/whatever /run/media/viranch/viranch-storejet -o rw,nodev,nosuid,uid=1000,gid=100,dmask=0077,fmask=0177,uhelper=udisks2'

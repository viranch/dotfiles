# systemctl
compdef _systemctl sys=systemctl
for fun in start stop restart reload status senable sdisable ; do
    compdef _systemctl_$fun $fun=systemctl
done

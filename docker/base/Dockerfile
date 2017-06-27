FROM base/archlinux
ENV container nointeractive

RUN echo $'[archlinuxfr]\n\
SigLevel = Never\n\
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

RUN echo $'##\n\
## Arch Linux repository mirrorlist\n\
## Generated on 2017-06-21\n\
##\n\
## Russia\n\
Server = http://mirror.yandex.ru/archlinux/$repo/os/$arch\n\
Server = https://mirror.yandex.ru/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# upgrade system
RUN pacman -Syu --noconfirm

RUN pacman -Sy yaourt --noconfirm

# instal 
RUN pacman -S base base-devel openssh x2goserver --noconfirm

# install console tools
RUN pacman -S rxvt-unicode tmux bash-completion --noconfirm

# install development tools 
RUN pacman -S vim emacs git meld --noconfirm

#RUN pacman -S xarchiver mate mate-extra thunar --noconfirm
RUN pacman -S xarchiver thunar i3lock i3status dmenu --noconfirm

RUN yaourt -S i3-gap

# configure remote access
RUN sed -i 's/.*X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config && \
    sed -i 's/.*AllowTcpForwarding.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    sed -i 's/.*X11UseLocalhost.*/X11UseLocalhost yes/g' /etc/ssh/sshd_config && \
    sed -i 's/*.X11DisplayOffset.*/X11DisplayOffset 10/g' /etc/ssh/sshd_config

RUN systemctl enable sshd.service && \
    systemctl enable x2goserver.service
RUN x2godbadmin --createdb

RUN echo root:root | chpasswd

# open port for ssh
EXPOSE 22

# run systemd
ENTRYPOINT ["/sbin/init"]
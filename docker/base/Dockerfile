FROM base/archlinux:latest
ENV container nointeractive

RUN echo $'[archlinuxfr]\n\
SigLevel = Never\n\
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

COPY mirrorlist /etc/pacman.d/mirrorlist

# upgrade system
RUN pacman -Syu --noconfirm

RUN pacman -Sy yaourt --noconfirm

# instal 
RUN pacman -S base base-devel openssh x2goserver --noconfirm

# install console tools
RUN pacman -S rxvt-unicode tmux bash-completion --noconfirm

# install development tools 
RUN pacman -S vim emacs git meld --noconfirm

RUN pacman -S xarchiver thunar i3 i3lock i3status dmenu --noconfirm

#RUN yaourt -S i3-gap

# configure remote access
RUN sed -i 's/.*X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config && \
    sed -i 's/.*AllowTcpForwarding.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    sed -i 's/.*X11UseLocalhost.*/X11UseLocalhost yes/g' /etc/ssh/sshd_config && \
    sed -i 's/*.X11DisplayOffset.*/X11DisplayOffset 10/g' /etc/ssh/sshd_config

RUN pacman -S xfce4 xfce4-goodies --noconfirm

RUN systemctl enable sshd.service && \
    systemctl enable x2goserver.service
RUN x2godbadmin --createdb

RUN echo root:root | chpasswd
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale-gen && locale-gen

# open port for ssh
EXPOSE 22

# run systemd
ENTRYPOINT ["/sbin/init"]
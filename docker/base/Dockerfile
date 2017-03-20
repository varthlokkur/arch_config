FROM base/archlinux
ENV container nointeractive

# upgrade system
RUN  pacman -Syu --noconfirm


# instal 
RUN pacman -S base base-devel openssh x2goserver --noconfirm

# install console tools
RUN pacman -S rxvt-unicode tmux bash-completion --noconfirm

# install development tools 
RUN pacman -S vim emacs git meld --noconfirm

RUN pacman -S xarchiver mate mate-extra thunar --noconfirm

# configure remote access
RUN sed 's/.*X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config | \
    sed 's/.*AllowTcpForwarding.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config | \
    sed 's/.*X11UseLocalhost.*/X11UseLocalhost yes/g' /etc/ssh/sshd_config | \
    sed 's/*.X11DisplayOffset.*/X11DisplayOffset 10/g' /etc/ssh/sshd_config > /etc/ssh/sshd_config

RUN systemctl enable sshd.service && \
    systemctl enable x2goserver.service
RUN x2godbadmin --createdb

# open port for ssh
EXPOSE 22

# run systemd
CMD /sbin/init

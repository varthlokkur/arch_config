FROM base/archlinux
ENV container nointeractive

# upgrade system
RUN pacman -Sy --noconfirm && \
         pacman -Su --noconfirm

# instal 
RUN pacman -S base base-devel openssh x2goserver --noconfirm

# install console tools
RUN pacman -S rxvt-unicode tmux bash-completion --noconfirm

# install development tools 
RUN pacman -S vim emacs git meld

RUN pacman -S xarchiver mate mate-extra thunar --noconfirm

# configure remote access
RUN sef 's/*X11Forwarding*/X11Forwarding yes/g /etc/ssh/sshd_config
RUN systemctl enable sshd.service && \
         systemctl enable x2goserver.service

# open port for ssh
EXPOSE 22

# run systemd
CMD /sbin/init
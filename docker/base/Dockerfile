FROM base/archlinux
ENV container nointeractive

COPY mirrorlist /etc/pacman.d/mirrorlist

# upgrade system
RUN  pacman -Syu --noconfirm

# instal 
RUN pacman -S base base-devel openssh x2goserver --noconfirm

# install console tools
RUN pacman -S rxvt-unicode tmux bash-completion --noconfirm

# install development tools 
RUN pacman -S vim emacs git meld --noconfirm

RUN pacman -S xfce4 xfce4-goodies --noconfirm

# configure remote access
RUN sed 's/.*X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config | \ 
sed 's/.*AllowTcpForwarding.*/AllowTcpForwarding yes/g' | \ 
sed 's/.*X11UseLocalhost.*/X11UseLocalhost yes/g' | \ 
sed 's/*.X11DisplayOffset.*/X11DisplayOffset 10/g' > /etc/ssh/tmp_sshd_config && \ 
cat /etc/ssh/tmp_sshd_config > /etc/ssh/sshd_config && \
rm /etc/ssh/tmp_sshd_config

RUN systemctl enable sshd.service && \
    systemctl enable x2goserver.service
RUN x2godbadmin --createdb

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale-gen && locale-gen

# open port for ssh
EXPOSE 22

# run systemd
CMD /sbin/init

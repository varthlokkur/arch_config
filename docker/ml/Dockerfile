FROM base/archlinux

#update system
RUN pacman -Sy --noconfirm
RUN pacman -Su --noconfirm

RUN pacman -S rxvt-unicode bash-completion tmux --noconfirm

#install remote desktop
RUN pacman -S openssh x2goserver

RUN sed 's/.*ListenAddress.*/ListenAddress 127.0.0.1/g /etc/ssh/sshd_config
RUN echo dOcker | passwd --stdin root

#install editors
RUN pacman -S vim emacs

# install version control
RUN pacman -S git meld

#install archiver
RUN pacman -S xarchiver

#install windows manager
RUN pacman -S mate mate-extra

RUN systemctl enable sshd.service
RUN systemctl enable x2goserver.service

#install octave
RUN pacman - S octave

#install python 
RUN pacman -S python python-pip

RUN pip install numpy
RUN pip install pandas
RUN pip install scipy
RUN pip install nose
RUN pip install h5py
RUN pip install matplotlib
RUN pip install skimage
RUN pip install sklearn
RUN pip install sympy


EXPOSE 22

CMD /sbin/init

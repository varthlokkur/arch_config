FROM archdev


#install octave
RUN pacman -S octave python python-pip ipython --noconfirm

RUN pip install numpy \
                pandas \
                scipy \
                nose \
                h5py \
                matplotlib \
                sklearn \
                sympy \
                Theano \
                keras \
                jupyter

COPY .emacs.d/ /etc/skel/.emacs.d/



RUN useradd --create-home --shell /bin/bash -g users -G wheel,power,storage vart  
RUN echo ml:ml | chpasswd

COPY jupyter.service /usr/lib/systemd/system
RUN systemctl enable jupyter

EXPOSE 8888

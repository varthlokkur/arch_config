FROM archdev

RUN echo dOcker | passwd --stdin root

#install octave
RUN pacman - S octave

#install python 
RUN pacman -S python python-pip ipython

RUN pip install numpy \
                            pandas \
                            scipy \
                            nose \
                            h5py \
                            matplotlib \
                            skimage \
                            sklearn \
                            sympy \
                            Theano \
                            keras \
                            jupyter

COPY .emacs.d/ /etc/skel/

RUN useradd --create-home 

# run jupyter
RUN jupyter notebook --no-browser
EXPOSE 8888

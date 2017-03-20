FROM archdev
ENV PATH /home/vart/.cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | sh
RUN cargo install rustfmt && \
         cargo install racer
         
RUN rustup add component rust-src

RUN export RUST_SRC_PATH=~/.local/share/rust_src/src
         
COPY .emacs/ /etc/skeld/
RUN useradd 


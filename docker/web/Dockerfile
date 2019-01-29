FROM archdev

RUN pacman -S nodejs npm --noconfirm

WORKDIR /usr/local/lib/node_modules/npm
RUN npm install -g npm@latest
#RUN curl -L https://www.npmjs.com/install.sh | sh

RUN useradd --create-home --shell /bin/bash -g users -G wheel,power,storage web  
RUN echo web:web | chpasswd

COPY node.service /usr/lib/systemd/system
RUN systemctl enable node.service

EXPOSE 4227

RUN npm install electron --save-dev
RUN npm install -g electron
RUN npm install -g tsd 
RUN npm install -g typescript
RUN npm install -g @angular/cli 
RUN npm install -g stylus
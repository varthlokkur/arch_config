FROM archdev

RUN pacman -S nodejs npm
RUN npm -g install electron
RUN npm -g install tsd && npm -g install typescript
RUN npm -g install @angular/cli 
RUN npm -g install stylus

COPY node.service /usr/lib/systemd/system
RUN systemctl enable node.service

EXPOSE 4227
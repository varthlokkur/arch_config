docker run -i -t base/archlinux /sbin/init

docker run -d --privileged -p 2222:22 --name os -v /host/directory:/container/directory os

connect by bash
docker exec -it os /bin/bash

connect throught ssh
ssh -p 2222 user@localhost

*Install packages

``` shell
$ sudo pacman -S lxc arch-install-scripts bridge-utils
```

```shell
$ lxc-checkconfig
```

Setup bridge bridge-utils
```shell
$ brctl addbr br0
$ brctl addif wlan0
$ ip link set up dev br0
```

Delete bridge
```shell
$ ip link set dev br0 down
$ brctl delbr br0
```

Setup bridge NetworkManager

```shell
$ nmcli con add type bridge ifname br0
$ nmcli con show
$ nmcli con add type bridge-slave ifname eth1 master bridge-br0
$ nmcli con up <UUID>
```

```shell
$ pacman -S x2goclient
```

Create container
```shell
$ lxc-create -n testarch -t archlinux
```
Container configuration

Connect to container
```shell
$ lxc-attach -n testarch
```

Upgrade system in container
```shell
$ pacman -Sy
$ pacman -Syu
```

Install and configure ssh
```shell
$ pacman -S openssh
$ systemctl start sshd.service
$ systemctl enable sshd.service
```
Install xauth and xhost
```shell
$ pacman -S xorg-xauth xorg-host
```

Install openbox
```shell
$ pacman -S openbox
```

Install and configure x2go server
```shell
$ pacman -S openbox x2goserver 
$ systemctl start x2goserver
$ systemctl enable x2goserver
```

Unpriveleged container

Copy lxc config
```shell
$ cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
```

Create subuid and subgid
```shell
$ touch /etc/subgid
$ touch /etc/subgid
$ usermod --add-subuids 100000 165536 $USER
$ usermod --add-subuids 100000 165536 $USER
```

Add folowing to config file at $HOME/.config/lxc/default.conf

lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536

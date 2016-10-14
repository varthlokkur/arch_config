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
$ nmcli connection
$ nmcli con up <UUID>
```

```shell
$ pacman -S x2goclient
```

Create container
```shell
$ lxc-create -n testarch -t archlinux
```
Configure container
```shell
$ lxc-attach -n testarch
$ pacman -S openbox openssh x2goserver 
$ systemctl start sshd
$ systemctl enable sshd
$ pacman -S xorg-xauth xorg-host
$ systemctl start x2goserver
$ systemctl enable x2goserver
```

cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
touch /etc/subgid
touch /etc/subgid

usermod --add-subuids 100000 165536 $USER
usermod --add-subuids 100000 165536 $USER


$HOME/.config/lxc/default.conf

lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536

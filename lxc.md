*Install packages

``` shell
sudo pacman -S lxc arch-install-scripts bridge-utils
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


cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
touch /etc/subgid
touch /etc/subgid

usermod --add-subuids 100000 165536 $USER
usermod --add-subuids 100000 165536 $USER


$HOME/.config/lxc/default.conf

lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536

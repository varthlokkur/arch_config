*Install packages

``` shell
$ sudo pacman -S lxc arch-install-scripts bridge-utils
```

```shell
$ lxc-checkconfig
```

check user namespace for unprivilesged containers
zgrep CONFIG_USER_NS /proc/config.gz


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

/etc/sysctl.d/30-ipforward.conf
net.ipv4.ip_forward=1

iptables -t nat -A POSTROUTING -o wlp1s0 -j MASQUERADE
iptables-save > /etc/iptables/iptables.rules
systemctl start iptables.service
systemctl enable iptabes.service


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

configure /etc/ssh/sshd_config
AllowTcpForwarding yes
X11UserLocalhost yes
X11DisplayOffset 10
X11Forwarding yes

to root logon use
PermitRootLogon yes

Install openbox
```shell
$ pacman -S openbox
$ pacman -S obconf obmenu openbox-themes
$ pacman -S thunar 
$ pacman -S tint2
```

Install and configure x2go server
```shell
$ pacman -S openbox x2goserver
x2godbadmin --createdb 
$ systemctl start x2goserver
$ systemctl enable x2goserver
```

Install packages
```shell
pacman -S rxvt-unicode bash-completion tmux


# Unpriveleged container

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

Create container with arch
```shell
$ lxc-create -t download -n clean -- -d archlinux -r current -a amd64
```

Start group maanger service
```shell
$ sudo systemctl start cgmanager
$ sudo systemctl enable cgmanager 
```


```shell
$ sudo cgm create all $USER
$ sudo cgm chown all $USER $(id -u $USER) $(id -g $USER)
$ sudo cgm movepid all $USER $$
```

Configure network
vim /etc/lxc/lxc-usernet

Add
user_name veth br0 10

change the password in container
chroot /var/lib/lxc/container/rootfs
passwd
exit

generate key for container
ssh-keygent -R hostname

start unpriviledged container
sudo cgm create all $USER
sudo cgm chown all $USER $(id -u $USER) $(id -g $USER)
sudo cgm movepid all $USER $$

or install
sudo pacman -S cgmanager
systemctl enable cgmanager
systemctl enable cgconfig

vim /ect/cgconfig.conf

group groupname {
perm {
admin {
 uid = $USER
 gid = $GROUP
}
task
{
uid = $USER
gid = $GROUP
}

cpu {}
memory {}
}

unix.stackexchange.com/questions/170998/how-to-create-user-cgroups-with-systemd

lxc-checkconfig

pacman -S lxc
cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
touch /etc/subgid
touch /etc/subgid

usermod --add-subuids 100000 165536 $USER
usermod --add-subuids 100000 165536 $USER


$HOME/.config/lxc/default.conf

lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536

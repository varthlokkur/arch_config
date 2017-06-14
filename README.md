This repository provides my config files and installation instruction for development environment based on archlinux.
The instruction is designed for a clean system with UEFI support. 

## Installation

### Prepare archlinux image
1. Download the latest [archlinux image](https://www.archlinux.org/download) 
2. Burn it to flash drive or CD-ROM.
3. Setup your machine and load image

### Prepare disk
* Make sure that the UEFI is on  
```shell
$ efivar -l
```

* Enumerate disks  
``` shell
$ lsblk
```  
Should output /dev/sda/

* Clean disk  
```shell
$ sgdisk --xap-all /dev/sda
```

* Create new partition. Use GPT.  
```shell
$ cgdisk /dev/sda
```
```
new 1024M 	EF00 boot
new 12G 	8200 swap
new 40G    		 root
new 			 home
```

* Create file system on partitions  
```shell
$ mkfs.fat -F32 /dev/sda1
$ mkfs.btrfs /dev/sda3
$ mkfs.btrfs /dev/sda4
$ mkswap /dev/sda2
$ swapon /dev/sda2
```

* Mount file system  
```shell
mount /dev/sda3 /mnt 
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home
```

### Install base system

* Change mirrorlist  
```shell
$ vim /etc/pacman.d/mirrorlist
```

* Install base system  
```shell
$ pacstrap -i /mnt base base-devel
```

* Generate fstab  
```shell
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

* Chroot to system  
```shell
$ arch-chroot /mnt
```

* Generate locales (uncomment needed)  
```shell
$ vim /etc/locale.gen 
$ locale-gen
```

* Install system locale  
```shell
$ echo LANG=en-US.UTF-8 >> /etc/locale.conf
$ export LANG=en-US.UTF-8
```

* Set timezone  
```shell
$ ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
```

* Update clock
```shell
$ hwclock --systohc --utc
```

* Set hostname  
```shell
$ echo varthlokkur >> /etc/hostname
```

* Set root password  
```shell
$ passwd
``` 

* Add user  
```shell
$ useradd -m -g users -G wheel,power,storage -s /bin/bash varthlokkur
$ EDITOR=vim visudo
uncomment %wheel(ALL = ALL)
```

* Install boot loader
```shell
$ mount -t efivarfs efivarfs /sys/firmware/efi/efivars
$ bootctl install
$ echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=`blkid -S PARTUUID -o value /dev/sda3` rw" > /boot/loader/entries/arch.conf
```

* Install yauort
```shell
$ echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
$ pacman -Sy yaourt
```

* Configure network
```shell
$ ip link
$ systemctl enable dhcpcd@interface_name.service
```

* Configure wi-fi
```shell
$ pacman -S iw wpa_supplicant dialog 
$ systemctl enable netcli@interface_name.service
```

* Reboot system
```shell
$ exit
$ umount -R /mnt
$ reboot
```

### Configure system

* Setup networkmanager
```shell
$ ip link
$ pacman -S dialog networkmanager
$ systemctl stop dhcpcd@ens0.service
$ systemctl disable dhcpcd@ens0.service
$ systemctl stop netcli@ws1.service
$ systemctl disable netcli@ws1.service
$ systemctl stop dhcpcd.service
$ systemctl disable dhcpcd.service
$ systemctl enable NetworkManager.service
$ systemctl start NetworkManager.service
```

* Find and install video drivers  
```shell 
$ lspci | grep -e VGA -e 3D
$ pacman -Ss | grep xf86-video
$ pacman -S xf86-video-intel
$ pacman -S mesa
```
 
* Install touchpad driver
```shell
$ pacman -S xf86-input-synaptics
```

* Install terminal font
```shell
$ pacman -S terminus-font
```

### Installation application
[List of applications](application.md) 


## Install desktop environment

* Installing X  
```shell
$ pacman -S xorg-server
```

* Install tile window manager
```shell
$ yaourt -S i3-gap
$ pacman -S i3lock i3status dmenu rxvt-unicode
```

* Install login manager  
```shell
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm
systemctl start lightdm
```

* Install composite manager
```shell
$ pacman -S compton
```

### Install applets
* Keyboard selector
```shell
$ yaourt -S gxkb
```
* Notification manager
```shell
$ yaourt -S twmn-git
```

* Network manager applet
```shell
$ pacman -S network-manager-applet
```

* Auto mount
```shell
$ pacman -S devmon
```
* Theme manager
```shell
$ sudo pacman -S gtk-theme-switch2
```

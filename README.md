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
$ gdisk /dev/sda
```  
Than enter x z y y

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
$ systemctl language
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
* Add AUR repository
```shell
$ vim /etc/pacman.conf
uncomment 
[multilib]
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


### Installation application

* Terminal  
```shell
pacman -S rxvt-unicode #terminal emulator
```

* Network configuration  
```shell
pacman -S dialog networkmanager network-manager-applet
systemctl stop dhcpcd@ens0.service
systemctl disable dhcpcd@ens0.service
systemctl stop netcli@ws1.service
systemctl disable netcli@ws1.service
systemctl stop dhcpcd.service
systemctl disable dhcpcd.service
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
```
### End of installation

```shell
exit
umount -R /mnt
reboot
```

## Install desktop environment

* installing X and wm  
```shell
$ pacman -S xorg-server xorg-xinit xorg-utils xort-server-utils
$ pacman -S mesa
$ pacman -S xf86-input-synaptics
```

* Detect video card  
```shell
lspci | grep VGA
```

* Find drivers  
```shell 
pacman -Ss | grep xf86-video
```

* Install drivers  
```shell
pacman -S xf86-video-intel
```

* Install wm  
```shell
pacman -S i3 dmenu
```

* Install login manager  
```shell
pacman -S lightdm lightdm-gtk-greater
systemctl enable lightdm
systemctl start lightdm
```

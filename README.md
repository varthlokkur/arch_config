# Arch linux installation and configuration

# check efi 
efivar -l

# find disk
lsblk

# clean disk
gdisk /dev/sda
x
z
y
y

# partition on disk
cgdisk /dev/sda
new 1024M 	EF00 boot
new 12G 	8200 swap
new 40G    		 root
new 			 home

# file system creation
mkfs.fat -F32 /dev/sda1
mkfs.btrfs /dev/sda3
mkfs.btrfs /dev/sda4
mkswap /dev/sda2
swapon /dev/sda2

# mount filesystems
mount /dev/sda3 /mnt 
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home

# uncomment mirrorlist
vim /etc/pacman.d/mirrorlist

# install system
pacstrap -i /mnt base base-devel

# generate fstab file
genfstab -U -p /mnt >> /mnt/etc/fstab

# root in system
arch-chroot /mnt

# generate locales (uncomment needed)
vim /etc/locale.gen 
locale-gen

# install system locale
echo LANG=en-US.UTF-8 >> /etc/locale.conf
export LANG=en-US.UTF-8

# set timezone
ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# update clock
hwclock -systohc --utc

# set hostname
echo varthlokkur >> /etc/hostname

# set root password
passwd 

# add default user
useradd -m -g users -G wheel,power,storage -s /bin/bash varthlokkur
EDITOR=vim visudo
# uncomment %wheel(ALL = ALL)





# installation application
pacman -S vim emacs # editors
pacman -S vlc cmus #media
pacman -S chromium #browser
pacman -S bash-completion #utils
pacman -S zathura #reader
pacman -S rxvt-unicode #terminal emulator
pacman -S arandr

pacman -S meld #diff util


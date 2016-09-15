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
systemctl language
vim /etc/locale.gen 
locale-gen

# install system locale
echo LANG=en-US.UTF-8 >> /etc/locale.conf
export LANG=en-US.UTF-8

# set timezone
ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# update clock
hwclock --systohc --utc

vim /etc/pacman.conf
uncomment 
[multilib]

# upgrade
pacman -Syu

# set hostname
echo varthlokkur >> /etc/hostname

# set root password
passwd 

# add default user
useradd -m -g users -G wheel,power,storage -s /bin/bash varthlokkur
EDITOR=vim visudo
# uncomment %wheel(ALL = ALL)

# install boot loader
# grub
pacman -S grub os_prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# uefi grub
grub-install --target=x86_x64-efi --efi-directory=$esp --bootloader-id=arch_grub --recheck


# installation application
pacman -S rxvt-unicode #terminal emulator
pacman -S dialog

# configure network
pacman -S networkmanager network-manager-applet
systemctl stop dhcpcd@ens0.service
systemctl disable dhcpcd@ens0.service
systemctl stop netcli@ws1.service
systemctl disable netcli@ws1.service
systemctl stop dhcpcd.service
systemctl disable dhcpcd.service
systemctl enable NetworkManager.service
systemctl start NetworkManager.service

exit
umount -R /mnt
reboot

# installing x and wm
pacman -S xorg-server xorg-xinit xorg-utils xort-server-utils
pacman -S mesa
pacman -S xf86-input-synaptics

# detect video card
lspci | grep VGA

# find drivers
pacman -Ss | grep xf86-video

# install drivers
pacman -S xf86-video-intel

# install wm
pacman -S i3 dmenu

# install logit manager
pacman -S lightdm lightdm-gtk-greater

systemctl enable lightdm
systemctl start lightdm





#+ TITLE: After Installing Arch (KDE)
#+ AUTHOR: Jason 
#+ DATE: 20231028

# Reflector
# ########## 
sudo pacman -S reflector

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlistbak 

# Tells reflector to grab 10 mirrors from Canada/USA sorted by fastest speed then save to the mirrorlist file
sudo reflector --verbose --sort rate -l 10 --country US --save /etc/pacman.d/mirrorlist 

# Long Term Support Kernel - just in case
# ########################################
sudo pacman -S linux-lts

# Update Grub Bootloader if using Grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg
# To Get to the Grub Menu press ESC when booting

# Update SystemDBoot
# In /boot/loader/entries/
# # Created by: jason
# Created on: 2023-10-28
# title   Arch Linux LTS
# linux   /vmlinuz-linux-lts
# initrd  /intel-ucode.img
# initrd  /initramfs-linux-fallback.img
# options root=PARTUUID=cb470326-ab47-4653-a022-cf31b299e121 zswap.enabled=0 rw rootfstype=ext4

sudo reboot

# Pacman Cache Cleaning
# #####################

sudo pacman -S pacman-contrib
sudo systemctl enable paccache.timer

# AUR Helper - yay
# ################

https://github.com/Jguer/yay#installation



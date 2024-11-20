## Comfy Guide to Encrypted Arch Linux Install

Originally from denshi.org

### Steps

From the Arch Linux live USB main prompt as Root. Use Ethernet connection.

**Embiggen the terminal font**

'root@archiso ~ # setfont -d'

**Load Keyboard**

'loadkeys us'

**See all the devices/disks**
'lsblk' 

**Identify your install disk then**

'cfdisk /dev/sd{YourInstallDisk}'

**Select label type**

gpt for UEFI install 

**Nuke any preexisting partitions by Delete**

**Create new partitions**

For Boot: /dev/sda1 1G

For Rest of Drive: /dev/sda2 Whatever Space Left

**Write these changes to disk & quit**

**Install File Systems on the Partitions**

For Boot: 

'mkfs.fat -F32 /dev/sda1'

For Encrypted Partition:

'cryptsetup luksFormat /dev/sda2'

**Type YES and your passphrase**

'cryptsetup open /dev/sda2 cryptroot'

**Check this worked. Should see cryptroot under sda2**

'lsblk' 

**Make File System on Encrypted Partition**

'mkfs.btrfs' or 'mkfs.ext4'

'mkfs.ext4 /dev/mapper/cryptroot'

**Mount ahoy!**

'mount /dev/mapper/cryptroot /mnt'

'mkdir /mnt/boot'

'mount /dev/sda1 /mnt/boot'

**Edit the pacman.conf on the installer for performance boost**

'nano /etc/pacman.conf'

Uncomment #ParallelDownloads and change number to the thread count of your CPU. Save and quit.

**Install Arch**

'pacstrap /mnt base base-devel nano vim networkmanager lvm2 cryptsetup grub efibootmgr linux linux-firmware'

**Generate the fstab file**

'genfstab -U /mnt > /mnt/etc/fstab'

**Configure the Arch System**

'arch-chroot /mnt'

'ln -sf /usr/share/zoneinfo/America/Regina /etc/localtime'

'hwclock --systohc'

'nano /etc/locale.gen' scroll down to #en_CA UTF-8 UTF-8 and uncomment it. Save an exit.

'locale-gen'

'nano /etc/locale.conf' then type LANG=en_CA.UTF-8 Save and exit.

'nano /etc/hostname' and enter your computer name. Save and exit.

**Set Password for Root User**

'passwd' 

**Setup Sudo**

'visudo' scroll down to # %wheel ALL=(ALL:ALL) ALL and uncomment it. Save and exit.

'useradd -m -G wheel -s /bin/bash jason'

'passwd jason' 

**Edit the init**

'nano /etc/mkinicpio.conf' Scroll all the way down to HOOKS=(base udev ...)

After block in that list add 'encrypt lvm2' Save and exit.

'mkinitcpio -P'

**Setup the Boot Loader**

'grub-install --efi-directory=/boot /dev/sda'

'blkid -o value -s UUID /dev/sda2 >> /etc/default/grub' this gives the UUID of the encrypted partition and appends it to the grub setup file

'blkid -o value -s UUID /dev/mapper/cryptroot >> /etc/default/grub' this gives the UUID of the decrypted partition and appends it to the grub setup file

'nano /etc/default/grub' scroll down to the bottom of this file and cut the UUIDs that we appended there.

Scroll back up to GRUB_CMDLINE_LINUX_DEFAULT=" and paste them. Encrypted UUID first. Then Decrypted UUID. 

So it will be 

'quiet cryptdevice=UUID=EnryptedUUIDYouPasted:cryptroot root=UUID=DecryptedUUIDYouPasted"'

All that crap needs to be on the same line with a space between cryptroot and root.

Save and exit.

'grub-mkconfig -o /boot/grub/grub.cfg'

**Enable Network stuff**

'systemctl enable NetworkManager'

**Finish Up**

'exit' and 'reboot'

**Fun Extras: Setup Auto Login**

'sudo nano /lib/systemd/system/getty\@.service'

Scroll down to ExecStart=-/sbin/agetty -o '-p -- \\u' --noclear - $TERM

Edit it so it says

ExecStart=-/sbin/agetty -a jason --noclear - $TERM

Save and exit.

'sudo reboot' now the computer auto logs into the user

**Final Configs**

Install your Desktop Environment of choice and programs






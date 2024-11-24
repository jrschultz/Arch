## Arch Install - Current Year

### 01: Download, Burn and Boot from the USB

1. Go to Arch Linux downloads page https://archlinux.org/download/

### 02: Syncronize Packages

1. [Optional] Connect to WiFi using `iwctl` and check connection is established:

$ <b>iwctl</b>
[iwd]# <b>station wlan0 get-networks</b>
[iwd]# <b>station wlan0 connect &lt;Name of WiFi access point&gt;</b>
[iwd]# <b>exit</b>
$ <b>ping 1.1.1.1</b>

2. Syncronize pacman packages:

$ <b>pacman -Syy</b>

### 03: Disk Partitioning

1. **Partition main storage device using `fdisk` utility.** You can find storage device name using `lsblk` command.

$ <b>fdisk /dev/nvme0n1</b>

Nuke any existing partitions: Command (m for help): <b>d</b>

Create 2 Partitions. One for EFI and the other for everything else. Swap will be done with ZRAM.

<i>[create partition 1: efi]</i>
Command (m for help): <b>n</b>
Partition number (1-128, default 1): <b>Enter &crarr;</b>
First sector (..., default 2048): <b>Enter &crarr;</b>
Last sector ...: <b>+256M</b>

<i>[create partition 2: main]</i>
Command (m for help): <b>n</b>
Partition number (2-128, default 2): <b>Enter &crarr;</b>
First sector (..., default ...): <b>Enter &crarr;</b>
Last sector (..., default ...) <i>Rest of space</i>

<i>[change partition types]</i>
Command (m for help): <b>t</b>
Partition number (1-3, default 1): <b>1</b>
Partion typr or alias (type L to list all): <b>uefi</b>
Command (m for help): <b>t</b>
Partition number (1-3, default 2): <b>2</b>
Partion typr or alias (type L to list all): <b>linux</b>
Command (m for help): <b>t</b>

<i>[write partitioning to disk]</i>
Command (m for help): <b>w</b>

2. **Create filesystems on created disk partitions:**

$ <b>mkfs.fat -F32 /dev/nvme0n1p1</b> <i># on EFI System partition</i>
$ <b>mkfs -t ext4 /dev/nvme0n1p2</b>   <i># on Linux filesystem partition</i>

3. **Correctly mount all filesystems to the `/mnt`:**

$ <b>mount /dev/nvme0n1p2 /mnt</b>
$ <b>mkdir -p /mnt/boot/efi</b>
$ <b>mount /dev/nvme0n1p1 /mnt/boot/efi</b>

4. **Install essential packages into new filesystem and generate fstab:**

$ <b>pacstrap -i /mnt base linux linux-firmware sudo vim</b>
$ <b>genfstab -U -p /mnt > /mnt/etc/fstab</b>

### 04: Basic Configuration of New System

1. **Chroot into freshly created filesystem:**

$ <b>arch-chroot /mnt</b>

2. **Setup system locale and timezone, sync hardware clock with system clock:**

$ <b>vim /etc/locale.gen</b>   <i># uncomment your locales, i.e. `en_CA.UTF-8`</i>
$ <b>locale-gen</b>
$ <b>echo "LANG=en_CA.UTF-8" > /etc/locale.conf</b>                <i># choose your locale</i>
$ <b>ln -sf /usr/share/zoneinfo/America/Regina /etc/localtime</b>   <i># choose your timezone</i>
$ <b>hwclock --systohc</b>

3. **Setup system hostname:**

$ <b>echo <i>yourhostname</i> > /etc/hostname</b>
$ <b>vim /etc/hosts</b>
    <i>127.0.0.1 localhost</i>
    <i>::1       localhost</i>
    <i>127.0.1.1 yourhostname</i>

4. **Add new users and setup passwords:**

$ <b>useradd -m -G wheel,storage,power,audio,video -s /bin/bash <i>yourusername</i></b>
$ <b>passwd root</b>
$ <b>passwd <i>yourusername</i></b>

5. **Add wheel group to sudoers file to allow users to run sudo:**

$ <b>visudo</b>
    <i>[uncomment following line in file]</i>
    <i>%wheel ALL=(ALL) ALL</i>

6. **Install and configure GRUB:**

$ <b>pacman -S grub efibootmgr</b>
$ <b>grub-install /dev/nvme0n1</b>
$ <b>grub-mkconfig -o /boot/grub/grub.cfg</b>

7. **Setup networking stack:**

$ <b>pacman -S dhcpcd networkmanager resolvconf</b>
$ <b>systemctl enable dhcpcd</b>
$ <b>systemctl enable NetworkManager</b>
$ <b>systemctl enable systemd-resolved</b>

8. **Exit chroot, unmount all disks and reboot:**

$ <b>exit</b>
$ <b>umount /mnt/boot/efi</b>
$ <b>umount /mnt</b>
$ <b>reboot</b>

### 05: Configure XFCE Userland

1. **Activate time syncronization using NTP:**

$ <b>timedatectl set-ntp true</b>

2. **Install X.Org**

$ <b>sudo pacman -S xorg xorg-apps xorg-xinit xorg-xlsfonts xdotool xclip xsel</b>

3. **Install a bunch of useful utilities:**

$ <b>sudo pacman -S dbus</b>              <i># Message bus used by many applications</i>
$ <b>sudo pacman -S intel-ucode</b>       <i># Microcode update files for Intel CPUs</i>
$ <b>sudo pacman -S fuse2</b>             <i># Interface for programs to export a filesystem to the Linux kernel</i>
$ <b>sudo pacman -S lshw</b>              <i># Provides detailed information on the hardware of the machine</i>
$ <b>sudo pacman -S powertop</b>          <i># A tool to diagnose issues with power consumption and power management</i>
$ <b>sudo pacman -S inxi</b>              <i># Full featured CLI system information tool</i>
$ <b>sudo pacman -S acpi</b>              <i># Client for battery, power, and thermal readings</i>
$ <b>sudo pacman -S base-devel</b>        <i># Basic tools to build Arch Linux packages</i>
$ <b>sudo pacman -S git</b>               <i># Distributed version control system</i>
$ <b>sudo pacman -S zip</b>               <i># Compressor/archiver for creating and modifying zipfiles</i>
$ <b>sudo pacman -S unzip</b>             <i># For extracting and viewing files in .zip archives</i>
$ <b>sudo pacman -S htop</b>              <i># Interactive CLI process viewer</i>
$ <b>sudo pacman -S tree</b>              <i># A directory listing program</i>
$ <b>sudo pacman -S dialog</b>            <i># A tool to display dialog boxes from shell scripts</i>
$ <b>sudo pacman -S reflector</b>         <i># Script to retrieve and filter the latest Pacman mirror list</i>
$ <b>sudo pacman -S bash-completion</b>   <i># Programmable completion for the bash shell</i>
$ <b>sudo pacman -S tcpdump</b>           <i># Powerful command-line packet analyzer</i>
$ <b>sudo pacman -S mtr</b>               <i># Combines the functionality of traceroute and ping into one tool</i>
$ <b>sudo pacman -S net-tools</b>         <i># Configuration tools for Linux networking</i>
$ <b>sudo pacman -S conntrack-tools</b>   <i># Userspace tools to interact with the Netfilter tracking system</i>
$ <b>sudo pacman -S ethtool</b>           <i># Utility for controlling network drivers and hardware</i>
$ <b>sudo pacman -S wget</b>              <i># Network utility to retrieve files from the Web</i>
$ <b>sudo pacman -S rsync</b>             <i># File copying tool for remote and local files</i>
$ <b>sudo pacman -S axel</b>              <i># Light command line download accelerator</i>

4. **Install Xfce4**

$ <b>sudo pacman -S xfce4-notifyd xfce4-screensaver xfce4-screenshooter</b>
$ <b>sudo pacman -S thunar-archive-plugin thunar-media-tags-plugin</b>
$ <b>sudo pacman -S network-manager-applet</b>
$ <b>sudo pacman -S xfce4-xkb-plugin         xfce4-battery-plugin \
                 xfce4-datetime-plugin    xfce4-mount-plugin   \
                 xfce4-netload-plugin     xfce4-wavelan-plugin \
                 xfce4-pulseaudio-plugin  xfce4-weather-plugin \
                 xfce4-whiskermenu-plugin</b>

5. **Install Greeter**

$ <b>sudo pacman -S ly</b>
$ <b>sudo systemctl enable ly</b>

6. **Install Fonts**

$ <b>sudo pacman -S ttf-dejavu ttf-freefont ttf-liberation ttf-droid terminus-font otf-hermit-nerd</b>
$ <b>sudo pacman -S noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-roboto ttf-roboto-mono</b>

7. **Enable Sound Support**

$ <b>sudo pacman -S sof-firmware</b>    # Sound Open Firmware
$ <b>sudo pacman -S pulseaudio</b>      # A featureful, general-purpose sound server
$ <b>sudo pacman -S pavucontrol</b>     # PulseAudio Volume Control
$ <b>sudo pacman -S alsa-utils</b>      # Advanced Linux Sound Architecture - Utilities
$ <b>sudo pacman -S alsa-plugins</b>    # Additional ALSA plugins

8. **Enable Bluetooth**

$ <b>sudo pacman -S bluez bluez-utils blueman</b>
$ <b>sudo systemctl enable bluetooth</b>

9. **Enable Printing**

$ <b>sudo pacman -S cups cups-filters cups-pdf system-config-printer hplip</b>
$ <b>sudo systemctl enable cups.service</b>

10. **Laptop Battery Optimization** 

$ <b>sudo pacman -S tlp tlp-rdw</b>
$ <b>sudo systemctl enable tlp</b>

11. **Optimize for SSDs**

$ <b>sudo systemctl enable fstrim.timer</b>

12. **Theming**

$ <b>sudo pacman -S arc-gtk-theme adapta-gtk-theme materia-gtk-theme</b>
$ <b>sudo pacman -S papirus-icon-theme</b>

13. **Optimize Mirrors**

$ <b>sudo pacman -S reflector</b>
$ <b>sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlistbak</b>
$ <b>sudo reflector --verbose --sort rate -l 10 --country US --save /etc/pacman.d/mirrorlist</b>

14. **Reboot**:

$ <b>reboot</b>

### 06. Install Programs

$ <b>sudo pacman -S neovim rsync curl git pandoc zsh ranger gparted openssh bpytop fastfetch mpv ffmpeg samba gnome-disk-utility gimp hunspell-en-ca kate exa evince avahi scrot i3lock tar unzip zip p7zip zram-generator stow ffmpegthumbnailer tldr yubikey-manager yubikey-personalization-dui</b>

### 07. Install Yay

$ <b>git clone https://aur.archlinux.org/yay.git</b>
$ <b>cd yay</b>
$ <b>makepkg -si</b>




## Steps After Installing Arch Linux

### Update

sudo pacman -Syu

### Reflector & Mirrorlist Update

sudo pacman -S reflector

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlistbak

sudo reflector --verbose --sort rate -l 10 --country US --save /etc/pacman.d/mirrorlist

### Pacman Installs

arc-gtk-theme atril base base-devel flatpak bpytop fastfetch firefox git gparted hunspell-en_us i3lock imagemagick intel-ucode kate kitty lightdm-settings mpv nano neovim pandoc rsync scrot stow texlive-basic texlive-fontsrecommended texlive-latex texlive-latexextra texlive-latexrecommended texlive-luatex texlive-xetex vlc wget xarchiver yt-dlp zsh p7zip unrar tar exfat-utils fuse-exfat ntfs-3g flac jasper aria2 bluez blueman bluez-utils

### Pacman Tweaks

sudo nvim /etc/pacman.conf

Move down to Misc Options and uncomment & add:
Color
ParallelDownloads = 5
ILoveCandy

### Install Yay	

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

### AUR Installs

brave-bin chromium flrig fldigi gridtracker

### Activate Bluetooth

sudo modprobe btusb

sudo systemctl enable bluetooth && sudo systemctl start bluetooth

### Optional Additional Kernel Installs

sudo pacman -S linux-lts linux-lts-headers

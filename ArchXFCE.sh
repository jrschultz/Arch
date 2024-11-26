#!/bin/bash
#
# ARCH LINUX + XFCE
# =================
#
# INSTALL PROGRAMS:
# =================
sudo pacman -S acpi avahi bash-completion bpytop curl dbus dialog evince exa fastfetch fuse2 gimp git gnome-disk-utility gparted hunspell-en_ca i3lock intel-ucode inxi kate lshw ly neovim network-manager-applet openssh p7zip pandoc powertop ranger reflector rsync samba scrot stow tar thunar-archive-plugin thunar-media-tags-plugin tldr tree unzip xfce4-goodies zip zram-generator zsh
#
# INSTALL FONTS:
# ==============
sudo pacman -S noto-fonts noto-fonts-emoji otf-hermit-nerd terminus-font ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family
#
# INSTALL MEDIA:
# ===============
sudo pacman -S alsa-plugins alsa-utils blueman bluez bluez-utils ffmpeg ffmpegthumbnailer mpv pavucontrol pulseaudio sof-firmware
#
# PRINTING:
# =========
sudo pacman -S cups cups-filters cups-pdf system-config-printer hplip
#
# LAPTOP BATTERY:
# ===============
sudo pacman -S tlp tlp-rdw
#
# THEMING:
# ========
sudo pacman -S arc-gtk-theme adapta-gtk-theme materia-gtk-theme papirus-icon-theme
#
# Catppuccin Terminal Schemes:
# git clone https://github.com/catppuccin/xfce4-terminal.git
# move themes/* into: ~/.local/share/xfce4/terminal/colorschemes

# AUR HELPER:
# ===========
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg
#
# CONFIGURATION:
# ==============
sudo systemctl enable ly
sudo systemctl enable bluetooth
sudo systemctl enable cups.service
sudo systemctl enable tlp
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlistbak</b>
sudo reflector --verbose --sort rate -l 10 --country US --save /etc/pacman.d/mirrorlist
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# run nvim and :PlugInstall to activate the plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

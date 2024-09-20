# Arch Packages - Installed/ToInstall
# ###################################

# Arch rocks the set for listing installed packages
# Run the following command for a list to install on new installs
pacman -Qe | awk '{print $1}' > PackageList.txt

# Neovim

+ NerdFont needed for Nvim: https://www.nerdfonts.com/
 
+ Neovim Chad for Theming: https://nvchad.com/docs/quickstart/install

+ Wayland Copy Paste from Nvim to System Clipboard Package: wl-clipboard

# KDE Apps

sudo pacman -S okular gwenview kcalc krita kapman vail



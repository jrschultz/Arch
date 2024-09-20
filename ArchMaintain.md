#+ TITLE: Various maintenance routines for Arch
#+ AUTHOR: Jason 
#+ DATE: 20231028

# Check systemd failed services
systemctl --failed

# Log files check
sudo journalctl -p 3 -xb

# Update
sudo pacman -Syu

# Yay Update
yay -Syu

# Delete Pacman Cache
sudo pacman -Scc

# Delete Yay Cache
yay -Scc

# Delete unwanted dependencies
yay -Yc

# Check Orphan packages
pacman -Qtdq

# Remove Orphan packages
sudo pacman -Rns $(pacman -Qtdq)

# Clean the Cache
rm -rf .cache/*

# Clean the journal
sudo journalctl --vacuum-time=2weeks

# Check the size of your package cache:

du -sh /var/cache/pacman/pkg/

# You can clean it manually from time to time, but it is better to automate such a thing. That is possible with the paccache script that will clean it weekly by removing old packages and keeping 3 the most recent version of each package in case you need to downgrade some packages.

# paccache is a part of pacman contributed scripts, so install them:

sudo pacman -S pacman-contrib

# And activate the paccache timer:

sudo systemctl enable paccache.timer
# Now, paccache will check your package cache directory and clean it if necessary every week.

# There are also other more efficient ways to run it. For example, you can run paccache automatically after every system update, but it requires setting up a hook. I think weekly cleaning is fine for a new Arch Linux user.



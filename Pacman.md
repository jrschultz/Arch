## Pacman Trix

### Main Categories

Pacman uses a main command/capital letter which can be followed by lowercase letters for granular control

pacman -S -- installing/syncing local repositories

pacman -Q -- searching locally installed packages

pacman -R -- removing locally installed packages

### S Sub-Categories
pacman -Sy -- update the package database (sudo apt update)

pacman -Syu -- upgrade all my installed packages (sudo apt upgrade)

*Best practice is to always run pacman -Syu*

pacman -Ss -- search remote repositories for a package

pacman -Sc -- remove old packages from the cache. 

*The paccache script in pacman-contrib is a more automated way of dealing with this. Enable & start paccache.timer*

### R Sub-Categories

pacman -Rs -- removes a package AND dependencies 

pacman -Rns -- removes a package AND dependecies AND related system config files

*Best practice is to always run pacman -Rns*

### Q Sub-Categories

pacman -Q -- lists all locally installed packages

pacman -Qe -- lists all locally installed packages that you have explicity installed

pacman -Qeq -- lists all locally installed packages that you have explicity installed by name without version numbers

pacman -Qn -- lists all locally installed packages from main repos (via pacman)

pacman -Qm -- lists all locally installed packages from the AUR

pacman -Qdt -- lists all uneeded dependencies/"orphans"

pacman -Qs -- search for locally installed packages

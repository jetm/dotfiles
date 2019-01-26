alias e vim
abbr -a giA git add --patch

# Clear RAM Memory Cache, Buffer and Swap Space
function clean-cache-mem
  # Clear PageCache, dentries and inode
  sudo sh -c "free -h
    and sync and echo 3 > /proc/sys/vm/drop_caches
    and swapoff -a and swapon -a 
    and printf '\n%s\n' 'Ram-cache and Swap Cleared'
    and free -h"
end

function aurgen
  if not type -q updpkgsums
    echo "error: updpkgsums is not installed" 1>&2
    return 1
  end

  if not type -q namcap
    echo "error: namcap is not installed" 1>&2
    return 1
  end

  if test -f /etc/arch-release 
    or test -f /etc/manjaro-release
    # Validate PKGBUILD, update checksum package, build and generate .SCRINFO
    # file
    namcap PKGBUILD
      and updpkgsums
      and makepkg --cleanbuild --syncdeps --force
      and makepkg --printsrcinfo > .SRCINFO
  end
end

# Add format time like this:
#
# real    0.00[h:]m:s
# user    0.00s
# sys     0.00s
function time --description 'Wrapper for time'
  /usr/bin/time \
    --format "\nreal\t%E[h:]m:s.ms\nuser\t%Us\nsys\t%Ss" \
    $argv
end

#
# Arch Linux Stuff
#
if test -f /etc/arch-release
  and test -f /etc/manjaro-release
  #
  # Pacman
  #
  # Recursively removing orphans (be careful)
  abbr -a paorph sudo pacman -Rs (pacman -Qtdq)

  # Remove ALL packages from cache
  abbr -a paremALL sudo pacman -Scc

  # Remove the specified package(s), its configuration(s) and unneeded
  # dependencies
  abbr -a parem sudo pacman -Rns

  if type -q yay
    # Upgrade all packages
    abbr -a paud yay -Syu --devel

    # Install specific package(s) from local and AUR
    abbr -a pain yay -S

    # Install specific package from file
    abbr -a pains yay -U

    # Search package from local and AUR
    abbr -a pasp yay
  end
end

#
# Docker alias and functions
#

if type -q docker
  # Get images
  abbr -a dki docker images

  # Run interactive container, e.g., $dkri base /bin/bash
  abbr -a dkri docker run -i -t -P

  # Remove image
  abbr -a dkrmi docker rmi -f

  # Remove all containers
  abbr -a dkrmALL docker rm (docker ps -a -q)
end

#
# Useful Functions
#

# debug bash script
function debug
  script="$1"; shift
  bash -x "(which $script)" "$argv"
end

# vim:set ts=2 sw=2 ft=fish et:

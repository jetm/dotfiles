# Javier's dotfiles and utilities

My shell configuration files and some useful utilities. Recommended use them with zsh,
although they work fine with bash.

## Content

A brief description of each configuration file and utilities. For further details, click on
each one of them.

* Configuration files
    * [`.aliases`](https://github.com/jetm/dotfiles/blob/master/.aliases) Where the aliases are living.
    * [`.apple_keys`](https://github.com/jetm/dotfiles/blob/master/.apple_keys) Xmodmap configuration for USB aluminum Apple Keyboard.
    * [`.ccache.conf`](https://github.com/jetm/dotfiles/blob/master/.ccache/ccache.conf) ccache configuration file.
    * [`.bashrc`](https://github.com/jetm/dotfiles/blob/master/.bashrc) Standard initialization file, only for interactive mode.
    * [`.dir_colors`](https://github.com/jetm/dotfiles/blob/master/.dir_colors) Solarized color theme for the color GNU ls utility.
    * [`.git-commit-template.txt`](https://github.com/jetm/dotfiles/blob/master/.git-commit-template.txt) Template to write Git commit message.
    * [`.gitconfig`](https://github.com/jetm/dotfiles/blob/master/.gitconfig) Global Git conffiguration file.
    * [`.gitignore`](https://github.com/jetm/dotfiles/blob/master/.gitignore) Global Git untracked files to ignore.
    * [`.inputrc`](https://github.com/jetm/dotfiles/blob/master/.inputrc) Readline initialization file.

* Useful utilities
    * [`jetm.zsh-theme`](https://github.com/jetm/dotfiles/blob/master/.oh-my-zsh/themes/jetm.zsh-theme) My own oh-my-zsh prompt theme.

## Installation

```sh
$ git clone git://github.com/jetm/dotfiles
$ dotfiles/bin/install-dotfiles
```

## Remove dotfiles:

```sh
$ dotfiles/bin/install-dotfiles -u
```

## LICENSE

The software in this repository is free software: except where noted
otherwise, you can redistribute it and/or modify it under the terms of
the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any
later version.

This software is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


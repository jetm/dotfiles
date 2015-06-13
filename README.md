# Javier's dotfiles and utilities

My shell configuration files and some useful utilities. Recommended use them with zsh,
although they work fine with bash.

## Content

A brief description of each configuration file and utilities. For further details, click on
each one of them.

* Configuration files
    * [`.aliases`](https://github.com/jetm/dotfiles/blob/master/.aliases) Where the aliases are living.
    * [`.ccache.conf`](https://github.com/jetm/dotfiles/blob/master/.ccache/ccache.conf) ccache configuration file.
    * [`.bashrc`](https://github.com/jetm/dotfiles/blob/master/.bashrc) Standard initialization file, only for interactive mode.
    * [`.dir_colors`](https://github.com/jetm/dotfiles/blob/master/.dir_colors) Solarized color theme for the color GNU ls utility.
    * [`.gemrc`](https://github.com/jetm/dotfiles/blob/master/.gemrc) Personal RubyGems environment configuration file.
    * [`.git-commit-template.txt`](https://github.com/jetm/dotfiles/blob/master/.git-commit-template.txt) Template to write Git commit message.
    * [`.gitconfig`](https://github.com/jetm/dotfiles/blob/master/.gitconfig) Global Git conffiguration file.
    * [`.gitignore`](https://github.com/jetm/dotfiles/blob/master/.gitignore) Global Git untracked files to ignore.
    * [`.gpg-agent.conf`](https://github.com/jetm/dotfiles/blob/master/.gnupg/gpg-agent.conf) GnuPG-agent daemon configuration file.
    * [`.gpg.conf`](https://github.com/jetm/dotfiles/blob/master/.gnupg/gpg.conf) GnuGP options file.
    * [`.ideavimrc`](https://github.com/jetm/dotfiles/blob/master/.ideavimrc) configuration file Vim emulation plug-in for IDEs based on the IntelliJ platform.
    * [`.inputrc`](https://github.com/jetm/dotfiles/blob/master/.inputrc) Readline initialization file.
    * [`.perltidyrc`](https://github.com/jetm/dotfiles/blob/master/.perltidyrc) Global perltidy command file.
    * [`.screenrc`](https://github.com/jetm/dotfiles/blob/master/.screenrc) Screen utility configuration file.
    * [`.screen-256color`](https://github.com/jetm/dotfiles/blob/master/.terminfo/s/screen-256color)/[`.xterm-256color`](https://github.com/jetm/dotfiles/blob/master/.terminfo/x/xterm-256color) Compiled terminfo entry to support 256 colors in screen/tmux (Old OS like RedHat v5).
    * [`.tmux.conf`](https://github.com/jetm/dotfiles/blob/master/.tmux.conf) Tmux utility configuration file.
    * [`.vimrc.before.local`](https://github.com/jetm/dotfiles/blob/master/.vimrc.before.local) local [vim-spf13](http://vim.spf13.com/) configuration file.
    * [`.vimrc.bundles.local`](https://github.com/jetm/dotfiles/blob/master/.vimrc.bundles.local) local plugins [vim-spf13](http://vim.spf13.com/) configuration file.
    * [`.vimrc.local`](https://github.com/jetm/dotfiles/blob/master/.vimrc.local) vimrc configuration file used with [vim-spf13](http://vim.spf13.com/).
    * [`.ycm_extra_conf.py`](https://github.com/jetm/dotfiles/blob/master/.ycm_extra_conf.py) Global [YCM](http://valloric.github.io/YouCompleteMe/) configuration file.
    * [`.zlogin`](https://github.com/jetm/dotfiles/blob/master/.zlogin) Executes commands at login post-zshrc.
    * [`.zlogout`](https://github.com/jetm/dotfiles/blob/master/.zlogout) Executes commands at logout.
    * [`.zpreztorc`](https://github.com/jetm/dotfiles/blob/master/.zpreztorc) Prezto configuration file.
    * [`.zprofile`](https://github.com/jetm/dotfiles/blob/master/.zprofile) Executes commands at login pre-zshrc.
    * [`.zshrc`](https://github.com/jetm/dotfiles/blob/master/.zshrc) Zsh configuration file based on prezto.

* Useful utilities
    * [`colortest`](https://github.com/jetm/dotfiles/blob/master/bin/colortest) Script to test colors on terminal.
    * [`cpplint.py`](https://github.com/jetm/dotfiles/blob/master/bin/cpplint.py) A symlink to installed locally [cpplint](http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py).
    * [`do-c`](https://github.com/jetm/dotfiles/blob/master/bin/do-c) A wrapper around [c](https://github.com/ryanmjacobs/c).
    * [`install-dotfiles`](https://github.com/jetm/dotfiles/blob/master/bin/install-dotfiles) Script to install my dotfiles.

* Miscellaneous
    * [`jetm.zsh-theme`](https://github.com/jetm/dotfiles/blob/master/.oh-my-zsh/themes/jetm.zsh-theme) Personal [oh-my-zsh](http://ohmyz.sh/) prompt theme.
    * [`utils.sh`](https://github.com/jetm/dotfiles/blob/master/lib/utils.sh) Shell functions used frequently.
    * [`config`](https://github.com/jetm/dotfiles/blob/master/.mlb/config) Personal [mlbviewer](http://sourceforge.net/projects/mlbviewer/) configuration.

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


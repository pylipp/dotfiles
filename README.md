## General information

This is a collection of setup scripts, configuration files and notes that I find useful for my daily workflow and my choice of tools and environments. 

## Installation 

When setting up a vanilla system (Debian based, i.e. Ubuntu 14.04 and 16.04 as well as Stretch), I do:
```
sudo apt-get install git
cd $HOME
git clone https://github.com/pylipp/dotfiles .files
cd .files
git submodule update --init --recursive
bash setup/complete_setup.bash global
```

This will install and set up vim, zsh, and some more tools.

## Programs and tools

Some of these are not installed with `complete_setup.bash`. See `setup/` for specific installation scripts. 

Functionality | Program name | Notes
------------- | ------------ | -----
Window manager | `i3` | using bumblebee status line
Terminal | `st` | solarized color scheme
Shell | `zsh` | themes and goodies from `oh-my-zsh`
Terminal multiplexer | `tmux` | plugins loaded by `tpm`; custom session defined with `tmuxp`
VCS | `git` | additionally using `hub` for managing github workflows from the CL and `tig` for a git-log TUI
Editor | `vim` | built from source, see [vim/startup](https://github.com/pylipp/dotfiles/tree/master/vim/startup) for personal settings
Python development | `virtualenvwrapper` |
Python REPL | `ptpython` | vi-like editing; usually installing it in venvs
Python Debugger | `pudb` | vi-like editing; usually installing it in venvs
Auto environment loading | `direnv` | handy for activating venvs
Webbrowser | `qutebrowser` | vi-like key bindings
PDF reader | `zathura` | 
In-file search | `ag` |
Command-line utility | `fzf` |
Tex utility | `latexmk` |
Qt-Editor | `qtcreator` |

## TODOs

- dissect `setup.sh` into smaller installation scripts
- bumblebee status in venv

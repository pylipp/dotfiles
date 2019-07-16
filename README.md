## General information

This is a collection of setup scripts, configuration files and notes that I find useful for my daily workflow and my choice of tools and environments. 

## Installation 

### Development utilities

This will install and set up vim, zsh, tmux and some more tools.

When setting up a vanilla system (Debian based, i.e. Ubuntu 14.04 and 16.04 as well as Stretch), I do:
```bash
sudo apt-get install git
cd ~
git clone https://github.com/pylipp/dotfiles .files
bash ~/.files/setup/complete_setup.bash global
```

With [`sdd`](https://github.com/pylipp/sdd):
```bash
# Assuming git installation
git clone --recursive https://github.com/pylipp/dotfiles ~/.files
bash ~/.files/setup/basic_setup.bash
```

### Desktop environment

My DE of choice is i3. After some experiments, I decided to strive for a minimalistic configuration using package-built-in tools (i3status, i3lock). Additional scripts for system interaction (screen locking, shutdown, volume control, sensor information) can be found in `i3/`. 

For installation, run
```bash
bash ~/.files/setup/setup_i3.bash
```

## Programs and tools

Some of these are not installed with `complete_setup.bash`. See `setup/` for specific installation scripts. 

Functionality | Program name | Notes
------------- | ------------ | -----
Window manager | `i3` | using `i3status`, `i3lock` and additional scripts in `i3/`
Terminal | `st` | solarized color scheme
Shell | `zsh` | themes and goodies from `oh-my-zsh`
Terminal multiplexer | `tmux` | plugins loaded by `tpm`
VCS | `git` | additionally using `hub` for managing GitHub workflows from the CL and `tig` for a git-log TUI
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

- setup docker for testing?

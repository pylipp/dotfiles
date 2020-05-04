## General information

This is a collection of setup scripts, configuration files and notes that I find useful for my daily workflow and my choice of tools and environments. 

## Installation 

### Development utilities

This will install and set up terminal programs like vim, zsh, tmux and some more tools.

When setting up a vanilla system (Debian based, i.e. Ubuntu 14.04 and 16.04 as well as Stretch), I do:

    git clone --recursive https://github.com/pylipp/dotfiles ~/.files
    bash ~/.files/setup/basic_setup.bash

### Desktop environment

My DE of choice is i3. After some experiments, I decided to strive for a minimalistic configuration using package-built-in tools (i3status, i3lock). Additional scripts for system interaction (screen locking, shutdown, volume control, sensor information) can be found in `i3/`. 

For installation, run

    bash ~/.files/setup/setup_i3.bash

## Programs and tools

Run

    bash ~/.files/setup/install_core_utils.bash

See `setup/` for specific installation scripts.

Functionality | Program name | Notes
------------- | ------------ | -----
Window manager | `i3` | using `i3status`, `i3lock` and additional scripts in `i3/`
Terminal | `st` | solarized color scheme
Shell | `zsh` | themes and goodies from `oh-my-zsh`
Terminal multiplexer | `tmux` | plugins loaded by `tpm`
VCS | `git` | additionally using `hub` for managing GitHub workflows from the CL and `tig` for a git-log TUI. Improved diff using `delta`
Editor | `vim` | built from source, see [vim/startup](https://github.com/pylipp/dotfiles/tree/master/vim/startup) for personal settings
Python development | [`virtualenvwrapper` fork](https://github.com/pylipp/virtualenvwrapper/tree/use-venv-module) |
Python app managment | [`pipx`](https://pipxproject.github.io/pipx/)
Python REPL | `ptpython` | vi-like editing; usually installing it in venvs
Python Debugger | `pudb` | vi-like editing; usually installing it in venvs
Auto environment loading | `direnv` | handy for activating venvs
Webbrowser | `qutebrowser` | vi-like key bindings
PDF reader | `zathura` | 
In-file search | `ripgrep` |
Command-line utility | `fzf` |
Tex utility | `latexmk` |
Time tracking | `watson` |
Backup | `borg`
Pager | `bat`
File finder | `fd`
Image Viewer | `feh`
JSON processing | `jq`

## TODOs

Goal: Have distribution-agnostic system management (program configuration, installation and maintenance)

### Future development

Requirement | Specification
--- | ---
It is straightforward to set up a new system. | A setup routine exists.
It is straightforward to update the system. | An update routine exists.
Setting up the system is distribution-agnostic. | The setup routine is verified in a containerized environment.

### Dependencies

- [`sdd`](https://github.com/pylipp/sdd) is feature-complete
- `sdd` app management files exist for
    - [x] vim (at least config setup)
    - [x] qutebrowser
    - [x] Python dev environment
    - [x] ckp (use pipx)
    - [x] symlinks
    - [x] i3
    - [x] core-utils
        - [x] fzf
- systems are 'pinned'
    - [ ] sdd apps
    - [ ] pipx apps
    - [ ] vim plugins
    - [ ] venvs (?)

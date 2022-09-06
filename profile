export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

export TERMINAL=st  # set for i3-sensible-terminal
export EDITOR=vim
export BROWSER=firefox

export PYTHONSTARTUP=~/.files/pythonrc
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=~/.local/pipx/venvs/virtualenvwrapper/bin/python

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --color=never'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_COMPLETION_TRIGGER='+'
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always {} || coderay {} || head -200" --bind "ctrl-alt-j:preview-page-down,ctrl-alt-k:preview-page-up"'

[ -e ~/.local/bin ] && export PATH=~/.local/bin:$PATH
[ -e ~/.files/bin ] && export PATH=~/.files/bin:$PATH
[ -e ~/.guix-profile/bin ] && export PATH=~/.guix-profile/bin:$PATH

[ -e ~/.files/local_profile ] && . ~/.files/local_profile

export GOROOT=~/.local/go
export GOPATH=~/.local/share/goprojects
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export NVM_DIR="$HOME"/.config/nvm

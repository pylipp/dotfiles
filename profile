# set for i3-sensible-terminal
export TERMINAL="st"

export EDITOR=vim

export BROWSER=qutebrowser

export PYTHONSTARTUP=~/.files/pythonrc
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$WORKON_HOME/virtualenvwrapper/bin/python

# https://github.com/junegunn/fzf.vim/issues/732#issuecomment-437379194
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='+'
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always {} || coderay {} || head -200"'
export FZF_COMPLETION_OPTS="--preview '[[ ! -f {} ]] && \
    echo {} is not a regular file || \
    bat --style=numbers --color=always {} ||coderay {} | head -200'"

[ -e ~/.local/bin ] && export PATH=~/.local/bin:$PATH
[ -e ~/.files/bin ] && export PATH=~/.files/bin:$PATH

[ -e ~/.files/local_profile ] && . ~/.files/local_profile

[ -e ~/.config/broot/launcher/bash/br ] && . ~/.config/broot/launcher/bash/br

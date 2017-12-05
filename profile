# set for i3-sensible-terminal
export TERMINAL="st"

export EDITOR=vim

export BROWSER=qutebrowser

export PYTHONSTARTUP=~/.files/pythonrc

# make fzf search hidden directories
# https://github.com/junegunn/fzf/issues/337#issuecomment-136389913
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='+'
export FZF_CTRL_T_OPTS='--preview "coderay {} | head -200"'
export FZF_COMPLETION_OPTS="--preview '[[ ! -f {} ]] && \
    echo {} is not a regular file || \
    coderay {} | head -200'"

[ -e ~/.local/bin ] && export PATH=~/.local/bin:$PATH
[ -e ~/.files/bin ] && export PATH=~/.files/bin:$PATH

[ -e ~/.files/local_profile ] && . ~/.files/local_profile

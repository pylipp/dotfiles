# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Enable the useful Bash features:
#  - cdspell, automatically fix directory typos when changing directory
#  - direxpand, automatically expand directory globs when completing
#  - dirspell, automatically fix directory typos when completing
#  - globstar, ** recursive glob
#  - histappend, append to history, don't overwrite
#  - histverify, expand, but don't automatically execute, history expansions
#  - nocaseglob, case-insensitive globbing
shopt -s histappend histverify direxpand dirspell cdspell globstar nocaseglob

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL='erasedups:ignoreboth'
HISTSIZE=50000
HISTFILESIZE=50000
HISTIGNORE=?:??
PROMPT_COMMAND='history -a'
PROMPT_DIRTRIM=3

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWUNTRACKEDFILES=1
# add git prompt according to http://stackoverflow.com/a/24716445
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[1;41m${?#0}\033[0m\]${debian_chroot:+($debian_chroot)}\[\033[34m\]\w\[\033[33m\]$(__git_ps1 | tr "*" "~" | tr "%" "*" | tr "<" "V" | tr ">" "^" | sed "s/\([~+*V^=<>]\)/ \1/g")\[\033[00m\]\n\[\033[1m>\033[0m\] '
else
    PS1='${?#0} ${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.files/bash_aliases ]; then
    . ~/.files/bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d ~/.local/share/bash-completion ]; then
    # Source custom completion files
    while IFS= read -r -d '' f; do
        . "$f"
    done < <(find ~/.local/share/bash-completion -type f -print0)
fi

export SHELL=/bin/bash 

if [ -f ~/.files/extra_shrc ]; then 
    . ~/.files/extra_shrc 
fi

if [ -f ~/.files/local_shrc ]; then 
    . ~/.files/local_shrc 
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

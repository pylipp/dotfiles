# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# I tried: agnoster, bullet-train, spaceship, avit
ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title (required by e.g. tmuxp)
export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(pip colored-man-pages)

# Custom site-functions (e.g. completions). Run before sourcing oh-my-zsh.sh because there
# compinit is called to setup all available completions
fpath=(~/.local/share/zsh/site-functions $fpath)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

# http://superuser.com/questions/439209/how-to-partially-disable-the-zshs-autocorrect
unsetopt correct_all
setopt correct

# http://unix.stackexchange.com/questions/126719/how-to-disable-auto-cd-in-zsh-with-oh-my-zsh
unsetopt AUTO_CD

# Ignore duplicates and commands starting with whitespace; https://wiki.gentoo.org/wiki/Zsh/Guide#Prompts
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Edit current command line in $EDITOR. https://unix.stackexchange.com/a/6622/192726
bindkey -M vicmd ' ' edit-command-line

if [ -f ~/.files/bash_aliases ]; then
    . ~/.files/bash_aliases
fi

if [ -z "$SHELL" ]; then
    export SHELL=/usr/bin/zsh
fi

if [ -f ~/.files/extra_shrc ]; then 
    . ~/.files/extra_shrc 
fi

if [ -f ~/.files/local_shrc ]; then 
    . ~/.files/local_shrc 
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
[ -f ~/.files/fzf_custom.zsh ] && source ~/.files/fzf_custom.zsh
[ -f ~/.files/grc.zsh ] && source ~/.files/grc.zsh

[ -f ~/.dir_colors ] && eval `dircolors ~/.dir_colors`

# General, safe setup for bash/zsh acc. to https://direnv.net/ (section Setup)
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook $(basename $SHELL))"

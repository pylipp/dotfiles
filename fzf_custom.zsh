# Custom key bindings
# CTRL-P - Open fzf'ed file in vim
fzf-vim-widget() {
    # copied/adapted from __fsel() in .fzf/shell/key-bindings.zsh
    local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
    local out=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@")

    # inspired by http://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf
    # open requested file in editor if regular; this handles searches aborted with C-c
    if [[ -f "$out" ]]; then
        vim "$out" < /dev/tty
    fi

    zle reset-prompt
}

# register widget and assign keybinding
zle -N fzf-vim-widget
bindkey '^P' fzf-vim-widget

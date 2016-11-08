alias svn='colorsvn'

alias ipp='ipython --pylab'
alias gitkall='gitk --all'

# http://stackoverflow.com/questions/20327621/calling-ipython-from-a-virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Copy file content to clipboard or from clipboard to commandline
# http://superuser.com/questions/113529/how-can-i-load-a-files-contents-into-the-clipboard
alias pbcopy='xclip -i -selection c '
alias pbpaste='xclip -o -selection c '

# repeat definition for zsh
alias ll='ls -alF'

# enable 256color support in tmux
alias tmux='tmux -2'

# start feh with custom action for save (re)moving
alias feh='feh --action1="mv %F /tmp" --scale-down --action2="echo $(pwd)/%F >> ~/Pictures/copy_list"'

alias ag='ag --path-to-agignore ~/.files/gitignore_global'
alias rg='rg --ignore-file ~/.files/gitignore_global'

alias z=zathura

# http://stackoverflow.com/questions/20327621/calling-ipython-from-a-virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

alias mkvenv35="mkvirtualenv --python=/usr/bin/python3.5 "

alias dotfiles='cd ~/.files'

alias popdd='popd; popd'

# Copy file content to clipboard or from clipboard to commandline
# http://superuser.com/questions/113529/how-can-i-load-a-files-contents-into-the-clipboard
alias pbcopy='xclip -i -selection c '
alias pbpaste='xclip -o -selection c '

# repeat definition for zsh
alias ll='ls -alF'

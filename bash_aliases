# start feh with custom action for save (re)moving
alias feh='feh --action1="mv %F /tmp" --scale-down --action2="echo $(pwd)/%F >> ~/Pictures/copy_list"'

alias ag='ag --path-to-agignore ~/.files/gitignore_global'
alias rg='rg --ignore-file ~/.files/gitignore_global'

alias z=zathura
alias s=sxiv

alias mkvenv35="mkvirtualenv --python=python3.5 "
alias mkvenv36="mkvirtualenv --python=python3.6 "
alias mkvenv37="mkvirtualenv --python=python3.7 "
alias mkvenv38="mkvirtualenv --python=python3.8 "

alias dotfiles='cd ~/.files'

alias popdd='popd; popd'

# Copy file content to clipboard or from clipboard to commandline
# http://superuser.com/questions/113529/how-can-i-load-a-files-contents-into-the-clipboard
alias pbcopy='xclip -i -selection c '
alias pbpaste='xclip -o -selection c '

alias l='ls -alF'

alias fl='fina list --filters date=2021-'

alias nc="nmtui connect"

# Watson Restart Previous
alias wrp="watson restart -2"

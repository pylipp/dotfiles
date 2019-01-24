# start feh with custom action for save (re)moving
alias feh='feh --action1="mv %F /tmp" --scale-down --action2="echo $(pwd)/%F >> ~/Pictures/copy_list"'

alias ag='rg --ignore-file ~/.files/gitignore_global'
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

# some shortcuts for handling VMs
# docs: https://www.virtualbox.org/manual/ch08.html
function vmon() {
    if [[ "$#" -ne 1 ]]; then 
        echo "USAGE: vmon <vm>"
    else
        VBoxManage startvm "$1" --type headless
    fi
}
function vmoff() {
    # http://stackoverflow.com/questions/31695600/bash-rematch-doesnt-capture
    setopt KSH_ARRAYS BASH_REMATCH
    if [[ "$#" -eq 0 ]]; then
        running_vms=`VBoxManage list runningvms`
        vm_regex='"(.*)" .*'
        if [[ $running_vms =~ $vm_regex ]]; then
            echo Stopping ${BASH_REMATCH[1]}... 
            VBoxManage controlvm "${BASH_REMATCH[1]}" savestate
        else 
            echo "USAGE: vmoff <vm>"
        fi
    else
        VBoxManage controlvm "$1" savestate
    fi
    unsetopt KSH_ARRAYS
}

scrot() {
    /usr/bin/scrot --exec 'mv $f ~/Pictures' "$@"
}

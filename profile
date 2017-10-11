[ -e ~/.local/bin ] && export PATH=~/.local/bin:$PATH
[ -e ~/.files/bin ] && export PATH=~/.files/bin:$PATH

[ -e ~/.files/local_profile ] && . ~/.files/local_profile

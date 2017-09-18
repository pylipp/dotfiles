#/bin/bash 

# TODO: move existing vimrc
vimrc=$HOME/.vimrc

for file in settings functions mappings; do
    echo "source ~/.vim/startup/$file.vim" >> $vimrc 
done

echo
read -n 1 -p "Install vim plugins? y/n " reply
echo
if [[ "$reply" == 'y' ]]; then 
    echo "source ~/.vim/startup/plugins.vim" >> $vimrc 
fi 

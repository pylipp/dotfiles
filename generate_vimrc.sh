#/bin/bash 
echo "set nocompatible" >> vimrc
echo >> vimrc

echo
read -n 1 -p "Install vim plugins? y/n " reply
echo
if [[ "$reply" -eq 'y' ]]; then 
    echo "source ~/.vim/startup/plugins.vim" >> vimrc 
fi 

for file in settings mappings functions; do
    echo "source ~/.vim/startup/$file.vim" >> vimrc 
done

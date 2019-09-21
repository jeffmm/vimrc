#!/bin/bash
cp vimrc ~/.vimrc
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    if hash git 2>/dev/null; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    else
        echo "Git not found on this system! Install git and run: "
        echo "  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
        exit 1
    fi
fi
if hash vim 2>/dev/null; then
    vim +PluginInstall +qall
else
    echo "Vim not found on this system! Install vim and run: "
    echo "  vim +PluginInstall +qall"
fi



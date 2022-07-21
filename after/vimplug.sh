#!/bin/bash
set -e
if [ ! -e ~/.vim/autoload/plug.vim ]; then
  echo "Downloading plug.vim..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

NEOVIM_PLUG="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
if [ ! -e $NEOVIM_PLUG ]; then
  echo "Downloading plug.vim for neovim..."
  curl -fLo $NEOVIM_PLUG --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


echo "Now run :PlugInstall to install all plugins"

#!/bin/bash
set -e
if [ ! -e ~/.vim/autoload/plug.vim ]; then
  echo "Downloading plug.vim..."
  curl -fLo  --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Now run :PlugInstall to install all plugins"

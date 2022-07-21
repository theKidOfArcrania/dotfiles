if [ -v WSLENV ]; then
  if [ ! -d /mnt/c/cygwin64/bin ]; then
    echo "Need cygwin to be installed for sound!"
    exit 1
  fi

  if [ ! -f /mnt/c/cygwin64/bin/pulseaudio.exe ]; then
    echo "Need pulseaudio to be installed in cygwin!"
    exit 1
  fi
fi

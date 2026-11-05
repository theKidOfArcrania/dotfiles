if [ -v WSLENV ]; then
  if [ ! -d /mnt/c/cygwin64/bin ]; then
    echo "warn: Need cygwin to be installed for sound!"
    exit 0
  fi

  if [ ! -f /mnt/c/cygwin64/bin/pulseaudio.exe ]; then
    echo "warn: Need pulseaudio to be installed in cygwin!"
  fi
fi

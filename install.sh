#!/bin/bash

set -eu

cd $(dirname "$0")

IGNORES=( \\. \\.\\. \\.git install\\.sh .*sw. after before \\.gitignore )

for script in before/*; do
  if [ -e "$script" ]; then
    echo "$script:"
    "$script" || (echo "Exited with error $?" && exit 1)
  fi
done

for file in $(ls -a); do
  for ignore in "${IGNORES[@]}"; do
    if echo $file | grep -E "^$ignore\$" 2>/dev/null >/dev/null; then
      continue 2
    fi
  done

  outfile="$HOME/$file"

  if [ -e "$outfile" ]; then
    if [ -h "$outfile" ]; then
      rm $outfile
    elif [ -f "$outfile" -o -d "$outfile" ]; then
      echo "WARNING: $outfile: exists regular file or directory"
      continue
    else
      echo "WARNING: $outfile: unknown file type"
      continue
    fi
  fi

  echo "Linking $file..."
  ln -s "$PWD/$file" "$HOME/$file"
done

for script in after/*; do
  if [ -e "$script" ]; then
    echo "$script:"
    "$script" || (echo "Exited with error $?" && exit 1)
  fi
done


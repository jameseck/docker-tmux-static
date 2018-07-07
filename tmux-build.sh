#!/bin/sh
set -o pipefail
set -e

if [ -e ~/bin/tmux ] && [ "$1" != "-f" ]; then
  echo "tmux binary already exists in ~/bin/"
  echo "Pass -f to force overwrite"
  exit 1
fi

docker build -t tmux .
docker run --rm tmux cat /tmux/tmux > ~/bin/tmux && chmod +x ~/bin/tmux
docker rmi tmux


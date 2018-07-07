#!/bin/sh
set -o pipefail
set -e

FORCE=0
while getopts ":fv:" opt; do
  case ${opt} in
    v )
      VERSION=$OPTARG
      ;;
    f )
      FORCE=1
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

if [ -e ~/bin/tmux ] && [ "${FORCE}" != "1" ]; then
  echo "tmux binary already exists in ~/bin/"
  echo "Pass -f to force overwrite"
  exit 1
fi

docker build --build-arg="VERSION=$VERSION" -t tmux .
docker run --rm tmux cat /tmux/tmux > ~/bin/tmux && chmod +x ~/bin/tmux
docker rmi tmux


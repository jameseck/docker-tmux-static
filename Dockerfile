FROM debian:stretch

MAINTAINER James Eckersall <james.eckersall@gmail.com>

ARG VERSION=2.6

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install libevent-dev ncurses-dev build-essential wget g++ gcc git automake autoconf libtool pkg-config -y
RUN mkdir /tmux

ADD build.sh /tmux/build.sh
RUN bash -c "cd /tmux; chmod +x build.sh; bash ./build.sh"

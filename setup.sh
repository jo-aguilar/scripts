#!/bin/sh

sudo apt-get -y update --allow-releaseinfo-change
sudo apt-get install -y vim
sudo apt-get install -y build-essential
sudo apt-get install -y tty-clock
sudo apt-get install -y tmux
sudo apt-get install -y git
sudo apt-get install -y rpl
HOME=~
DIR="/conio.h/"
if [ ! -d "$HOME$DIR" ]; then
    git clone https://github.com/zoelabbb/conio.h
    sudo scp ~/conio.h/conio.h /usr/include/
fi

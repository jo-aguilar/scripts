#!/bin/sh

sudo apt-get -y update --allow-releaseinfo-change
sudo apt-get install -y vim
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y tty-clock
sudo apt-get install -y tmux
sudo apt-get install -y git
sudo apt-get install -y rpl
sudo apt-get install -y gdb

#instalar rakudo
mkdir ~/rakudo && cd $_ &&
curl -LJO https://rakudo.org/latest/rakudo/src &&
tar -xvzf rakudo-*.tar.gz &&
cd rakudo-* &&
perl Configure.pl --backend=moar --gen-moar &&
make &&
make install &&
echo "export PATH=$(pwd)/install/bin:$(pwd)/install/share/perl6/site/bin:\$PATH" \
    >> ~/.bashrc &&
source ~/.bashrc &&

#instalar zef
cd /tmp/ &&
git clone https://github.com/ugexe/zef.git &&
cd zef &&
raku -Ilib bin/zef install .


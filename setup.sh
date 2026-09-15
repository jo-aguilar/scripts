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
sudo apt-get install -y sox libsox-fmt-all
sudo apt-get install -y alacritty
sudo apt-get install -y pulseaudio-utils

# 1. Cria os diretórios necessários em ~/.config
mkdir -p "$HOME/.config/alacritty/sounds"

# 2. Gera o arquivo de áudio (450 Hz, 150 ms, fade para evitar estalos)
SOX_OUT="$HOME/.config/alacritty/sounds/beep_450.wav"
sox -n -r 44100 -c 1 "$SOX_OUT" synth 0.150 sine 450 fade h 0.005 0.150 0.025 vol 0.7

# 3. Escreve a configuração no alacritty.toml
cat <<EOF > "$HOME/.config/alacritty/alacritty.toml"
[bell]
animation = "Off"
duration = 0
command = { program = "/usr/bin/paplay", args = ["$SOX_OUT"] }
EOF

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


 #!/bin/bash
 
 sudo apt-get -y update
 sudo apt-get -y upgrade
 sudo apt-get -y full-upgrade
 sudo apt-get -y autoremove
 flatpak -y upgrade
 sudo snap refresh
 

#!/bin/sh

port=22
thepath=/etc/ssh/sshd_config

sudo sed -i "$(sudo grep -m1 -n "Port " $thepath | cut -d: -f1)c Port $port" $thepath
sudo sed -i "$(sudo grep -m1 -n "AliveInterval" $thepath | cut -d: -f1)c ClientAliveInterval 3600" $thepath
sudo sed -i "$(sudo grep -m1 -n "MaxAuthTr" $thepath | cut -d: -f1)c MaxAuthTries 6" $thepath
sudo sed -i "$(sudo grep -m1 -n "X11Forwarding" $thepath | cut -d: -f1)c X11Forwarding no" $thepath
#sudo echo "Protocol 2" >> $thepath
#sudo semanage port -a -t ssh_port_t -p tcp $port
sudo systemctl enable sshd
sudo systemctl restart sshd


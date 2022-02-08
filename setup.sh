#!/bin/bash
sudo apt update
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt install stunnel -y
sudo apt install dropbear -y
sudo apt install gcc -y
sudo apt install make -y
sudo apt install cmake -y
sudo apt install build-essential -y
sudo apt install python -y
sudo apt install unzip -y
sudo apt install zip -y
sudo apt install net-tools -y
sudo apt install python -y
sudo apt install libpam-cracklib -y
sudo apt install squid -y
sudo apt install iptables-persistent -y
sudo apt install apache2 -y
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/dropbear -O /etc/default/dropbear
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/banner.dat -O /etc/banner.dat
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel.pem -O /etc/stunnel/stunnel.pem
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel.conf -O /etc/stunnel/stunnel.conf
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel4 -O /etc/default/stunnel4
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/squid.conf -O /etc/squid/squid.conf
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/ports.conf -O /etc/apache2/ports.conf
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/000-default.conf -O /etc/apache2/sites-enabled/000-default.conf
systemctl enable squid
systemctl enable apache2
chmod o-r /etc/stunnel/stunnel.pem
/etc/init.d/stunnel4 restart
cd $HOME
wget https://github.com/ambrop72/badvpn/archive/master.zip
unzip master.zip
cd badvpn-master/
mkdir build
cd build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
sudo make install
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/udpgw.service -O /etc/systemd/system/udpgw.service
sudo systemctl daemon-reload
sudo systemctl enable udpgw.service
sudo systemctl start udpgw.service
cd $HOME
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/PDirect.py -O /home/ubuntu/PDirect.py
wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/PDirect.service -O /etc/systemd/system/PDirect.service
sudo systemctl daemon-reload
sudo systemctl enable PDirect.service
sudo systemctl start PDirect.service
sudo useradd -M itunnel -p itunnel -s /bin/false
echo /bin/false >> /etc/shells
echo /usr/sbin/nologin >> /etc/shells
iptables -I OUTPUT -p tcp --dport 25 -j DROP
iptables -I OUTPUT -p tcp --dport 465 -j DROP
iptables -I OUTPUT -p tcp --dport 587 -j DROP
iptables -I OUTPUT -p tcp --dport 2525 -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
netfilter-persistent save
netfilter-persistent reload

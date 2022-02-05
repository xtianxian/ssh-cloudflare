sudo apt install stunnel dropbear gcc make cmake build-essential python unzip zip net-tools python libpam-cracklib -y

wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/dropbear -O /etc/default/dropbear

wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/banner.dat -O /etc/banner.dat

wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel.pem -O /etc/stunnel/stunnel.pem

wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel.conf -O /etc/stunnel/stunnel.conf

wget https://raw.githubusercontent.com/xtianxian/ssh-cloudflare/main/stunnel4 -O /etc/default/stunnel4

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

sudo useradd -M username -s /bin/false

sudo passwd username

sudo shutdown -r now

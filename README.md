sudo apt install stunnel dropbear gcc make cmake build-essential python unzip zip net-tools

sudo nano /etc/default/dropbear

sudo nano /etc/banner.dat

cd /etc/stunnel

openssl genrsa -out key.pem 2048

openssl req -new -x509 -key key.pem -out cert.pem -days 1095

cat key.pem cert.pem > /etc/stunnel/stunnel.pem

wget https://github.com/xtianxian/ssh-cloudflare/blob/main/stunnel.conf

nano /etc/default/stunnel4

/etc/init.d/stunnel4 restart

netstat -tulpn

cd $HOME

wget https://github.com/ambrop72/badvpn/archive/master.zip

unzip master.zip

cd badvpn-master/

mkdir build

cd build

cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1

sudo make install

cd $HOME


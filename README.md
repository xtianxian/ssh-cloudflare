sudo apt install stunnel dropbear gcc make cmake build-essential python unzip zip net-tools

sudo nano /etc/default/dropbear
sudo nano /etc/banner.dat

cd /etc/stunnel
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem > /etc/stunnel/stunnel.pem
wget https://gitlab.com/PANCHO7532/scripts-and-random-code/-/raw/master/nfree/stunnel.conf
nano /etc/default/stunnel4
/etc/init.d/stunnel4 restart
netstat -tulpn

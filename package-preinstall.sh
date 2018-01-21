apt-get update
apt-get install -y openvpn
mkdir -p /etc/openvpn/
cp openvpn/* /etc/openvpn/
install -D -m 0755 aishub-aisdispatcher/aisdispatcher /usr/local/bin/aisdispatcher

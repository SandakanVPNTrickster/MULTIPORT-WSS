#!/bin/bash
#
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=MY
state=MALAYSIA
locality=SABAH
organization=Blogger
organizationalunit=Blogger
commonname=none
email=admin@squidvpn.systems

# simple password minimal
curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/password | openssl aes-256-cbc -d -a -pass pass:scvps07gg -pbkdf2 > /etc/pam.d/common-password
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END


# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#install jq
apt -y install jq

#install shc
apt -y install shc

# install wget and curl
apt -y install wget curl

#figlet
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config


install_ssl(){
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            else
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            else
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi
}

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/nginx.conf"
rm /etc/nginx/conf.d/vps.conf
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/vps.conf"
/etc/init.d/nginx restart

mkdir /etc/systemd/system/nginx.service.d
printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf
rm /etc/nginx/conf.d/default.conf
systemctl daemon-reload
service nginx restart
cd
mkdir /home/vps
mkdir /home/vps/public_html
wget -O /home/vps/public_html/index.html "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/multiport"
wget -O /home/vps/public_html/.htaccess "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/.htaccess"
mkdir /home/vps/public_html/ss-ws
mkdir /home/vps/public_html/clash-ws
# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# setting port ssh
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'
# /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "=== Install Dropbear ==="
# install dropbear
#apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

cd
# install stunnel
#apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 222
connect = 127.0.0.1:22

[dropbear]
accept = 777
connect = 127.0.0.1:109

[ws-stunnel]
accept = 2096
connect = 700

[openvpn]
accept = 442
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart


# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# banner /etc/issue.net
sleep 1
echo -e "[ ${green}INFO$NC ] Settings banner"
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/issue.net"
chmod +x /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# download script
cd /usr/bin
wget -O speedtest "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/speedtest_cli.py"
wget -O xp "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/xp.sh"
wget -O auto-set "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/auto-set.sh"
chmod +x speedtest
chmod +x xp
chmod +x auto-set
cd


cat > /etc/cron.d/re_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 7 * * * root /sbin/reboot
END

cat > /etc/cron.d/xp_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/bin/xp
END

cat > /home/re_otm <<-END
7
END

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

# remove unnecessary files
sleep 1
echo -e "[ ${green}INFO$NC ] Clearing trash"
apt autoclean -y >/dev/null 2>&1

if dpkg -s unscd >/dev/null 2>&1; then
apt -y remove --purge unscd >/dev/null 2>&1
fi

# apt-get -y --purge remove samba* >/dev/null 2>&1
# apt-get -y --purge remove apache2* >/dev/null 2>&1
# apt-get -y --purge remove bind9* >/dev/null 2>&1
# apt-get -y remove sendmail* >/dev/null 2>&1
# apt autoremove -y >/dev/null 2>&1
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
sleep 1
echo -e "$yell[SERVICE]$NC Restart All service SSH & OVPN"
/etc/init.d/nginx restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting nginx"
/etc/init.d/openvpn restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting cron "
/etc/init.d/ssh restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting ssh "
/etc/init.d/dropbear restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting dropbear "
/etc/init.d/fail2ban restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting fail2ban "
/etc/init.d/stunnel4 restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting stunnel4 "
/etc/init.d/vnstat restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting vnstat "
/etc/init.d/squid restart >/dev/null 2>&1

screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile


rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh
rm -f /root/bbr.sh

# finihsing
clear
i��wg��/G�J�|���hd���wJ,��!����xc׸�0ѿŋX��G��9�!�� Br�n����6n��j����|S'�_ȍ��E�>LI��SP�FN�t�+7*95���/��*��G��B/��X ����9	�"q�;�H�E� �����!TRD���V���_8����AR?��,��o�MQ>e��ä������Ѕ/�=' l^�n_x@��3pD�S>��
��-osse�/��FE �j�b�^�!�ļx��uW�}]%B}-6�A��Ѣ�m��g�X�cɊ�gW��Li�Ẁ��j�(��Ƒ#��"\L�]r��A���q1�v1#�
�l������#f#9e!Y���n��;��K�q�F�|��$��qf�=>$��z��#1�t� 'z��	��������#�M
��z�nV�]�'a.���򊓉0����Z\��c�KϏ�3�_ѫ���5;�4p�)�Пr���x�����*(�h����@�]dG�����$<�b`0��6� ��5����ē�S��b��O��q8/�V�1���YB5�9Kr�{,�� ��������!��o�vGn�1|��
iP�p;VV[x��$Jx�1j|���T�Z�m(��{�Ў���G�Oq�(��˷(h5�:�$�F��[���k�>��/S6������Ȍ��x{�)��,��VS�lչ5�l��nOF�u�=�?���/#�\�(��� ����+�r{L���亂�8}�D�u��Wn�84�~OS�i�Р�%Y}X��8���&_�
��
~�� 
I������%f���l �ӘT�j7���;�.�K���E?��6�:59�����o�!�jV �wI�&�Ac+3gb&
Gh��t|`�� �G9q�H|O����/uLk�ڿv��H��>�A�����M�#��R'��T6x��Ф��.��M m#���9�.xR����������67��g>'���~�:�2�w�%"��ZV�����pvr�&���?�A��.��"�+�ݮ�u.,��$J��B�D���67�.ͨS����=�7 ~���+8�s��������I��"
'�Oˮ�;��_o��y����!��K�A��_S�ǚw.َ���ZKZ3V�@��o� v�^�2�Y����Wf��¾�~���4G��1�6D�"�x�����Vo�����BFs�ל�~KdLJ+����تW�@}5�J���²w���A6��:+|d�~��
�(�d^�b�p�	�5A�0����j��?�dX6m����G�U��m��B��O��:���f[׽�{�u�����I<
vQ�~:��OI�ݓ�4T�ٙ�ߍ!f�a=n:ꋚ=��Euύ|�3����n�bh{��W�����P�ׂ����z%4G	�L8���GlA�,E��
�*,�.��}������o����&��u��+��(PN�7#�M�0�I|���7�N��뇃ŅJ[��1+4O��gc�t����E��%'�"})�<DLyK����&k�_��H?�.�+`_?�-�G�L�5���SO�w�JY�c�R@��q0��v��?
�fKJfhz�
�oF��*��>"��_�>V��(� �#��z��f�E�-��ʾ���D ��DiFuCx�#�Q�#Ȃ�L�ŝ�6z ��
��9��b�빊�[�ac����Y��uE)�U����A�5s^DP�2��5��+0�Å0G�7�vE���6����ܪ�X@k�w�C�+=(-����UG��TB[���j��ϝ�K��R\g��yC%��QܮG@�b��X�#�=i���$v�j�^���\$OJ��) |��pY-�S�>��iOY.C*2B�3ä+�Cҟ:P̠ �+`��;� ���Ö���t	��tj!�mVѣ"wj�+��r1��HZZ6��OKTձa��ߏ��iM���u��V����>�Z(�N�<�H?v}A;���3X��:����R�w�Wmc����p�^��gq8�q
���O��5h'Ԏ.��F^���t/�G�����x­�o=��1�; ��y��Ȕ�W'��Jh����Uz�Io����>�x[�)|
Q�G�n��s��mTf'(yO๓w"���M�(K{ȈL cs��<����{,�(4�1%s(�Q��7|b5�`�	D� '�~5�o~���9V'%Z���d��tf��s�D,Q�;f�`JvY����$"]�b>WYs������GN@��x��Q��{�}�B��h�֘���i6qeZ�P���ݛYeK,��d��
/� U�z-����4x^��4�<���/ÖK
�=@��Ih�0T
���~��X;�[���%�83H-#�Y��!���^������CS}�i�q�u�s���Ӛ\�8X�h�w#�HI�`SU�X'ګ�]RuK}�?��u�,���CpRp��y	"R�Uc_m�'�����E�R��n>��j����� ^VL�O|g��̾�	�@%���a�fOP���2N\N�&�4��wA%MK��]*ݖ˵���Ś�ݎ�ѫ����w���� E��R:��6B�EUk�?츏W��=r�EtN+&`�}�.kPc�í5+<Tg��U@�t'�v���Ig���|ղ�+��^t�������&�՘��w�z ؀�	:@P�N��	�}P� ���Û�YI�/Q� ʭ�H�k
��i��f����%{@����M���\�S��M�����C�%�
�����e_:�E�RNPlW�9�����?N��� zҩ�����Uj;��%[��@:/%�dg��S�Eړë.�$���DL�3ZW� �nS��.�\;$�kk�vˤ�;'��VP���z���L�?^^4B��(G�p7Ɖ�:�:��|�2a�Q@v�_�@�����a�/V��;0�
^�.���G���QB�9��J�|xy��N��{C�[�~c�/~�N��%�<�wk$�����а�Ɣ���T͔�8ͱadx�gQ⭤Z=�ʲ�M����;M�ѬIw�KGLq�p%)o�|k�'�Z���+���K���u�hN.L����
����B�wO=�SC�)�P�W�36�4j�pKt��G��`�@��ӝ��aDt����?�1YOչ6/�h�5��8���q4�Q�B�#_�-8�������C�m:��������
��̰�y�l��_0��S~G�>Gr���[/}| �	�ž�C�����D<���z�E�@L�����¼��3�&�jIƞhf"c	b~ҲEՈ����o�������m4e�#�����j�L7��$Zд�,!S��E�Y���Ġ���O^���9�ng@��@�3��h
,F���6&x�����>c��H���C���-䝽�f� 4;�f`TT��v�p$�f�/����B��n�F����1QӑA������q���ۢ˳t����a��wc���䌹Z��sF��ˡg��+�����gd�$�����6W����u���_}X�R�|���K��:�Zb�7Q� 6QTOss�͟�]_Ȃ���"ᭋ@�k���|I��rG�)A��!芩�?L�Ҽ��,Ӵ��ӥ;�Pu�؎�A*?z��J㚝�k��^�
ӑ�E8u�yВ��E���U����b�fW�����\}OJ���R��B������R+�;�7�-\���+s5a�c�/ޏ�%8R�F�9iJ��R��C���ǩ�! [F(���L����T�FӞb���;b��OLu���(?4��w���t$�
�����;9�$t��W��
��_Z�Bx�X�`������Ӫ�� H���rTvSO�Ft-�ޅ!�,��Q,z
��u���BB�bߓE������� �N�:��r�L�~����=!�����-��<S�!Fj�L����
;I�RPJw8���p�U�h�����u������=<5��Dm�Y�Q5�����Z��
W�L�s6�T�c��N�F����\�~ׯ���s���!%�8�)���ӗ�f�G��9]v��#+Љϭ��us?�)c��B*���#�I��BC��;)�Oѝ��E#�hY���Oۋ�D��Q��e�hJb8�
��%��*W����ÿw�Y��m�뾔�?�+������4{�s��@#��sz���$�Y8zO���g���?�)�/;�N�lkAՈ�\�Z]���r؟.<�~�1J��j#�O�;pQ�e����J�	�[8�w�`-=�퓥fDOű�FB��1�%���M��>
P�ۉ�B���=��5blIm{T�ܠ��B��P�l#4�lz���F�J���x�e.;������:5l3��5% g���E'�T�nC���(�?���u�3CQvq�F�QU����۲	������43w-M��qv�Z��׎vGB��6�r�1@�x8e~ PX��q��1�W"��C�=�g���v�L�&S�4����ye15抨��o�`��5%X7LH��p_�����H����~흚o�P�Pj ]�^|*�����k�ī%n����,27�֤�?�� ˟��[3}B���wrMs5k(+�|�(V1�\P�0'_6�|���������3�ձ�������n���ti�mж�j�]/��Juu���A�OݎoϠ�R��3xZ�G`�)�Q�����P��v���8x/|Z��1䬵p��&����?��j;j�ó7�_.��M��n�O$��08���cw�\p�Y<C���ԧmoOy����0����hp�C�k��66�����HH\j�����xI�]d ��5.F���v���	�y28�#j$@k&���)M�O��`���C�u,�=���ӿ�.���Lܺt���MOl��n�1~7�dVt`���m�Ҙ�?/I� �_X2��&��޳�L������yR��2~NS�^e�)K�d\�����
!��_JC���VR+tr����J
_�W��������6�Ս�Kyh����Ǭ�i�,^+ß<���E� !�*��у��ya'oo��58���-�5Sl4�t��JA'��`f��@Y	P���Al·�[�!Dn���Е��2d!�Q�;.,�,�}�nfL��T�_�)�Ȑ�y��S��8W��ZV�_��7��SCΐ�W���>�
8�+|�U���ʿ��F��2�d���ONV�^~ Zd��Y<Φ���'�t9g♦�<���+='i\̚�
äP`��q��L���B���!p�dnte���ve9�����a��ޞ�*4'�
�L��P��&����m�Q��b��G���[,<���KbQe�t����g�/�U!�L�ATr/�K1.aU�M/���8�&Y�:�K/P>W��{𠧡K�r���<��[h�e��ً�v�.6tK���=ʮc:ߗ��\���*^h�Z���9t������S�Y-��uw&�)om�n�������C�>\T�?�����I�q�p����8s���>��v ����"0�2R-���s�ѧ��r>�h��{����vN7qt`5�pn�4���!�<[��H�)���.u�L���cFm��Uiu��xrSK1j�[ߺ2�܍�9�8��@��X��F���2l�X�V���pjԡ�0��4�ڇ鬻Oܜ���jJD��i�Nh���%�0��*k oAIdF�5~B��=�������+!�qkX��6�hڨ�n������((%˨T +q�q8b8_�	�y�y���jLnU��U�8�J���y"{���`d���B�;�m��~��$[A	�i^qԻN��u����x| ݿ��d�5e�{.������.l�Ǽ/��J˸�:��Ƥv�2�5��0 H�j*b ��%50%��S�M���33,	��0�6�M\'
r�Ј��{F]��_
9ɔ*�QtX�Cs���w�����[˘�A��ܙmM��"j�E~�2D�=X;�]�����p�kN���#'�)|\Mj��n�a�E��#99�zL��;���w�苪�&>��"ع ��.%0���Ms$��%;7�B�\SoCf��&�)z.�YL��d ȷ8
O,�c,�̎����Q��x@�o'G1��6�)��/�j��rn����M�������J�lt{����OE�������,X%T"}�&Z<[����T�mʨ@u�o���y�@J�:�P�w���;"�rz�n%�9����;�CSs�q.��	���[�N�~�o�M`����
�D`ަ�3�L|{���0����=8�bf_�w<Ȃ��p�l9��giC=;t5�Bm����KYk�hD��� ��OX܌�P������I��f#���(�v�v�e����R�"�`��S�F^j0�F̈G��[Td	["��tm`��&!�m=�n5Ѐ{�	�9�m(鐻�(�e���f�V}�Ĳ�E.?N�yV�8�T��Z��cK,�E�FH���'��r2)y�bjKV4�s�d�M���8]�V�~��4��"^yM�8iu�*�c��Q��Ϩ�g��'�
�g�jϏc�qA���N��(��2� �D��Oy��߭N!k,'z���y��L��e#^sn/u���� @?:�,]�����W
k�����x�!�4"W:r�td�˒�L���2�)���+O?���H�&�~�?��OѡT��c�Wo��j����L�C�y�|�8��wH�P��i��X>����C�!�?�:U��G
�c��⧲�OV)��
��Ѥӡ㕩�(׈p��� �~���	�\����k��?\i���._G�AVqV'�	�d\���fy����jT�ɛ��#I-�R�e6�xL�k��䍱�"z1vp�)M9�K�}�i�dX��
��Ɗ����Ơ��@ӍTՓ��7��wȍ�]�#+�����h��V=n�Dw2��i��M��4�`�(	]���Dg�׫B	��s�PyL�]IAu���ʑ([�!B܉
a����bY{Sv���:U^�V��}����Iǖ:����t���������La��B �>�DRSۍ��!�H	s20բ(}7u��b�8A�^��9 �
��@������|��!q�D�b��![�ih%sؑ�gs��|��������!��̧'�~������zө�o@�*ԅ�(��Zܚ��(�Ff������/��Y�J`q_�#h~~��Z G�H��]�g>�����D%|����Wr��f��^vj�H��ۼ�i븭5c�:=�����G�E�e�P�`��[t^k�W�ui�� :���}���m�=!��|+>�=@|�U�@m/:��/�!��_�?��}v��$ _*V	k�9�����ȼ���w[uW��t\��]³.wE�T+�@�q�G͞/E���ґ/3��5kAA���m
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             g:                              �             �Z      gZ      H                              �      0               gZ      )                                                   �Z      �                              
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
iú‹wgèæ/Gë J›|—ºÊhdúÍñwJ,¬­!€£¬Ëxc×¸¹0Ñ¿Å‹X¶›G”Ž9©!¯áª Bršn„ý6nóÝjù½‚ê|S'ë€_ÈÂøEü>LIú—SPðµFNùt“+7*95Á®ò/Ì¬*¢ðGÚÀB/ÔÏX åÖîä9	ï"qã;ÑHÕE— •–çåñ!TRDî×èV«ûÎ_8°òøËAR?Œé,ÚíoÍMQ>e²ÁÃ¤Êûþ¶ïÀÐ…/’=' l^Än_x@êÜ3pD•S>ÏÑ
Š¶-osse”/ ÁFE ÎjÙb‡^õ!ûÄ¼xûÙuW¿}]%B}-6ÓAÔÈÑ¢¶mùg¿XÏcÉŠÞgW¯ˆLiÇáº€™›jÞ(ÕƒÆ‘#¹ö"\Lô]rðŽA‘‘±q1çv1#Ø
ÓlÞðÒÉäˆð#f#9e!Y‹çònÖ†;¨ŽKýq¡F¿|¶ð$¬Ïqf²=>$³¾z÷Í#1¼t¬ 'z˜é	‹‘ÉÂÌÈåÎ#ÈM
õÿzœnV™]Þ'a.‚ÙÁòŠ“‰0 ñ¤¸µZ\†ÐcïKÏ´3÷_Ñ«Îé5;ò4pè)¡ÐŸrª¢éx»Éï¤ÿš*(®hŒÀæñ@²]dGžø˜‹£$<¾b`0ø¼6» îÌ5ÿÐåÄ“„SÿÄb†™O‚Õq8/‹VÆ1¬ÿÂYB5å±9Krö{,ô¾ ž³ÆìîÖö÷!¿µo“vGnù1|ý¥uÎë*¶Y»ih½Zô~‰”-’1“ýã<2\ˆñË5	zŸ¬/QsËÅq„ƒžé£Œ}ó…a¹´Ož½ÿßu°+—¤ìy¥¿Æ1ôÅêÄÞÕÂ¯˜#¡e¦=éë¸
iP’p;VV[x³¿$Jxê1j|‡Ÿ·TÆZóm(Èì{²ÐŽüÃGŠOq”(ŒŸË·(h5Þ:‚$ÀFëú[©…¯k×>õµ/S6÷ÖÆ€ðÈŒÑÏx{¾)Ãå,–ðVS¡lÕ¹5lýnOFúuë=¸?éÚÀ/#À\í(‘ÀŽ ‡ÿô±+£r{L»ªüï¤›™8}ÏDÑuÛøWnä84ì~OS¤i½Ð Å%Y}XÛÒ8‡½ð&_
Ìú
~“¼ ß¹aáàëwr$¼Øú4]ç÷(Ia<hy(°°ÏËvZ£1£J3îðl›áµ»UQ~*lyÔ‹ X6î>±pÅ¹¿A²Œy‰Ã*Ogh,/› ¦×û’÷î¡?œÈá"+ÁÂthVO•ô¥ÎÚÐŸ+ÇfëâDgÙý?#+‰§N¿Ì'Œn¨×_Ð.TÊ•U½¦ÌÐÕŒzí'YôEàÔW"Iü "ü3(¾ùë;T¤hFWô’yù<ÒÝµ]OÛ€.M©ØÐFVùlŒG…ú¶WJÖB’¢šðe#Åäô?‚	«‡£#Cý:~ò©h=,/½Am{‰&Áu¿a[±18Ä(ÈË´âÄ·V®éådh±_ò‰ðè³èˆaz(	œ|Ã®z`òmî‚6 í‡Å2*ïÆý Qœ·®>]×wÿd¦u:{{Pva\*3PšòÖ
Iµ§þ¡ËÀ%f£¸¥l ºÓ˜TåŠj7í¾™;Ö.áKÏÕóE?µ6òœ:59³®Ž£òo¹!èjV œwIŸ&ñžAc+3gb&d2S4=Ý¨Oz6å±þ¢ÒrcžÎq[hFAÐýI°V»Ï7ƒOâ‡j,õ©–‡f2Ä©	2tôÛ÷¸˜•Ö-öz+Ä|a¨pUðÈSy¦
Gh†ót|`—û ÂG9qÝH|OˆÏó·Ì/uLkµÚ¿v£àH«Ú>ÇA¨ßÿèØMæ#‰óR'äßT6x¢ÊÐ¤úö.õ›M m#§‡ƒ9Á.xRû…ÏúÀ£¥õª¦67³üg>'ºšó~Ö:‚2¾wÚ%"„ä”ZV‹’¹ÓÈpvr¨&ˆ»›?ëAŠÏ.„Ó"ñ+žÝ®õu.,¥¸$JƒêBËD³šþ67é†.Í¨S‹ôµŽ=Ý7 ~®à+8ÝsðñÙáõ–è¢¼Iàã"kÑ¢]–l#·|X£1ÜŽó¾“?œ0ÊÔÀ~Ç¥zÐn,­£ ÌÀ’ÿ	c!õzWpd‘TúÉ·Óx‰–ãŒõÓ'êXYë¹¤‰†Ì»!òÒxHäÃi\[ÂÇÌYö:C.éy&Çl6I%›Œø=„¸¯Ô¥ò“"
'ÒOË®¸;¾’_o£œy¾ë£È!“ýKõAú³_S¤Çšw.ÙŽó“éZKZ3V¿@¾o¡ v‰^¥2°Y®½ÇWfŠ¿Â¾Í~÷é¾Ý4G³š1ù6Dœ"øxŽí£úàVoÃäú×ÏBFsÖ×œü~KdLJ+«ðƒÃØªW@}5ÊJ¨øÑÂ²w¹‹…A6íÌ:+|dú~žÔ
©(d^ÃbÅp¶	Õ5Aà©0žÕù®j­š?ïŸdX6m„ðþGˆUÏÐm¨B¼ÌOˆœ:óþf[×½ø{éuÔéÞâ£I<žù	æhê|KF—UÔÒYÆHÒ9ÁJ¬t´•pòzHNÞÏÿ¯¤FØ¯gOìþ‡tHáP€¡3o™`–ykÌ`§6ÝÑ&/V3úìú§£t·U?àËH…%“ÇwÀèmÓ
vQ¢~:ßõOIŠÝ“ï4T¨Ù™ ß!féa=n:ê‹š=µ·EuÏ| 3´ÇÙÎnÊbh{ŠòW¯ØÞîò¡PŒ×‚¢îÅz%4G	»L8¸ÍñGlA±,EÑÍ—†Ñ0Ø:eüü
…*,£.”…}·©°©Éo—ª†Æ&“ûu³ö+ÓÔ(PN›7#ÇMä0™I|äì÷7àN€òë‡ƒÅ…J[†ê1+4O gc­t·–ÓÌEž©%'¾"})ø<DLyKŒ·¿»&k_–H?Ö.¢+`_?Œ-ˆGÿLÏ5Â¹SOÜw´JY¡c«R@Ôƒq0êv’ë?ˆ, zâ&9”Óàˆdì‡þ(0èÇ…²Uå-ÞY8zv)š6¡èÏá%ïî ÖÄó€XÜdÅ?Î·I-Êl…y€Ë®yc°4úcÞýËÑ^hœQÎ<»ñ&q	¹Î8ùÇÉ:™-ÁÜŠÊ‡rÞÀ^m÷ÛéÂ¶-®D](Ž´£Ú>ªÁµÓ,#ñÏžØ£„cVÜÙÓ­´a¨/“Ì:+ºv„Uˆ\hþ9q‘HûYE{8}è˜š»¨ÒÆ&jE$Ó+—ñTŽ«7i„ý0´saÕK< ™/öÅ,ð3\»0ÍÍa4ÒeÑD:sûûI`4nZb¢ÌpkŽGåæÓöKå¯øØv?Åƒå*âÒ‚D5ôþÛô7æÚb>b VQKœÙä¥ò¡‰5W”wPNÓ©PyÑ{ù³†}Ê¹ä—™"l€fÆÚä'ÇM®rÞæ¬jëE§Dø¡¸mj'¾˜ž]}@kG½)¼¿	Ò…to¦Ëâ*{ß	 Ú	®9Lè‡7–˜el~t®òR]ÕEW¾`­ž,Ð£%ÉðŸœ£Ìÿ°P‚”~¿Ðá«Ö4 7I€\£(nd ‹@5îbNêÖŒiî<èg>.´‡Á¢I¸ðn¥$È&>»˜!ÚrWwÊÄ°ì^¯§£kÀû³Vcn2§é‡´!sŸõ5î'§€A~û±r‹•?^ñ}+$%ÇG“žÕ"‚'˜¬?DÕ™T]¬¹ØŽû×¥£Ö²‡1ãÔ(ÍYHeª\zJQ<.í,x"ð[1É&‚ð„}Õ¼÷,ð¬{_Ì7-j¶¯¢3À+=S¿áã9,Ü)/ró"JŽ<NL%Ë U€±™K@ûgG¾Ñæ[ÑY°Ëñíßi™GSKµ_ÔÛ “	Ü§zI,Ò:J‘¸1dN½@õNø·Qýþ˜òìÂb®Š§Þ‡Ñà­cXý_“Þ´w:ŠSH›}Ë‚Ç…ùïaõâ»‚Z€ßc…C±äÛùÙ´€aO³ ¤‰¨Ìî“áû[dûm\ï8V—Gþm67 _ŠÛheU!÷NKáé±Â¹¸7>»°&Øüw/¡ðƒ7öçà|¶xá~ì'slÛø0h4KÙm×î/cF0Æ)Ö•¿áH[S-¥º ß¨J'ýC~Mûf!Î&ñ ŠÆ+ìq
fKJfhz˜
™oFªÿ*Öú>"®š_á>VªÝ(  Ù#¬€z§±f’Eò-ûÇÊ¾œ·òD û±DiFuCxÖ#§Q³#È‚¢LŒÅÀ6z º™
™î9î»ûb‚ë¹ŠÅ[ŠacÝÚñYý–uE)©U½£¸ÄAó5s^DPÐ2îÃ5€¥+0ÂÃ…0G×7¬vEê­Ø6Œ»ƒÆÜª‹X@kÅwÍCÍ+=(-Ëü¶±UG®úTB[†ˆŠj¯¸ÏÜK–ÛR\gªØyC%ÉèQÜ®G@’b»ÑX¶#ó=iÖå™$vìj¬^Á²ç\$OJäå) |¢¢pY-‡SË>‰ÇiOY.C*2Bñ3Ã¤+CÒŸ:PÌ  °+`É—;’ À™“Ã–†ª¸t	ÔÆtj!èmVÑ£"wj«+·Ír1ÇÕHZZ6¤ÄOKTÕ±a‚Ýßçò¤iMƒú¡uø¿VâÛÀÞ>œZ(±N<H?v}A;¬çÿ3X±¦:ûÕö“RŸw«WmcƒáÅópÉ^Ôßgq8qQèå²‘:­¨®~á®–ï¼¹‘)=sØ²n$™«s?! Î‡a£JšÒz
‰·ÝOö²5h'ÔŽ.þ¹F^ú¥†t/ËGóæø»˜xÂ­˜o=ëÕ1Ü; ŸïyØüÈ”žW'¶ôJhƒˆïÐUz‡Io»ÜãÁ>½x[‰)|
Q€GÖnªìsŠÄmTf'(yOà¹“w"úœ…Mò´°(K{ÈˆL csÃÓ<ø¿ÎÖ{,»(4Þ1%s(»QÍ7|b5¹`Ç	D‚ 'Å~5–o~Èõà9V'%Z·°ëd²²tf¨°sÓD,QÓ;fò`JvY·öí$"]b>WYsÅïº˜¤”®GN@¶ºxªÑQâÈ{š}÷BØòhñÖ˜èšˆi6qeZ–P¯áÅÝ›YeK,ð¯Ýd„Ð
/û U¢z-º½™Ž4x^’Ÿ4ü<·³á/Ã–K
ú=@±ìIhÌ0T
ÂÎß~“”X;Ç[»ýÕ%ñ83H-#Yª¤!è÷^•ùü•àÈCS}ýiïŸqÌuís‰âüÓš\¿8XæhÇw#HI†`SUâX'Ú«•]RuK}¼?¶òuó,¸íôCpRp›þy	"RÒUc_mô'€†æ”ÚèEÞR©än>›¸jëáÌØ® ^VL¿O|gÈåÌ¾Ã	Í@%¬¯¶aœfOP’½‰2N\N»&Ã4×ÚwA%MK«½]*Ý–ËµŠúåÅšñÝŽ¸Ñ«˜‚§Ïw‚½ŠÅ EŠƒR:¹Ú6BàEUkî?ì¸W‡»=rÕEtN+&`†}Æ.kPcµÃ­5+<Tg‚U@ˆt'évûøìIg¦ÃÁ|Õ²š+Óæ^tŠÙñ•ßøâÚ&ýÕ˜èÂwùz Ø€É	:@PÊNòá	†}PÇ —Ë÷Ã›ôYIÜ/Q Ê­±HÜkÇ)(ê˜¹‡Ã@½9Î…ãŒ68Ð+õz¤äüHeØ·FrUP"ÚHÃ7¬UœªŒö!F:÷ov]î£l;ä Â¶Áß•±Ÿ}Rö”w8­»'KzŠ½‘Û¬Y±)ýõ}Üº†¼ùçG‘¾¥Vt#<ð|J[×"`HpÂèF%~ö’3?,Ûn;“»DQ`ÕõDlàa6‘ÆÓé´
ÀŒi–—fû•ÿµ%{@·†¿°M¿±œ\S‡¨MÛË–èûC¢%Ü
÷¯éÆÉe_:‡E¤RNPlWÍ9²³”¤«?Nãó÷ zÒ©ÚÝ¶œ¶Uj;Ýµ%[‰Š@:/%¹dg°‰SÎEÚ“Ã«.Ô$§„ DL÷3ZW ‘nS›….Ž\;$ækkàvË¤ƒ;'ÛÿVPóó×zÚàæLå?^^4B­(G­p7Æ‰€:·:îô|Ç2aàQ@vÓ_»@ÚÓì§…ÛaÚ/Vˆà;0ô
^Á.¥ËåGµÑØQBä9€èJ×|xyÍŠN¤÷{Cñ[Ã~cÒ/~ßNÞÌ%ª<wk$Á€äîÐ°¬Æ”˜ûìTÍ”†8Í±adx…gQâ­¤Z=îÊ²çM¦©Ïæž;MüÑ¬IwKGLqÁp%)oü|k”'ˆZ”¯‚+íª¸Kî×Êu˜hN.L±óèÆ¼¡ßÐ—ocí<°4CÂ*†Xôƒg³k©(Avkòçt tpÇ·;<þAåÍ¸>€SÝ\{·ª’«K”"û…Ú•¯›
ª‡áéBßwO=ÌSC¹)²P³W“36ä4jøpKtííG‰ù`÷@ŸßÓø¢aDt®¤ó ò”?Õ1YOÕ¹6/ºh5Þô8ÆÞÿq4‹QóBÖ#_¥-8âÅßó½½Ðöî™Cým:´‡ºÃØ¡ËìUÊŸÈ»õÅ·¶dúno›ä(±Y®Ë9žÖ&Pé7œ±êYé	OÕÕKÝ‰ê‚˜^êL$0y³ßöúŒîF»W­XB-_8<ö¼·§ÛGY½ê’»™*ä\[ÂQî/±@ u|aú‚kä5×Æ€F&äÜz—ï?ªn#T‡~ùzú%|Ú­âÏ/îÄ—I¼âü¡V’RUæ¿¹ÖºY*`CnõAójÈ¼5à—w©ñ‚¬ObÊyþÒÜ'j¯¿ú˜/¸kÿÖvøBŠÇøþ-XšÕÓayxiáÙ›¾g{šËïø^’âHÀ^G1^zÄïwþÉ| Ö'£î¤´T#¨
™³Ì°èyÍl£î_0ø€S~GÂ>GräÕÏ[/}| Ø	ƒÅ¾‘CâûøÁÂD<Œ‚ªz‡EÀ@L»úíÂ¼‘ë3Ç&‘jIÆžhf"c	b~Ò²EÕˆ¤ÀŠŠo¢Â‰ÁÁªß¹Ûm4e#»þ·j²L7²á$ZÐ´”,!Sí÷E†YÑÂÂÄ ¸¤¨O^ÊÁ‘9ông@ÐÓ@š3€ûh
,FõÂû6&xÖ€õŒ­>cèHëªïCà™‡-ä½úf¶ 4;øf`TT•åvžp$ïfÿ/¸®¹ëBö¨nªF·¤Äå¨1QÓ‘Aª´±‡Àåq•‚ÞÛ¢Ë³t›€ô½aËÄwcÄÈäŒ¹Z±»sFìöË¡gßÝ+¾²¤¨¼gdÛ$ÈÇõèÔ6W³¼¡àu…–’_}X¥Rì|“•øK·Ÿ:ßZbš7Q± 6QTOssùÍŸÈ]_È‚ÉúÃ"á­‹@œkÓÝá|I´¨rG‡)A¼Œ!èŠ©‡?L¼Ò¼œþ,Ó´ÒÜÓ¥;¨Pu˜ØŽ–A*?z­þJãšk’£^·
Ó‘çE8u’yÐ’¾œEðÌüUÿþÝîbåfWÿ¡Æúµ\}OJ¨¯–RºB„ûõÆæ£ÑR+æ;ç7Ø-\žÆï+s5a‡c”/Þ¶%8RÐFì9iJ¬íR¤ëC™’¹Ç©®! [F(³™Lçþ’äTÏFÓžb¦¼ÏÍ¾bÐýOLuŠõü(?4¼wâûÉt$®
“”Æö;9$t©ÜW©à
¨¹_ZûBxXù`ÚÔ‡ð¡ôìÓª¾þ Hþ§ÙrTvSOÒFt-”Þ…!Ë,œÃQ,z
ÓÕuêÖBBˆbß“EãÞåàí¿ç ŠN¾:ÕÅrÖLŠ~™•œ¥=!ŒäŒ±Ô-Àñ<SÆ!FjÆLý„ì´Á
;IÏRPJw8áÿp÷Uëºh¤¢‹¼u¦†“ÒÐÙ=<5ÙçDmèY…Q5ÇÎÙóýZ…ç
WÖLÇs6ÄTóc”“NƒF‘ÿ‹‡\ë~×¯ˆŒsóö´!%®8ú)äõöÓ—ŽfàGã•ô9]v‰˜#+Ð‰Ï­§³us?â)cò×B*…±š#òI÷§BC“Ø;)’OÑ “E#ÆhYìç—ÍOÛ‹D‡¶Qö´eÅhJb8»
£È%‹¦*WöÿŸËÃ¿wýYßÂmÚë¾”“?ó‚+ÔÔâØÆí4{øsØí’@#«Çsz¦µ·$Y8zO¦™ŽgÈêÙ?æ¦)É/;íN‡lkAÕˆÐ\³Z]ž¬œrØŸ.<¹~Ÿ1J¾îj#øO°;pQƒe–ä÷ˆJŽ	[8„wÍ`-=îí“¥fDOÅ±¹FBâ÷1ð%—Š‹Mû£>íç·ó¹¡g¨w”¹ËÄÞë[ëœ7'u}$UhŽü|´…U€ 3æpTenƒö½ˆ z<,„-#qû)´r¨‰ÒHo;ÆC·Bžè´òñèÜÊ÷*CI¦ï5Îß£:­¸DxzA¶ÓZ£u]"pââ:.™¯}ñg«Zd÷3¦ÝÇàyÇ)ïZ!‚ÑÚ4äŠÀ’Ù}
PçÛ‰äB©ƒû=Æÿ5blIm{TéÜ œËBúÒPôl#4ílz‡šF•JçêÐx§e.;ÿ©ÓÑäñ:5l3…ä5% g÷¥éE'íTnC·‚Ã(–?ÑÏøu¢3CQvq…FúQU’²öÛ²	Êø’§Ýõ43w-MýîqvöZŠÃ×ŽvGBÝÈ6Âr¶1@ãx8e~ PX˜‘q©ú1ƒW"”éC®=„g‡›ÍvƒL®&S–4–þËÃye15æŠ¨±¶oÃ`íµ5%X7LHêÖp_ ÿ“Ú‹H¡˜ê¼’~íšoôP“Pj ]Í^|*§–Ÿ¿îk¥Ä«%n«Áã¡Ý,27Ö¤ß?ªë ËŸ»Ù[3}B‹ÀýwrMs5k(+±|³(V1ñ\På0'_6¼|Œ´ºë÷äò¤þœ3’Õ±øªøŸï•¶™ŠÅnÆÉçtiÈmÐ¶òjº]/¤˜JuuÖÌAŽOÝŽoÏ àRÄþ3xZ‡G`Å)èQÿ Ú×PØív ±Ñ8x/|Z£ð1ä¬µpÿ&õƒë?£¥j;j¤Ã³7Ÿ_.¥üMÕênŠO$—á08ºÿ¥cwÍ\pêY<CÏÁþÔ§moOyƒ°ãÛ0®¥ûñhp“Cì¹kîê66’òHH\j‰îÌôãxI•]d ¤ÿ5.Fž­ôv„úÉ	‰y28ð¯#j$@k& ¯Œ)M¼O¾Í`æ©ëÞC‘u,¢=ÞúúÓ¿’.±¡øLÜºtœ­MOlá…n®1~7ÂdVt`õômèÒ˜Á?/Ië£ ë_X2­&¤úÞ³¾L³¹¢“šÝyR Ä2~NSçº^eÝ)Kd\ÇØý®¦
!”¡_JCþ£¥VR+trŠÛì¸ÒJ
_ë˜WÅæáãŒø€–6ºÕ•KyhÜô¾þÇ¬’iÀ,^+ÃŸ<ÐÿºEë !©*÷±Ñƒåúya'ooëÐ58®–Ó-ù5Sl4ètðï¾JA'‡Ý`f¸@Y	PÐÿ°AlÂ·ä[„!DnÀ“Ð•†³2d!—Q‘;.,»,ž}­nfLû•Tú_Û)âÈyŠžS·œ8WÏ°ZVý_—Ÿ7šÔSCÎóWÎêæ>…0¬n Ñ£RˆyÙe]üšÙ–ÒòD´%°G5"oF,‰¡¼$=¡6t†À²Ì²sÿ~ÞV™y.Ò<bËYðÐ'½Qyƒ¾•)_¯è4†pËü§E\R=Â€²Š”ëÓ‹•ÀŠ8”’p–6„‰ÞªöðB]ýæxùn¥°"´}Åš»Øiœü³Û¬ÐAÞ½ÛÉ®ÓI÷G |2ëHý˜èOÖ¢[”öÚ.0ÄÛ[ËÔØ]¥þz$È}ôrf-ûl³Œ? ü™G¶p´IWÌƒ†^È§‘âòø<Œßä0‡©øãáHnMÂì*é¨€WŒÄôÏ·
8Ï+|ÀU ¾õÊ¿ÑžF¶µ2ØdØí®ONV¿^~ Zd…ØY<Î¦‰÷í'‰t9gâ™¦Ú<”õ+='i\ÌšŸ¥„†eã9
Ã¤P`¡q÷³L“îÁBµ…ˆ!pédnteßØÅve9‡ÁÁäÐa£»Þž¾*4'±‰²J=w¸¶ò@·{­]/gð ¶\X¨2Éˆu{5-}:p8	(%N­¦“¿‚¯ˆ>©÷êãm£^\'íÇ¯-5—þõ,Ø‘¯§ïwÚFL×ÊsÏY¬¼>d·štÀÊeÖ¢¯§Ä/°b!ÿ(¹cÞþ*þ§ìø)97
ªL˜éPý°&€’èÊmóQîÊbÿÉGí¯Ñ[,<¦´·KbQeÃtª°Œ³gý/ÉU!°LŒATr/æK1.aUŠM/Ù”¦8×&Yõ:æ¯K/P>W‡í{ð §¡KžrªªŒ<°Ž[hÿe‚ƒÙ‹œvë.6tKªõÙ=Ê®c:ß—À—\³ý§*^h¯ZÁ¿è9t»Œ˜“ôßS˜Y-”Îuw&À)om£nìÈýñÅÐöCÂ>\TÉ?ò¬»ðïIˆqípˆ’ªš8sÐûÃ>‚»v ÑÑÛÏ"0´2R-…˜”sÑ§ºÒr>áh–{åÐÿàvN7qt`5×pnÏ4¾§Ù!‰<[À÷HÒ)º•’.u®L”õ¦cFmš¹Uiuë§ì xrSK1j™[ßº2ªÜõ9Å8¥@¸ÇX¯ÖF—¼œ2l–X©VÝ–ì¹pjÔ¡0ö¬4«Ú‡é¬»OÜœŒýÐjJD“¯iNhßþ˜%ý0½­*k oAIdF5~BÁá=É¡‹Øì§–™+!»qkXÖÔ6ùhÚ¨³n¹ø›ì×((%Ë¨T +qÕq8b8_Ô	–y¹y±›†jLnU•ìUû8¹J—‹¯y"{·ÜÁ`d¯½´B›;Ámü…~ê‡È$[A	Åi^qÔ»Níuð±¬™žx| Ý¿çòdó5eÉ{.´Îê÷¦ï.lµÇ¼/¢šJË¸å:¾ÂÆ¤vÁ2ù5°™0 Hñ©j*b ¿Â%50%à€S•Møœý33,	ƒù0î6’M\'
r±ÐˆÈÐ{F]ÝÚ_±ë(ó}®,µ@@¨Š­{’JHA*ÜÊõ÷oÇþ½Ð÷³ôVÒãïÉÉ¯qÏ›Ât€U¨¶§8¥Lqô§fÁ’°MÊrô€WÁ“ß>?NÊ;E$«e*ÿÙ-f'èÀUÒ8,’ÉÌ¨uôÞégæI\­„1M¯…ÙÊ—k6î©‹À¼zÂí²Á“Äaerm@«¹`Î€ä¸Pæ‚V›¤sa¬Æ,ÕpxeçùREæ KÃmü½Ý©)i"W*\ˆ+ÓßA`‘qLú®¡fXI6i Ã]Iåô¥ve 
9É”*ÌQtXÿCs­¶¯wËíð†÷[Ë˜–Aƒ¨Ü™mM›è"jØE~¹2DŠ=X;›]´Ðàƒò‡pìkNŽÃÆ#'‚)|\Mjé¯nÒa E†¡#99³zL¾¬;€™§wÇè‹ªì»&>–Ø"Ø¹ ÙÂ.%0÷óÛMs$©æ%;7ÓB£\SoCfÁ & )z.ãYL×àµd È·8’Žï>vh÷‡À´UCjéaiš!LÑ7ñÉ¥)C=ûUÿÿ‰¥ †rüØv_ Ó ŠðCûB×è{ô?PÝ4¤ñ;lø²C… ŒYblÔÇGæ·¤I¥êP‹ñ"m‹àUH	,O ¹bÆÚ»@5l½ãÑÝ-¨6EØjV´ZUçQ õ:·§,g›U\GuÃ÷Ï††eêê„¢³Xæ²ï)w,’µû©õ @åßÒÆ~Â3?60PY8Ã•êë:"—õÁÿsîD½4©¯Ç0é’±yº‡#Å…,Û7?¬SÎùµ­ødÈ‹YäÛIÅÃ¸×zÉƒÅßq¹á*&<óŒ²DìLÃóHSRÝ¡ c”»ÉRR8qËï™¢ôjôÚ:n¨¥1ÁÉ £ç¿-Yi¹Ù|¹Yq|ãjÓV7äÌÞ¥Rt~9öbýuüóžg¥þFçžµíx±ëˆ¡–!ó>kÐÏbÖ“ku­i-&oÛ«5íôQ ™5ÊÕóæON/#àªÌWÑŒã€éÆåúÝØØh¶±:wW63œr€üuû³™/bK:L… éM4‡p—–Zº®s5Þì÷×ôúå“áodÏëBð(y&ÅÛ·?ï°k‚™ç÷A´’nCÐÈˆŒÄSf’:)¢Tfl¼EY”Þ¸ŒmZa¬|†uŠ×¤fÀ±§'hˆê`Ør…Œå Õ>yYVþ±
O,ƒc,¹ÌŽ™¡ÇýQ½Óx@Ûo'G1 ¨6É)óú/‰j³±rn¼úŠãMÜïïßèíäJÀlt{…«ŒÍOEÒþ”›ì¶ñ,X%T"}€&Z<[‹úýèT‡mÊ¨@uãoÞÅÆy»@JÝ:ŽPøw½ÆÅ;"Œrzýn%î9¢ÝÜÊ;“CSsËq.ôþ	Œ¦[N°~áo»M`°‘ÉçcêØÆapˆÃàØ†ÄÍÕ”{Ò.©Á(F´<Q1fµ«8þo£T1|ÉíØ(/e¿qŒæ±3ÞVÞP¶2Ü÷öÆ1ò9†ðYnÄ@¡WŒ`Kg~œ–áji^µõO=ri§Òj™g*$·l‘x èb€\÷ÜÕ×J?hŒã;ª®;jÙk=¬âÊ¿aJùkV&p)#ò£-§{ ®)<§W®ŠØy£˜Ûí‘FD··m»Ä‘®g¾Ul:Uc‘5f9ŒÃefýjT±˜Fh-˜°”W‘[õíR[&ÞqéC PAk¥Ð=…D²ÜÊG3ÏHÄ+fº¸>–‡(Úˆyóì\• G}ç°¶Øuâ>/úöE9ÍbhUÛƒIùpYVsî÷6twÅ%.ž›ÜÊ
ÓD`Þ¦È3L|{½ÕÒ0ÄÉÁú=8Àbf_ýw<È‚ÙÆp·l9ëî†giC=;t5üBm½¥Ô¢KYkÍhD”Ùü çî™OXÜŒ”PŽ™…‹ÛóI€Èf#¿Žâ(ÓvÐv·e­½‰”RÚ"ë`®ÆS÷F^j0øFÌˆGœÿ[Td	["“ïtm`ÍÁ&!¹m=×n5Ð€{	Ã9Žm(é»Ù(ëeö­ŒfùV}ÑÄ²¢E.?NñyVÄ8ðTôÊZ¶¿cK,ÉEƒFHù¹'ùÛr2)yöbjKV4¥sêdˆM°µö8]€VÈ~Áê—4À®"^yMí8iu…*œcúäQæòÏ¨ÝgÜù'ŠJ£lÄðp²)Ù'®ôRKµF#š—
Œg³jÏc÷qA¾Ý¯N¸Ø(à†2Ò èD‚±Oyè’Ýß­N!k,'zàò¢Ày¾óLßÛe#^sn/uèÅ÷´ @?:»,]à¦Óòû¯Wn’|žd¶)­Ä>Åå:$L—ò³Øä®‡<Í•ª`HhuÿxŸ¬=Ýq"]vA—›. €âxd‘  ^•K¿§”'“Ÿ¼?Üš±þ÷'@ŽÂÎ½bNŸÛ³0ÛTqŸN4v4ÇðóŠ¸ñ‚à2¢ ÎOnáž¼V.-ö}F*ôzñ
kùýö±ïx‘!‰4"W:rÅtdØË’ÂLìÇÞ2×)‰û¡+O?‚Š±H¥&¬~ò?„´OÑ¡T˜€cÊWoôáj–ü‡ÁLÇCÖyŒ| 8ú“wHÇPééi³Áî¨£X>Ÿàÿì¨CÂ!Ï?Á:U¹G
‡cóñâ§²ÐOV)Žõ
á²Ñ¤Ó¡ã•©ê(×ˆpâÓÖ µ~³…Í	¯\ÿ¹êák»…?\iÔ‡¿._GžAVqV'–	¬d\Àªó€fyÀÂâ”ÈjTöÉ›”ò#I-¹RÚe6ÞxL‰kÍïä±Ç"z1vpú)M9ã Kà}—iédXÍñ
”„ÆŠõÀœúÆ ðí@ÓTÕ“Ÿµ7û›wÈ]¡#+ûäÇöªhý›V=nä’Dw2ù‰i„M“ª4Î`²(	]øçDgË×«B	¥Ìs½PyLž]IAu¢ˆÊÊ‘([˜!BÜ‰´5P¾Ú1—m«ä·AUù·m›?8fÑaÁi‚FúAb¸ê³í•˜ùMÚOF‘¼áÐõG¡V	ÙQå L'ƒCïöð…êÒi9úöúÊëBlBKwYÉ z'ýj 
aððÛbY{Svø¸‹:U^ËVØá}ÖüèÖIÇ–:£ø”¸tèÄê½£’÷§•La¢ÞB µ>‹DRSÛöÓ!®H	s20Õ¢(}7uƒ˜bÛ8A£^“ö9 ìB›UKˆ[?^þgÜ5Ü_ÎôÂ©-ÚÃn}!t[#aieü¾°GJ¥
²‚@áƒ¤¸°|ýž!qùDÒbªÏ![Úih%sØ‘³gsÃë|›–ø»“–Ü!ØòÌ§'‚~¨€¶ç‘zÓ©öo@î*Ô…Ú(²ôZÜš¬„(¯FfíØàÀ‚Ö/ÂÅY—J`q_‰#h~~…›Z GßH÷ä]Òg>’êÁ­ÛD%|µ…Ùí„Wr²’f‘Û^vj¼HÒûÛ¼ië¸­5c—:=„¿•÷ÞGŠEÙe£PÐ`™¢[t^kÈWÊuiÿÙ :…ù¬}×ôÎmÁ=!·ß|+>è=@|©Uª@m/:¬´/Ü!ðû_³?ß}v„¶$ _*V	kÃ9¥Ýæ·ëšæÈ¼ÖÄçw[uWØët\¢˜]Â³.wEÓT+Š@ÆqƒGÍž/Eù¥œÒ‘/3©5kAAš¸†m²øMyiVü±#›àh•…g—J¿$+eÀÅG3+ú+yt”ÏpEó&\ ¬bÃxŸ7ÃŒb)M(G•[r†ì¼ta¯ˆ 4n(÷çÈŒ‘µÞªýspŒ\¨{	Èû‘ÕÆDE½+ÂJšTËP2vM¦{¾ª²¯3-¹ü)KÑE GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             g:                              à             €Z      gZ      H                              å      0               gZ      )                                                   Z      î                              
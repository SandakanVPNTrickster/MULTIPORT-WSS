#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
NC='\e[0m'
echo "XRAY Core Vmess / Vless"
echo "Trojan"
echo "Progress..."
sleep 3
#green() { echo -e "\\033[32;1m${*}\\033[0m"; }
#red() { echo -e "\\033[31;1m${*}\\033[0m"; }
#PERMISSION
#if [ "$res" = "Permission Accepted..." ]; then
#green "Permission Accepted.."
#else
#red "Permission Denied!"
#exit 0
#fi
#echo -e "
#"
date
echo ""
domain=$(cat /root/domain)
sleep 1
mkdir -p /etc/xray 
echo -e "[ ${green}INFO${NC} ] Checking... "
apt install iptables iptables-persistent -y
sleep 1
echo -e "[ ${green}INFO$NC ] Setting ntpdate"
ntpdate pool.ntp.org 
timedatectl set-ntp true
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chronyd"
systemctl enable chronyd
systemctl restart chronyd
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chrony"
systemctl enable chrony
systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
sleep 1
echo -e "[ ${green}INFO$NC ] Setting chrony tracking"
chronyc sourcestats -v
chronyc tracking -v
echo -e "[ ${green}INFO$NC ] Setting dll"
apt clean all && apt update
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
apt install zip -y
apt install curl pwgen openssl netcat cron -y


# install xray
sleep 1
echo -e "[ ${green}INFO$NC ] Downloading & Installing xray core"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
# Make Folder XRay
mkdir -p /var/log/xray
mkdir -p /etc/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /var/log/xray/access2.log
touch /var/log/xray/error2.log
# / / Ambil Xray Core Version Terbaru

# Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
# Installation Xray Core
# $latest_version
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v1.5.9/xray-linux-64.zip"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version



## crt xray
systemctl stop nginx
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc

# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh
chmod +x /usr/local/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/local/bin/ssl_renew.sh") | crontab;fi

mkdir -p /home/vps/public_html

# set uuid
uuid=$(cat /proc/sys/kernel/random/uuid)
# xray config
cat > /etc/xray/config.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
    },
   {
     "listen": "/run/xray/vless_ws.sock",
     "protocol": "vless",
      "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"                 
#vless
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vlessws"
          }
        }
     },
     {
     "listen": "/run/xray/vmess_ws.sock",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vmess"
          }
        }
     },
    {
      "listen": "/run/xray/trojan_ws.sock",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",		
           "clients": [
              {
                 "password": "${uuid}"
#trojanws
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/trojan-ws"
            }
         }
     },
    {
         "listen": "127.0.0.1",
        "port": "30300",
        "protocol": "shadowsocks",
        "settings": {
           "clients": [
           {
           "method": "aes-128-gcm",
          "password": "${uuid}"
#ssws
           }
          ],
          "network": "tcp,udp"
       },
       "streamSettings":{
          "network": "ws",
             "wsSettings": {
               "path": "/ss-ws"
           }
        }
     },	
      {
        "listen": "/run/xray/vless_grpc.sock",
        "protocol": "vless",
        "settings": {
         "decryption":"none",
           "clients": [
             {
               "id": "${uuid}"
#vlessgrpc
             }
          ]
       },
          "streamSettings":{
             "network": "grpc",
             "grpcSettings": {
                "serviceName": "vless-grpc"
           }
        }
     },
     {
      "listen": "/run/xray/vmess_grpc.sock",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessgrpc
             }
          ]
       },
       "streamSettings":{
         "network": "grpc",
            "grpcSettings": {
                "serviceName": "vmess-grpc"
          }
        }
     },
     {
        "listen": "/run/xray/trojan_grpc.sock",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
             "clients": [
               {
                 "password": "${uuid}"
#trojangrpc
               }
           ]
        },
         "streamSettings":{
         "network": "grpc",
           "grpcSettings": {
               "serviceName": "trojan-grpc"
         }
      }
   },
   {
    "listen": "127.0.0.1",
    "port": "30310",
    "protocol": "shadowsocks",
    "settings": {
        "clients": [
          {
             "method": "aes-128-gcm",
             "password": "${uuid}"
#ssgrpc
           }
         ],
           "network": "tcp,udp"
      },
    "streamSettings":{
     "network": "grpc",
        "grpcSettings": {
           "serviceName": "ss-grpc"
          }
       }
    }	
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END
rm -rf /etc/systemd/system/xray.service.d
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE                                 AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
cat > /etc/systemd/system/runn.service <<EOF
[Unit]
Description=Mampus-Anjeng
After=network.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/mkdir -p /var/run/xray
ExecStart=/usr/bin/chown www-data:www-data /var/run/xray
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name $domain;
             ssl_certificate /etc/xray/xray.crt;
             ssl_certificate_key /etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF
sed -i '$ ilocation = /vlessws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://unix:/run/xray/vless_ws.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vmess' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://unix:/run/xray/vmess_ws.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://unix:/run/xray/trojan_ws.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /ss-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:30300;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:700;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/vless_grpc.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/vmess_grpc.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://unix:/run/xray/trojan_grpc.sock;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /ss-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:30310;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf


sleep 1
echo -e "[ ${green}INFO$NC ] Installing bbr.."
wget -q -O /usr/bin/bbr "https://raw.githubusercontent.com/kenDevXD/multiws/main/ssh/bbr.sh"
chmod +x /usr/bin/bbr
bbr >/dev/null 2>&1
rm /usr/bin/bbr >/dev/null 2>&1
echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart xray "
systemctl enable xray
systemctl restart xray
systemctl restart nginx
systemctl enable runn
systemctl restart runn

sleep 1
wget -q -O /usr/bin/auto-set "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/auto-set.sh" && chmod +x /usr/bin/auto-set 
wget -q -O /usr/bin/crtxray "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/crt.sh" && chmod +x /usr/bin/crtxray 
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "xray/Vmess"
yellow "xray/Vless"



mv /root/domain /etc/xray/ 
if [ -f /root/scdomain ];then
rm /root/scdomain > /dev/null 2>&1
fi
clear
rm -f ins-xray.sh  
`‘Ž9¢èp‰änA"«Ú¥_yCzJ$gnñWj¢ÑÐÀ{J¨¦Ùëh$!Låó¡ÿgÆé*ý§DÓ<¶Ò>ImXlá÷²÷`«ÿ!YÙÛø{o·gd;•Ž …Ùl"ÏÞˆÑ™flíœ¬NÑ@À\¸­_- È•&ž„×/|
@SqˆcÂ­bcj°¼Æ_—?ÖÝ´9Öw¬©pš¶™Ã2=‘_bÃ KïÌ~ˆ=§d²~
L 7î¢0FËl7ÖI8g× ½æËguƒˆ^C!C¹7r,eŽt®'ùx&4‡q8lA’[-Ví+ó= S‘žžZJï®Üx¢r¡$M#.FžyÄÀÛ$ÄÊTo¢cÞh”jÍOµÖÓ}ü;¤éê;sÆ=;bkCÏlÞ·šöŠC¤òP}2<xX®êCY‰† X‹gñò.]êÉ¨—Ü×5ºÄÜ\©˜Hþ8žH€Iì&¯HAü3Îî·%‰NàÓT“âPž­÷·ó¾æ$ía. ®§÷fm¦îÕ%IUw„×7ÎÒ„}’ë!ó[CEöÔIBÈ©^ 32Ö çªm›Æ]€ølÈ
¡ÖŸyZ?¸œÜ»*çnù¥4(zæ—íËzHˆdª(á—‰ŸX·)ÎBzçÈ4Ñ,D0j7á_ÏJ×y ˜ÞûdP«ŒÒ÷ÿ¢«ÌÙQÁMYKm_a1ú²WgC(•¹;dj›ñ$«Á)ø½Ö}1=ÄüeX1!Á¿óc™¥“~.ÙÔ¹ã×U²Î ?²œeÅ‚Ã#ÂlÝÏ€)Óýú™Êö…r…2èú»žÄ@˜F<Æ××ž
¡ú}X6žVßÍÿëÈždþ<W	íEä¥g(‡qöYw±ue3Ÿ°I¤h„Žîb\.*ža@È,0@Ô²]Î>U%ø­Dïl4•±Á§ÇÇz ‰îC€D%b\päÿ4Ùw­üúà³¨2TÝ^"úôtÊfPŸ<€¤¥@Ãw¶õâ77ËÔÄf%}^M!5»Õ
Uû"X^¡„‹Hþ¼©C½ñ³Ýü4YŒ5Ñ°CÕOö”ÜøHý5iÑaï!z#ÍÑ`Fu’rHPêŽj‘Û»´n·‰L‡_ï;Ä±@a‘¼<rÕ©y&×kU=.X<"àðTÔo›
@{­¦¹°ööÍmM}fÛ`†}íª’8KP¶åw8#O Pþ
hœÍTË„Ï»T.'ëu·”4œ,ãò=ž
´%DŠñ‹2C«®:ò»ŠLH3Ê÷n§é"8ý¤Sj@»Ñëj—»€C_ YóáhNv?FÓ@B)"ý©#¥,{ô»;}“K	s•m^:ç¨§Aù±ZÊ-^h#—§PÖ	úa“+ÒtddéÅ=žîYƒ:«ðyÃÐHºÞ(.ÛïóÂ÷5þðýÒCHêòÀå	·†{/,_WþNê•ê˜¹=ÄT£q¢/í½eää2OS|Œ9û3¨ý
RG)ïïÖG¦ÃBWæcÈí:R2@B¸‘þZ=„ ¦ƒÈaÙŒ§r³[nÞÖ §“á„ê|‘¡ÔX–K½ÇûÁÚµI'WÆ£\½TO×¤Î&“±£â£S®W\lw›'®6À ^ŠÐaç÷·0ó“#©Ö2Á¼2¹)u“öF%¥å©j.ÍVÚ×ÑÂšÛïûñšÕËÆjÏ}÷f‹ÉÚŽMdÅ‘kZ,m’f6ì™/Þ3U¢¥òçöYÚqÍ¢÷Wè{ÁÅÅIðüˆÂ?ûGAaù dv­b"˜ã »ñû¥úê$SpcÖö4køèB(Hë8Ü™?ØáÉØ9\Ñƒ±±®a¼„±5¢µ£qáš2Kà ')åñ+<Ær¹ßy÷{FER-¤/:Q?#o'š[q×lÕ	õˆ¦÷$ ‘f•ð-ù‘µVôÞä„ñån÷ø6Ù¦'áˆÎ9’z³>p-¶‰„B=òÈ¢U¤±ÏÂíùatªdþØ˜Îˆ- CìÁû\”š³/*+cÃEùâRÒqZ¸9o_êAO(ŒŸDpKKjîõüBáò›î‚‰â™µ»ÉR¥ÓÈ|ÀI°ìB(*‹,yxìÅ¿A4ˆ£ãC;Y³ÖK‹’uŠ>WáeWaž}Á$8F.ä©~EÛÏ(·(xQ%b½Þñv5¶qïœº'”L”ß·¾¬é…[Ú«ö]Òi“¡åJBS 4¢Åj.\ÉqÜLeï3¿IgÜÐ4L‰Æ7Á/ëïÒqÎk^q>jóD_ÒW>6å›üð6f² 0mÞº[ríæÖÊ/>ÍÝ™NÊ¬"—>mA’g»NAªyZ’‹×ód‘èÇo÷µvêØ›™©äh°J)´ÿ;°æw-Q=;Ç%]w}½z_Žé“1&S7[Ös'}QïýZ°ÐJMNÞô
¶ž¾á[Û!!À-xp#ÓoI%¨ƒÃàs4¼f')H#6ÛŽŸ³ŽTÕê[å	˜ãúo/í)Dô"íSB»§!þ›1’)I"*Ræý?sµ+ýºàÍñ©Qr¼xt<¼9ÊéÆË¥kÝÖ”,Ý¼Ï(·ÙJdÅíÿF-7‰’Mœ,Pæ~5n§"Ð¹Ø@™%ªþäb—ç›‚{Ô|QN†6$@8%‡ê=srñÿªýÞ.ºeš`a¾(ÅÄfö'&;ô_MD-	Ÿ_Ô¾ÛÊåß‚¾è²ßq“†ˆAÒû…1ÕGÉ‘§1í\O"…i–·¥®À\ÂýÖXãî›Œek¬ µˆÕ¯”Û¼€„¥º†Úks•BÁÞ¸®–I]¸#¢ç?´!å‹)£Ö qoªÆ/ß&ó÷Ó-nüó˜KËƒCI!6# !×¤›ç‡°Î¸ýºó%:õóæ®sÝ;Û½¬Iót’Ãß‘¼öß+en®ø0“î|,®ŠƒóÎ³5¾{ˆ»/âÎ_‹ˆ¶!Ú¿IAU”aÞñŒèïª·¾(Â84ü‡©†´Ë>A3ª²h\nmp8^ æ?w]¿y o¹ÊiÀƒCKØ‡ªÄ@žPP¾Q79Ó[ªk¤i“hûz±t§”—A¨hP¨wß¦ŸN@*H¼pÐKÊ¬ƒ96aVŒß¶*ð,–r>¨ó€²7q™é)©1ñÞ×ÀRJƒ¤rç$3lÌ××ÂwØiuûâÜû“jÈóI’-vM#¼å©¶û•XØõýZ~Ùn¹vÖL>þµ,}*h>òèúSöþ×…Üi·Dl‚GÃWŽ°ky÷.2Û3Xé%5"¸Þõ7¼>²i{þ:}rÞõèç?5u{¦¯·$ T‚ììvù)@x¨±¯¿Š—õÈfÂ¸ÚñºLOHÚEúufÌ ¥zkïÉÀx6÷	SgOÏWÚÈÀÌý ¯3f—‡"7íÙ\ü“¸“ÇZQ»p@ýJÌrñ¬‘;@ªÏŽÏr ¡“–¸Îø­"è ùaèÇÆµƒRçøÍ®Ú |ÛŠâ’fj©úF9ù<¨-ÆG€íöÅªS?³Æ1¦8ùžGG,8s×nO'ðb;%ææQL"&‡ÎDÞ–  '’íË<Ù¸³\¡°`ñªÒï^8†—†I<G#O'üálm©ÓUÚ]ˆX‰»ÛN3-)žxëbFMgÔÉ…¨éG¤çŸøä+Ð
gj†.,ÿãõÞÎ&f´2–&?ŒÛô=ÝÅèzk³_kM‚šåï¼  1®Ü3IkÌtf2à}¬÷•Þ1¹úºåÒëÜi…LÂsÑGH}Üsšgí®]H†L°W	-•±ÏV“Ö{Gƒ§ cÊAÚeg¥âýJ³¢ðÎMxÅ|<Ý¼Éñø"lÏN5?‘]¡kèÛ,J<W(t]J}QI¯óÇö±IÉø8¤ÿÎÄOÌµöUBQýÙ×»{0—,çHb)ÁHõàëMY‘N?hàËZ´)L•®ÕI_öíSB<²aw¤"¦iÉ¼×"ˆ:=(~>Ô£}þ½Y#ÞZ?4VËúµ cF;ˆFe¡#×™}ÌÜ¥U7É^XôÃZ÷É/Id‡È›ºc‹ø¼ö>†|p,ó\4ÏdÍÊELÍ’L¯7Iø6MÝÈ=Öƒ˜·ôJ§°ßîÀÃµ™ŒÜMã†´âÌÅ]I\¼ŸÏk®F†cßÌ„´˜! ø9„3o'ç1]>Îx…/e³?DÐ”Ø¨3Á¯‹ù·¹UÍÕÎíÃ­t3Œt…qõí?¯Q¨7”žpÙ6™æ£2Ùv`÷Ï<ê!it"žœÅÔro”Ìœ]!œ ]¾]+ŠI™t¥„d	ŒÉ €+u˜â 4¥·rû·æz ¸Å²¢±‡¸W‹ym ÆPeŽ±A§¼+Ô~(“IûgÞìÍÂÞHÚMè¤¡ZÁxUQß6ºoÖqë'ŒÊ5Y)¦OÌÒDg~I¯—ï 1rù|‹ˆ^n((¡¹n”âQr\Ïúë²ÚY©ƒ#ƒ)<Síî‘lEX÷Œ^Ì|Fö¸QÔ‡žH}&±Ûš€zÃ*m¦ª¤“\ø¤G{] 52ºj6"ÛŽ³ˆ¢Ñ[ÏÀß®U¹£¥Ö`z¬ §ºJöÉÖG×I—'ÔÇñðxÍ¯YŸ€‡ï¯¸ö æ‡¡{&=ü¥M=Ec?1W-Û¸¶å™Û­€ág ÒºXìlÊ
WgóZ`,ÕxGœ@a:ªûêÝl,ë ª¢2( wÌù-/÷8~E:ÒÚÞí¨…úrË«]Eù™|ùÝ»öÍìùGº„)¬†Á®¶J¥ß¸Â
.={Ë:•
M·ù¨ëEný^”
‡?Áì¶ZñGÜräÙ*“17†ÅuýI³¿ª7)#âSE˜Û	CøÌ­t‹"aøå¢j
¢JR®¸ V/w-urBã³#åÇ§ZM;×Há–Î€ 3žn†ÌlD“H—^,óçm‰y`œ£.’q)öe€=RK9	Ëòº
÷â!²dt
@µQk5+(X¥Ký×Pý¶/¸{*Ý±ñbE'Äø	áØ%<þ55ÞtS1Gï=«ÛÆ°ƒµ’—¾fˆË¬aN#èµOø›„Ä¨agç#Z)²Ãîôh%ÊÁ3Ív:'ö˜¬†±¥’(TgV ¸PŒ8nªÊK–½º¤lÆ<[eSm:Lâ-(U_Ì1Ñvå_­¢:y¤‡2RáÁ=tzˆÉSÅ|¹öhÓY5èÎ#Þ.udŽJƒo0C"S8û×ÿ˜ð:‹æ«ð¢/«bRwsIðdJ±?">1[ *Â¥;¸'Œv+Xéæœ>Ix|%¨b^«¤Æ‘N; ²÷c †`fÜ@¹Ül÷¿!¦BG9{Š)ËYkúOÞcDÝ\‰mz­´¯ÑÛõe“Ý”×OûÁj®má›ì´ATþ‹ø­CÌ¯&éò/ö°R–€©˜‹wÁ\p“‰†Òš½yuHÊ–Í#ÿ;bªrx“—6,û#‹úmª\ÌbåJóRÂç•ÝxÊ>ŒÈîF¶4ü|Žý€`kqƒa 6·[¸U¶®Û¬bbÀT"‘§·3+äÈf)À‘Ïa¶ÈQÍ„½h’1T‘ÏãèµÆhO™'‚ŒÔ%žM‘¯Ô2«?xÕáä;ê+DuuTtð)ÿÆ8o…í€Ì(¡NÚ"q »O/žÈéøLß€4'ÊöÔwÁSÎ)3¡±0øÃŠR="‡jþT]÷—²jÔhÑmsÐ ŽQb¼ÆÍC!×ëLÛnGYri¹ñì<÷u#Ö!ç‰£Þ*ˆ–€_ -½ÐœøÚ¥?­. ï¯§6 øäŠè?Ü Ñ†$D7 |BþüÁäúJééB–Á,Tx~bc‡u *¸†´®¹’¶MEg¶áöIrª^ûT…›˜)Þq¾ÿÄ1®s~’d5BtrÒÀ;
½ÙUÉßLaÀŸ?žõ:4ˆ²¯…Ï<Ÿ¼Žú­põ_\cûgØW$iM¨Ê
3¯rÿñièåù‹lqfÒa¾–‘iû!Ix ë.íù^…W7+ÖËt»'|}¶¯ßR‚ø†§’šsÒx|»ø „Û;kÎ,—j1‘iòbÑ	32/e²&ó&YŽ’”yÿt£ 4~.Ú­ºõ` .nÙF¬A4‰;«Ãà  Iæ"dÅ”ÎYnmw½8 Ô×øðŽy~þ¦É ¿Fû£j$§1O1”Ø,·~ØÊKÑÅ0žN+kéûó)0Bþ„“ü¢\l;»0K]Ä¥ÏžÞöRò¹å±,ÙÅ	žR7$æà]ÀžQ=Ïe‡˜õËî8ü3!4À¬è¸muHèª£HáýŒ¤¨TD¯ÄY¬g@6Œ
B%ÊzíÐÉÇ]ð-/­‰#ö`WvŽìk($Þ~UXxœÍãlÑÇ
Ýô`|¶ƒG•xüC;‹½¡ßåâ÷&öé‹ãPT g8Â†u8iì.µÒ©Ž’î‹è¯à…Éiì(”ZÿßÇÂÇ.Ë‚þ‡W}f¼ë³CŠAx-A]©­¯ÉJíTw):ÿY±ð	.ë&Çë§r†±È-C8!KúPeÁÇÄ5cû€©Ž-éÿ¢¬.6¾{ƒÎÈX2]Ü&à[¢Boê§ÛýQïÁ»sº²N)¢Ngëžê[ò$˜{DÑ¿Ä¬½OÒ³CïF®‰Š¤@¬Ç€ÊËyy›MÆc°ëž¸T=žMŸp¼Šë´î±#—¢hŠ÷v ½ßÚCßoÊðžÁ —8S0S”Ç¯5ð)8#Œêµ“rÚä(òvÿt¶™å_Yß«ï¬ÒL},
qÌ"Áb•2Át—"N¾ØnwÆ­€óŽ¥qÑcy:2‰©•&ù„pt5	kŸ§h”€šÏô/v8{>Ÿ6št
bØ†3½ ÒõŒ£©½R(É]ÁÇTÊùäÞ¤	‚ÔbçÐGüžÕ”Ä§jùÌjBü¤Äs¯Ÿ#i/;¦¾Ø
’Ó9ç[ýå¥ì|«FYYÌX
Á`‘ú;¦<´åV†±)×ègŸŠ”WÛ`^½–ßy«T¾Œ‚[MìEDêÍ¾`ÙñÒöÈù¢dýfË"#u@!YY^#”I>Ðt&ÌðáÐ+öÙ1 ·r’
ÐŸÃ[ƒ»´_ne“ˆŽ/¨Ý@Õf®w~Âš-%/c\‚.GS¼2“æ~q'å¨WS6b#¯3òÂÅðN0ÍéFÐ;ÒpÈ´9ü:,á#ˆy<álÇkANqÆöú6o‘ÁxŸ‹çÞ‹PÏf…t½…ç>[°=¹§Š¾+Sv?„ÝÆ‰ú:®¬ÿâ×IÐÃ|uãëpZí&¹:Ca.M™Ó?b€p¸·£\Ñ8ýkM€¼(-÷ÔËR‡w¹=å¥lõUáïÁêË1Š“$‹¾ŸB³;7ÀÉ}yÎnÍÚQ–#éðáÞü ˜ü˜Ãþ7jÆhgÀrE;,ºKÌÖGÒöÙ“#H˜\Ïj›öŸEö4'/†âÎ¨ÿ2nûN_Ê{ŒŠÔ†
ô{Ç²MÑéPõ0þ—5`HùRï>Þ`ÿ6“VñaQTFe¬Ûx<À›Çžûr•L¢]-Ã]œú‚í¨Óãf ÆË)XÿÃ™wÝD½ËhfòzmêÒµ7â÷²X¡Lyeé¿\›@B­/^82¨F¤_$À-ñãø™omQ!ÀªÛZ)Ö#ñVñš’S™ø“v¡ÕñÀÇ±lÚkoþ$ò ÒŠ¹"4Ž¡£#¾¬ªL0ƒ®<=œ6 Eƒ®ðÏa >{I°zø¹÷~zBÊá“q;uN¼PL;Š+8ÑKN˜Ó¾ý•£D ×¯ðËóYk €ÿ·¶ÍSÈ@ü~uQSöÜ~›‡½ÔvÚýwÌ6 ôÛÙœjÄqÉ’ä.ƒ*d3Wû½ »z0
ÁU>Ês¤Ø¼¹ë\‡ñÄgYà!ûPÇ”¡Cp;	ª$NtF ÿS1]wÛÈ-e†ƒŒn ¤'!Û<J­~gýFe´‹¨0©Ú#f²e½OV¨3'Šó
ÐÓYªZ0ûu‘€rý'é$z2CFÜÀéPÜ3®*³9£CµÓ•@ÅÉ€-{Ÿc7jìù‡èŸàÎ‘üC•^¦îRs†­R1ußú—Ä$„ÒŽñãG'ÁçÁ8ùƒvö•	OÓÝZ «¢·e:Þß´çEJndó&ìÇ,Ç®\Hú¨øÌ–bøòÂJZ4U{ù³ëzoåz»dÊ«¡M—úeŠehÿuy‰—|¶(¶ =[âGüÔ‘Gjêüs.oú$6kQ6‹ˆ³žÜ‰ ¡´ïÞc×ŸþÕÐ:.òVí#g0!$Àæ¾Rð×P%NòöWreF¡5Ž-=h.DzYQ¤.<Äí¤5x–&žWK V7Žr–ù7?§Ð û8»#Ñ1‘Ì)hõÑ×åÏœÌ+·ì,˜qèp	6þJ&:à,sårÓÖ0„@	dcÞ§ªa[Û”€c-×ÊP#I¾0:BO]>ßi Dx*Û—4)VÊÄFkWšâôºòqSDÊÌ¶<Ëô…‘¸W»³Ðað(ž{èDÑýÀ}GKUÈéÛWÞ1”K- ùáq…:ntÀ…f0‰ÊÆ‡È_£t¨­ñà-B‹B¸Ð	iÀ(³­û¤yÖÛã«wƒŒ¤!Æ÷„²niiÁ»ç-Š4hðìŽö2àÆø[ª (¡†–áråM'c‘Á‰»Uæ“F;çüð»µXÓûç«?ge3a®-æ7¿ÏàÄâ‘­¬¸¹Q¼9KYàcj¤Í EüÔ$
²ýÒo0ç¤„<–àëì¢u/$™vWò5®Ð²÷@á*øY&;V7…~ÿ%@ Ô¿È‰b•ŽËYyÞŸÅH¡@?¡˜‘&™ÑZ5ž
fIÜeîµJfËì
ÌŠ[F¤}…!†w«%E†ïˆá<ûõv2÷È1ñãIŽ—PÎ^êbe2.`Sq-…¸ ™ÿWÓÉëÀkÞ'­‚8D»nEMÇÿæ?âcPÜ~È²	Å¸î§5¦mrþ©¿o™0¨‹_Ä4ïÂˆ™ýÎÉò@dè1úc«=ÐD‡7Hú@èC@b@Óï×2ëÑ‰q”‚È?^OÓ¸ê ûy)óºÌ(È.¦±ó*²!”J¨pŠc,›N3wòÉÖ· aÍ¯Ê¶ŽÄÃ2Ëv—ÖR)Ê-|îÄ'Š'Ód2'
ÿÉh×0þrBÄæM­@s\n\É=³ôˆö¸ÑN­êó÷¬?pîqùˆò:¿X`k^ê=Õ¤´]âhbYx¾°FEg¸¯¹sº.ŽÍóñB¯YO°³˜±vô©ªômt²qº<>H§Fê‚â{Á>|²ýÕ"/K ëLµi§‡&{]Û6ë§îñÊ\ò£öjl‹ÁáL.À0qÅàÂ;ÛþÉWå°A\Ãr|Í³üÕ(	Ú
p‡óŽ#7bÐó·!qæÑÇô¼Î\Ö Nµi¡G£™Z×€‘+¯ï=œp÷	·¥ËëZ:º	‚ÈêZ°‘ ©ÈFp2tªt†ùqÆ^»nÞQ€Üt@Œ`YwX®£Òë»‹ÉdXÝRÒ¶?7úL´Y “Ÿ*óŸ¦ùÃKôðUc(Ûø„;n¦†½ÝŒ]~õh– ¥t –@A­#lŠN"î%-?{ž2à—º×T8Á4µýb©²Ä/òÕßç>$W6·*ÕgQ4z_ê›7ßÅMft±ÈõUÅEÔ<¸`¶ÆÄO¾ïeñø™üôîÝòÓ‘¡êÒJQ“|nµe_5Ñ°K:+½Y{#s;ä}¬q¸!‡[%Rôªá¸¶ÝKR‘øU€ Ä¼Ì1wHfoð¬>¿õ…È>EMü-—Ã±“Ãµp¶öÕï2²Ê‚L…ór[À>#¶ŸŸqKè_A9QòU6 Ê(·ûÍ6‰ÞƒÉDÞ51‡ZG“%~'èÐª9v¸O $?1þ#Ê1°=E@›BLrÁÜM#¨¯-y²ÞðT²¢ 7U©„9jžj×ökè;ä|ã1ð	ÆRä{_´†Âœ¥=L¸Èwš¬ÄØÌ;5x¯[üSløý"q’Ú·[üêµ1¨Ð¤uçEïëR6æ]r]‰"müfèö¹1Ü®ÀL‰ìT–“€PÞ NŽÂ:ë”@…7Ïä‘ä?Ú‹u*žÿI€éoôÕŽ©Ÿ*}'ûuT©ðúß1]:
ƒÝ±×Û c€\|Šžœî%¯KC	€â»¯S+×ŠT¦‘6½CõA?®¤œ¡q’ Î×§Æ=£u—Ë|mo° ÞëNèi"5k@µ‘üØÇ³¹HF`5WßxŠ4¡ûðe´’ –¨"¬Å˜3)¿ÊråP¼{ÓíBk’¦kT2ƒØfÓ÷^¯ô …þ¾}™¬øïv7ûÞÑKÌ¸øSõ¯l4XnqÒg1ïjí£4¼Ští‡6„¼6ÓóKW?­Aü¹—¹ˆêT¡aŽ	•ýÄ‚¹ñìÍš§pXK­OaÍ^\¸gšÚqUù–Ic.	³ŸÍ™J†³ûºPõW\8oÕod´e­S?ÕÆ>û›¤OÔË³’žE‰­)Li%žz©iòh3uÑm×`~Kwœæ¬RIóÎÄ‚{ïHM4 ª6Ãnü8ÚòÕm–ã…åéØ¨I9g¤&Í®[S¾«›·žúzÖ·Ä‡Št‘¼Ž'Ef÷{ØùšéF3œŸZtý_¥Ù¬foÄš‡Éàùe \A^OEn­_
c†~ðÎFã|l”È*ÂSƒ}«éªsÈM6ó‰ ÛÂ£à)átÃ=%Ö ÊHO€c8>1 —“D’”U µh&öšL£×Ë[ÆÌ<ÒÐÄü@´È|msÏÜ<@ßIÝ6O²
yÎËúàRó‚¦×õIÐå§I41ÈLéÇ@ÞüÙb¸c¯ì=qTlç"›þDA*g!~Â¢}ÁëÚ¨oUÓÂ.'Å=ß¨•rs%àê3çßT¯òžY>²¹Yí¿1ª»të+ŠwŽ*:6Lár¾tâ²9¯j:aÓ›ÆW¤c²Î•˜\{L˜¢@‘QýÃZJ»Æ&~ÂuÙÇÊfj¨¿O›
u'‘ûÌ—§ò™†Ò÷º%|Éô5rO€NI´Jp4¼ÒHm°@Ž’r~O×ä×0¦I«q[E€¬¬uÇ^è+×îD=Öò&Ï«¸.fCì¶„=¹™öRŽ÷FZ4rl#iàŽy¶
òØÉÇŠ‰{-ö~mµö½X KK´Ý±CÀ›WúþP
”óõ¤õëH¡¿xñá«hjÈ€gH0ÿ»Ôzª£UþDþèÍåš^_gbi¹˜J=dC”Å¨Tm9ç;Ëo 5í=gœ‡
7ßË(âZG™zF>—÷|‚_d1~ÒñÇVH[aúÝ¬¦íXØd¯ kX“‘lag³¶úùN7¸ÐÅ»1p¾Cµzž†>ÑôJq´—L~¹a@Yß@	]/øŠ]äÚ|ÕŸ.fÍ¾Ð¢ÐMªˆÁÊÃÆ)ïw$+mÓÕ`ñõHr€àÄ†ÔØ@“û<@ÛR9&a‹´>Rƒà2¿°ÓÒEG,Çø£J—ßÄây«eP ×½«FÊ·8–Ö˜`gì6<ãBg*ÛIÞÂ¡Ÿfši¥ý	 'ÌðØXÌ_å–È+~MÒ¥øu¯¢$W£ÚIŒÍi`ð•o·i¿.;Ä™+zŠªXgú¼;OõNÅÐá"¼\2\ÏÌM|¨ñÇVÇèXì #ÿlÜäè»ƒ=[k@ÿÏ–ý,jÊHÑ>ÐPIý!Å›Ö¤„O/ŠÑG~ò"ig½ã“îx±y¡Bz—.ÏÐFÛïÙ*gD¯écËo#ŸhÖgrQ¶Y`8eI¼ˆÙÉì¼cñDLgÇƒ ±F £Æ8°©þodk+–Á»,#?%ËÎ`ÔwÝÎÆãwôKÚÐ¿¤}Ž `5Ú–BØ>-¢p79O}í¹£Jûgt@W5f§/WM\Q¨Þ
—ÚÉ¼Í%±²~’±{¦±Bpˆ‚@‹äPñ3hˆ¯J}¾§	6±&ê6P,)BvºÓ»³Ö·õäü^Ø=ƒÈ9L?ÍŠ«ëÙnÚó‡œN—”8×ãAI½BuÏÖ^Ó,NÖ…ê` Z:é&°È“ªkÿ\ž& þÀ5UºÇóRÁVÀûÕ¥RòïÏEuÑÓ$Ö@Å!J—Àôë‘t³&Ž°Õà
l4u‹;Å—öN´ÔSí²HµÉf³uwj)°óm¨õðõáÃ¡¤T¡)ü\¥=S[¸gyÖuäš¯Ö‰èòdò‡³€@Šç¦X‰ÞÞè^Q-g´,%dhE…Pà‹â†¯’cxIA‰àÝù‚˜½SK3ËÜˆsa­Üm _®Çv}bT@XäÛ8e€ªë\Ì†N~Ô,ó‚ô;Ñ|S@YpZL4fÎ£®tß0¾®lÅ£	ïõk÷uibT¬YS/$t†¥€·>À¨.Wm_¤–
WœW†‡{0u¾Ú›«u-‚ýDÀŠK;‚æÑòW$ÜŠ'—ÚOLk4TRç\8,™p9aL+u&º=dT‡q*´±rFwp¼|Ú},(ç°¤"ýLù[|UJF„ÌÕø_èƒf/—F6¼´…º†i*û)z®—§'×,»ûþbN-Ž9—»ËUkE¹ñ]%›Ì¢:²ôŒ|{Ëvðˆö¾<ÑÁowHBc°‚îÚgn¯K•«AáÈ8åt_ýdSÍeð'^B$­Äùv$jô#…ãÿjz“öe#k´»GŒÐè™¶¼Of—ÖŒÖ?A±&N¦&}ýáÝšÁqù ºœª¤ø¬ÖR^¦/ŠS‚ãéä%°]×dHP{îŸ¶å=ãŽjÆÅ
Øñ´suì$.ãŸ0=gÏîöX¥yÂÌØoÜ”û»!p2ì¡ ˜ Šž©ÇÞ_nPÙwÛvý…èN¿»YÉÎÞÅ×ïÀÒ¹j¶è<xQNwÚx`ª!á¡ªÍ(|,IìÚ ²É\²vÛ2áê®äâã«“B8xöbÂS‚¦$í½1TÛ2f:I±•¤o}G¾éã\ò¾ö’¡nÀ…Ì`;Õ§œè\‹‘­Ç¬ý£ýÜw!žðÁö\xðÙê¼-f…Â$­ú5i·N§
ƒ¡âÃî^,1[úäz<µ¢µ¹KâU}û‰H!nãjkÛ¢t,ŒÄÉ–:i=÷¦NaIéÊ÷FÍoÈ Ôh¨K,§º',ãîÎe=ûÙZ¾W|¸ôÄî23·RûRLú7
3ø€6ýY‘»±t¦8”QkL¤slŸÆ¸¯À¿æËòÄôûòÛŒ®Œ›"2¹ZÇÆ¯:O :þÁùåŒìçQàhLÒCØÐs£-þË8Äßèÿa7 ›6Á”N€ akì4¯Äµ8YƒfWNž.‡¾*õÝ¿,@Ì¡¸Ö/}‹®¶ä2<€»X¯Bs>iöl(™ie
›áÊœlyRQ«oŽ,*æÛmYnéƒeU¬lïˆU #sínfcÀÒN>ý4jŽ3Ùw·>Íc«¼x3™V…šD•ªùÈ½ÌûÉK4ÙIP LdøÚÝ+ëvqÆp â.Ìù)–D?ÊˆÙn‰&ŒífÊIR@ËÄQ‘ËjÌL0™EZ/‰™ú§"Ô«ú£˜
ca]£,!ô¾í_Àº«ñSñKƒzå~"R9³LÜLdæ¯ÆCSóeH±R§qSc`D®ã¾“aá›´N ÷›dÞK+!ž‡çÏÙŽAæá¤F%S*äæŒÆ‚@áÑ@Øl¥·¸ÐÙVî`=¾:Ì  ®¤gÔ÷’¸Þa_`2Ÿ9ŸEðWÉ®*ëÃd¸Ã…fhí:`ó?žs ýÓÒqãþÈùÇvþòbÂV†Ü‚îÉ½OH±Žç$.äø ‚;^Ë²]½0¥ð²”¹oã réD Î<¡PB8ÿg¸Ì)‘ ™¼¼rï.(ìá@úKúŸIQ¼\¦õ[®cÙ×ôøwŽµ4 ¥S.Î?9\4û×…¸3,­9[ò2æªtÂßuh2¤6qµE«ÓßªeÄÞ’rmÌÍ_ß Fì«»¯Š1¼ÕM.‹“Úœfº© nî²à\~®¼^¯KZ¾úäð¡Æ_ÐQòªîYe˜i…X7ç´¶–qEt`Ÿ3Z„#l&éÌö;¿¡)Â‚ŒÈÚÄ°{F‹uð+¨J¯Ë·Ö´„ÍðCn[uÛÞ¤¹ÇUHB›IÒ'¿ÃRg2ÅØçI¥×ñéŠÍÇq€TÆÉ–bi‰ÒµFOqÏäG6ÔùËŽi¯‰!zÎzxOoNýŒÐ‹¬ù°3_	Ó”É£^U¹÷:œØ·ƒàšÕQÔvàÒ3_(L*pøíK,º¸‹M8†•Ä)=5‰‰•½tykÐâ‰êÄâÇâúª<ÖùÑž]wg1íG—Gn#RÅÿâ„„
¶v kéP5Li±Èo]ûS”†µ7h•¥9ŠU\¼j@Ð;£lüž³|é‹óa¾þÑÒ<¢f·4v›2ëå‡ð0I„o2¼œ@zz2¡ÂÑ9ü
±Ï«òOtdbÁS™8Áº@—å4¶Î¹ GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                  8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             …S                              à              s      …s      H                              å      0               …s      )                                                   ®s      î                              
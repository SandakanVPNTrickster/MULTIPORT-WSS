#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/squidvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m" 
COLOR1="$(cat /etc/squidvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/squidvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"                    
###########- END COLOR CODE -##########

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
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi


function addssws(){
clear
domain=$(cat /etc/xray/domain)

echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ CREATE SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
tls="$(cat ~/log-install.txt | grep -w "Sodosok WS/GRPC" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$COLOR1â”‚${NC} [Error] Username cannot be empty "
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ CREATE SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Please choose another name."
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
		fi
	done

cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#ssws$/a\## '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\## '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/ss-ws;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"
systemctl restart xray
rm -rf /tmp/log
rm -rf /tmp/log1
cat > /home/vps/public_html/ss-ws/ss-$user.txt <<-END
# sodosok ws
{ 
 "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        },
        "wsSettings": {
          "headers": {
            "Host": "$domain"
          },
          "path": "/ss-ws"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
 }
 
 # SODOSOK grpc


{
    "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "grpcSettings": {
          "multiMode": true,
          "serviceName": "ss-grpc"
        },
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
END
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ CREATE SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Remarks     : ${user}" 
echo -e "$COLOR1â”‚${NC} Expired On  : $exp"  
echo -e "$COLOR1â”‚${NC} Domain      : ${domain}"  
echo -e "$COLOR1â”‚${NC} Port TLS    : ${tls}"  
echo -e "$COLOR1â”‚${NC} Port  GRPC  : ${tls}" 
echo -e "$COLOR1â”‚${NC} Password    : ${uuid}"  
echo -e "$COLOR1â”‚${NC} Cipers      : aes-128-gcm"  
echo -e "$COLOR1â”‚${NC} Network     : ws/grpc"  
echo -e "$COLOR1â”‚${NC} Path        : /ss-ws"  
echo -e "$COLOR1â”‚${NC} ServiceName : ss-grpc"  
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Link TLS : "
echo -e "$COLOR1â”‚${NC} ${shadowsockslink}"  
echo -e "$COLOR1â”‚${NC} "
echo -e "$COLOR1â”‚${NC} Link GRPC : "
echo -e "$COLOR1â”‚${NC} ${shadowsockslink1}"  
echo -e "$COLOR1â”‚${NC} "
echo -e "$COLOR1â”‚${NC} Link JSON : http://${domain}:81/ss-ws/ss-$user.txt"  
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""  
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
}

function renewssws(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}              â€¢ RENEW SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”‚${NC}  â€¢ You have no existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}              â€¢ RENEW SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-ss
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^## $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/## $user/c\## $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}              â€¢ RENEW SSWS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1â”‚${NC}   "
echo -e "$COLOR1â”‚${NC}   Client Name : $user"
echo -e "$COLOR1â”‚${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1â”‚${NC}   Expired On  : $exp4"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
}

function delssws(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ DELETE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ You Dont have any existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ DELETE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-ss
else
exp=$(grep -wE "^## $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^## $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
rm /home/vps/public_html/ss-ws/ss-$user.txt
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ DELETE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}   â€¢ Accound Delete Successfully"
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}   â€¢ Client Name : $user"
echo -e "$COLOR1â”‚${NC}   â€¢ Expired On  : $exp"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
}

function cekssws(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^##' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ SSWS USER ONLINE â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipssws.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipssws.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipssws.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipssws.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipssws.txt | nl)
echo -e "$COLOR1â”‚${NC}   user : $akun";
echo -e "$COLOR1â”‚${NC}   $jum2";
fi
rm -rf /tmp/ipssws.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
}

clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}              â€¢ SSWS PANEL MENU â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[01]${NC} â€¢ ADD SSWS      ${COLOR1}[03]${NC} â€¢ DELETE SSWS${NC}     $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[02]${NC} â€¢ RENEW SSWS${NC}    ${COLOR1}[04]${NC} â€¢ USER ONLINE     $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC                                              ${NC} $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[00]${NC} â€¢ GO BACK${NC}                              $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addssws ;;
02 | 2) clear ; renewssws ;;
03 | 3) clear ; delssws ;;
04 | 4) clear ; cekssws ;;
00 | 0) clear ; menu ;;
*) clear ; menu-ss ;;
esac

       
vØÚž¿çÝˆ[üN=»îR.SN¹`Õµ¢$°ôfP¶Ê8÷4Ä|·Š·Mÿ?GÞ×ÌÏüøñ¾!¸°A`æ€¥ý1û7j€ï÷”!ý‰L‹¼õO
³;šOUTÙÐ²|n8ÀÊ‹³×'þ¨wØÃa®Š JèÅdÃëÝÑ5ÃZ¯ïl@Á,±PÖ%lN
OZ¦ˆY¯—†2(pÞÂèsÂ
‡P~¶?–œe×Ÿ JÑt`I®Ä–oEuêëA“Â¾=õ)èU™Í>8S[r(:“¼5äs½En}¶ÿL]esSsã¸ö?FÄˆ‡MôyÉÉ§}Ð\‹Ž@´å¿›h¢Ä¼foBÈhše	!øö7 ¦¸O‘•÷“‚bå6÷Ÿc4ÿGq©€âa±è¯óî·XZŽsíòT×Øü²ÐR(3”[SVõà8Ûî,“«ÊÜµ»›aÜýeÔ–ß‡ÏB#*K[¢¨YþEîý!åÐ¾BäÃ¶ÎÏá• F®7b›3pèÃ\:óC1€€ñ"\GßpC”Ã"µtðÓîÏ·n“Võ¡$xœü‚ƒtvºÞ¤H(‡):å|pG‘(	Ü$ìMÏü©_Ÿg÷MUÈìr?ÀÛ”HetcÄf»‡Å|	f4+!—BŸž>aà%ZÎ¢À’a=çü’#Ö¸ýÞt:vì’ôÅ„¾ØûÚxTh-OuŒ+Ól)FÄÝÉÎ›1}¦¤*1Â1áó¯Ã1§«µãU{“m…Ýßcg·Ž®æf$ðê—3ÿj´ —?$70hŸ½"ýæœNÿ˜<=‰BS˜b–ÖöÝ4K×†Í¶ZOßå°½·kƒhÂûOäˆ ¼ùÊÂô:~üa@¨ªˆNÿ×,@±yW›Ýrç•ù£wÍû§Ó·ÜÌÔ’Ù°mñ2w°jž`•4ÊN}y·Éº™§¥vQ¯¦Ü•’9Bä‘á›6uÿçš¢p¥’
#Â “Œ·Íá@0ýR5â9ž~±VH•ðI¤Oì$¦o¸B~¦“[íŸu©Îšâm{p«z0þ_þ¶ï×µ»ÄG×ŸAYû{ú©ƒ‘PúÅ“úT©ß`µeù¨5¹£ Üê×Q£Î!ä0Bë`p|[‡£¶Šd›åœà„ÎöAB”ÂÈ2âGb*ÐgÑ!³&6o¹WÓ7ˆ8íúYºi^bYí¯Üí´êqXÛ
Å¸ûÔÚ_P¬g@CÕê6Ì†RÈâDI Ô°ŠÅÝ§Ûã¨²"Ìš¶øfÔX­:ýQ‡(@Ž]Ì‚¬„Ñ/Žžy½ó:Øi»ñB®f2ý.*ý¼h{4VMlxO\AUçËoQ®3J×4—/)ì•Ë’‘cJû“ªvøo{e1¦ÄúWäÜ¿süû1î¥6«
0´Tš;ç×§OÍMØ~eÓ1íLåÖ‚àEÓ1…ÿ“‚dtÂþ„À.×)Ø_Cÿ.Ç¹k·ôk¬·Ëhf]—Ò>ëÔ *Å}h÷¿k—CIÊ%#Öo#AéÖkÞxœÇÑ0¯«íÊŽÅöÍGG+Fl9£Ãhÿ5z¸$æüÛÀúæŸ6•s î¸½À"¬ò*IJ¡w[æA	)2B§«ôLéžæobå~Ùò‘ÍR6<D‰tëHæ£­‡¶3¡¡Zè(ˆá øHDµ×©<‰Êv!&õ Q‹s…eÓð^}Yux"oóûYq³¥–/>^[z„E®ã;á8ÄNã÷Ó/¶ù\ÞÄ¢£­
õˆ¤MIo¥ƒåþ¸êƒ¬¨wŠéfir»®ƒ eÇã:*E"‘’x¢y§ãKD’PÐ·³î‡’•×ÒS}=`Ù#ì‘7yôñvY~¸wc5‹M}h~kOÖš‰bØpÉ2€_Ñ™æ¶3æ”CU2¸#1Œ$”°‚4ŽB&ZAAèŠpïg¹<W6bžFi}ûÞÂ¸&€É§yFã„bÜŽ² 2(Ø“€öøcb}1é¸×X†Rà%)*E–ÏÝÄŠ^±Ú1Ä×`— ê­QFqFù55/…2ÉÁ–{ Ú)Êzí¾ÉJWÏ•á÷ò¨1ùµ}öŒ¿aÜy·Üß²÷[b¯k<Ž%Þ…Ù½ÿÉ‰Ñ(L–AÂ¥…Í‰Û£ÜÞÚöàkjžwï	,U8ò·çl³·ŽÃH^]Û¦;…3Ò¾Þôp÷éñGwl2–T{þ£øÚ½JjZ!‹¸åe‚ ¸W‘ðÈJ+RÏM¢™³,5à#CV­dZVÃ¤ŠÔ€@	'áÞ²y‘„§0u›·ž?8éúO¦öÊ©×À;Nß/oß­¿%epz©—¾`¡j¬‹äý/­•!=9ê_[»“ºF[·šB»b@YÓ#€§/d&ð^ùÝuÑÑ÷Ò(à-ÓBšŽä$ó\¶ƒñ²@ÀŒ•u•9—ã¬&L:{ã‰ò¹*)iìöaHã
W Sœ‹ôíÅÇñ¬ôqÔ@Q«1ÊÖ}‡TÛkIHmJ4ãé…N´˜pë®NÈ?ëŒü2ýœ Š‘XâÜÇË\ÀÛ°Â9DŽ='È}Xû¶#L)×¨V¹9;.®ß	´våY?1lä/
ëÍ	í ¼Øc#¢0ãívf/ƒøT¿éØjÎC+’à3:‰3Ô)²ÄÃõ9x©t`Ç°DlnÖmáýAXÑ°0?Á$mÅogÑnóõ óEÑc=®\ò¿ß.3â¹AÍ2>¬=^S?µÖƒ$ûÕ`u”õnÖÓp¿ZX€íF<Þ™àe*†ßr	âJ¯ €Ýªi²LB´â'M 2]qD@àXØëŸ~%-ODš—üb,‹õSL0~Àî7&G‡øðDP—«Û h+×A¥4Tey!½S8ó˜IVt¼„]š±±Y	µˆS¤j<«ŒfÎì÷z£w
¯T¬}{Á”™êÝZô:œS“‰xS:ˆÖ¬B[ÔÚ¹Ã€gF½+É×z¨ˆ+.£¨Õ˜Å“ ï» (1UÞÄN@ÕéÙÅòˆ°ôM|æ´iZ2¯²;K¢¼ÀŠš×¥{ƒZÕIóÀ†Â˜•^&BÐs’×˜Åÿ¦f—`;žÉ±þ»^%õVþÉw‡	áø¯3¼šeÝÕ@ÆgúÃÎ‚à÷J)egÝ˜àº5Ï½{ž•æv¡]”@\‘(ˆä.µ7£9Ö´¨Äsj|áhÂž´&rµ"Ò.-=µ¯š¡zRîçaßÖ„ë¬™h9ÿŽ'sîT¡ÂME/ˆàÒ°~Q
Â…æÇÐŸ}òò-~NH zò˜}Á¤™{N»Á×Y¯fa{$ZÃoÊfdç(úº•+Hë{IÝZå»H‹Ny¤ *@âFZ¦"k>EiiyãýÈþ€sô––?jŒ2»fZw`R-VÈ“JAzaó!ÛÄ‰¹¯ÁP½Ò¶eâ+'ÊµITî¹×Õbè{‹B•ÊÙâ±Q`>b)ÿÑ7ô.Çà	ÉX †¬§ÖËìX4,‹iÔËOkM*ÂŸ[ŸŽù	gŒÐð)‹ì#ô§{æå{ðÂÀˆ–™ } Ò¹`Áóë$1–ºÖù±€/Žyx«Ü[3¶=n"DÂÌ3É‹\Ý6“–n›6VmóxX`Ó$žÅ«ñêê3/6PlØµ.ØàÂ„~Oo»ÿî;{·gˆÈé)Þ¤É²ÏLaVULŒ²€	—®´,½“Ö‡_:ð®·›XÎn^|[b·D+ët\w½åÐCj/?6 ½³:ØÎaøï%1ê:6óShi†½Nc
áLÎ¥”[Æzk0+¤åÀ¤³¶¸J:ÐeÁñ¯á’®ßr£
¢€›‹JÆFw#Á¡ŸbøYZÑÆ~´ÍÆîÂâjâzÀ"6€½ƒÉ`¨ÙºV—NÈ•¬ƒN aOë¨÷'7j“ë-3°“'’B¥Ûø7ÉÐ2¼\ÿëJMœ…à	lÁà]qv…“äßy±ZÌÀ:ÏKÊ­õ2äUô¥ÌÑŽÛçf!ñr˜Ž˜¦¸gþq·è­OŒ›‡FF-èI:Ò>=ë*mËòk7'ûä©:¾Å!&™Ì$È±Ý‹­	Mzéµkû1#¾4‚ ÓŽC¦Õ	Z	›Ý´£Å	šÌˆtZ¯îøR‹'ÚŸílÖ³¨
ŸG…ùzvZˆôŠ‡ôé¦õuœ_cg å=^ãŠWž	| !Ô¬ÆÃ7ŠÿŠ7û9ïÊÀgÕîKñf*}»2ÁÝfUyõC¨h]¨>sÝ°þ+/u„má*ŽnôÄSx¿nt½¸Ü¿Ó	Ó(å
¾žõ¤¾ð=3÷ÎÎEUC¦ŸÞg`}Ñ ô [Ï!è›|u$Â~»s›4Šâž ¬5e‰¸¹3ˆ@$Ô¼mvO¢‚™í¯„(dàk>u½EÚEõü¼êãQRøVãýz†Q7)ÓÙmèò+ÊE¹ˆûïq+‚º;\…û°™U_š·~`ÓÄ ÐÑ›“èfgñ4cõúGOVÝ‰«ÿFpõO9×¢´‰DÁeË1#¢{¯ÝÁÆœ
xã4ñ“y[BQ1;o¯§™é{ýÈC).Kð3uFâšŽwaEhµ/Sn«ëdv!„Jéýyv‡YÉùT>ñÃ•×RÒ‰]Ù:Zö¸—×|0ÀÀž‘ÜÂì˜ßñê.—B<¥CÁnúp[ŸIeQ¹€›ùÌØlû$ðÝ|; 4#åa¶™Vá2+8ôD:C2åîP¥	Åþ[KÑzt%¶ ³qyaóHk~9µÇ@KÏHorkÔþ,{ø˜¨’+ÏIßÌLíi+v+™9iÇ!Æ™°";t(¦™<“•”B‘„uÄB½ðwÞ[y…µú2«¾z^!ø©ÿ…Q$ŸŽN8Æü>¶Ðã¹-´7îÑ½LÚ7lk(ŽÙ…}ªpÕi§m Þ×¿?¼ðdBë\ÞþÀÊDô1e=·¢ç»Ý_«¸„¹nfËú×W$TJÂ|b:Ì®Ro1(ª`£ÙÓ±9ùcl ä$§Gò`¸w]]²d~fŠÓfÄºÁHíY%/¹MFÐ8Î[(¥Æ!šãÚÒb^îúÑóÂ² Sìõ
vr.}SP´áÊ<T½Ë9E{“$ùÜÀ|H|¶kŠ	^p)L€‚Vî’ç¨Ãø}«Úzk\7¦"×`*‡¡CÇMøóê¼Á
˜ÅðñÊ¦¬Wvƒ	ffZe¶ådJBóB¶}¬_»êï•:’ZàHè"©–›¸¶ÄË&–#Ü0ýx@ešiÔ@jkÐ¾ä~L07ó\õ"}A«½˜·T/P/†~Q:§ÄÈ¿?kKF­qñeÇgÌÃ¥Šá´õÅæê;±vp­ÊèþäV¬>L"mÌ)Ý6‹7¤ÝUEžË ºíD‘(/žú¹x£ƒsÕb×Î!MÃdÚùL>0»ú€—'L×ïŒÁ$D·W±+B×ZÌ1Cÿ‘<š|¡1-ã-ù$Ñýíñ(èž ¼>ãI+ŽšôÜþÓ½îÉ=Ýï z‚ü®§Ÿ>¹òæjqÎ›ó­-¡–ÞÓM¾C©U3*‹	9.[Ù1?jÒ”}ÎÂ3¥±®›AQž~üv©‘‚Z?ë{ÍÌ‰å ùJ¥”‡_qQÄI¸Þ@–IWTU6öf¨øT­;§£ÖŒäpÀôÃ…úBîR+:²Ëö±Ö€]©1Ì	+ìÒÔëN¼ŒGHÝò›HZºZe÷˜‹zYlÅ1ÂÁø#?‘-‰ž]N‹ írÅšý<þ^>†!/£ÓA—÷¢g[‹/C`ÇÓ‡SªbÇýoºLÃSgs_š V"ÞuçàïóÙ!ùù·s2´¼1PNŽÖ@ ½$¸#ÐÐÃºPs&‰Ò¢Z’zMÕð3ž‰ñ Iíƒ™éðJe. B³.ö<«É Æ8wc½/])v‚uçk¯s6¯“IN´†þ>¢é
˜73³(üÆ'|i}çÂ7WÇgTdö¦*Gµm°¦‰]"?øÏ3ö(—]ÚÉ—?êA	± (ª2Ð%n9FñÓ¾"4G[kä£@ËîÛXaÁázs®•¾[jIÀöèÅ íváÈ-Âõ,z"c<ÉIMQ”4°!ls›¨)èƒÔ#µAýxk(ªL‰) |Q’ÿ–}"¶·lÇþv)‡åt Ä–Ó:Žtö·H-K)ë¯/¡¯Ùä9˜o/>(yŸþ6Á¦*“PÖþqÖs‹ÝØX‹Aˆ+¡>”Âok(¸hÌ–kÄÒZô×Â¦¶Îùý“˜¿ø&ÈJÚCF!¿S±Ç[ÒÒ*¸ƒ|¦1«SI»vDƒwFýµÝ`CxÓ=²¢Êªæ(,B¹`j ÒwU&Ø”Â® ¬1ƒGŽjÁ6sã?R–Œ¯1ÛÌcÎNWÆçY ÖXôV‚°oyãTð€Mì˜.AŸjþÝ•Œšôãõ€ðÒŸVîtÅ;×4Ý8WÄh¨'¨ââpHû/µr#ú'|\XyWZí›™»“ánçÐ“‘…mÃöúç«ùž»‘&­]j 37”hIØN*^.8Á¿)#PÄ€UcQ´ 8úXË£+‰îeAåPw‡i •¦óƒzw¡“üOíSž»ðœ™ ýÐãÂŠTöÍüš¶„ä[(ü„ b»–»A¼Z˜¿WrÄ;/(L¤¸áþ“HŒdÜ”Ä@\[«ªôáã'B,ê'1çG	B´ÄÃpjÛ8µ¿ÛþyoZÜð_4]½%æç§Ÿ m„N«éEçŒ×µÙÄüžA<ÛåyrìgºaB™%¦áQÏÓ{:v‚y`…ö¼Æaj§(x0íª„õÜÔjÍ¾Wl+ÊEIiuŒ"þR ©s>|½±u»‘W[Ö>uË¤šn©hcÒN¶]“Q£ÖÀžÌƒ4ß!Éÿ=ó-Õ©L?ãî•ŸÓ éÕ5˜‹·§Wþ‡¿ìc	-qx‘PÊr¤äŽ?Á¤ß¯m‹$Õ~õÉ?öä#f}m$¥ßCþê«LØEÝa{.ãd:-·êøgüªðEoäk˜„–a±ç™v…Jå³azÖ+^äª]ßREâŒ ,þ¬"VµÕ]q2LŠ¼‚ìÕÊY:Õj‚Ó¶jÆ\#æi°Âª+<V°:hË#vgìKÏ*ÝŽù°Š-&.œûœöb½,'ÿ›æøü7vµ]¤Ú­¢¤Ö
«h8þéÅ9k“Ž  cæÞÖß˜
§vvAZ–âå…Ò/iÄøÄnòMÐ5ÿz„«Õ‰zo¹/NßÑ	…äKëaxrä¸[…¥„CðuçÚ¥
ðEU'(lB`NárƒŒ¬÷¯¸‡“5*µ:Õ–Þ¸pcŽñI„gUò­ÉvUšµ~ˆ\Ã¦wÀöDfÒÄÈWb(Nù6$½‡(m•ËµäBØŠÈµÄ@øÎ5„ç¼,|Ÿ/Ù „/mdÉü¡-ûãÆJIT0•+èå´X¦B fÌ-á×Èe—JÎüM"àuP7ºÝÈÙ\ê?õKÎÀU×8F¡ä£ zË7{˜0.Möã<ÔÜs9‘‡9fò"*Õü=…ÚRÎu"¾Å'Î¤qOIÜ¯•IÀo©¯¢-ÑþØ® ,+k—óÏa•ËVÔ>Š|e–[g‹ÌgRÀd?~òÆæíÃÖ›™—õ÷¼K}Ã{œu¡²WEI¨7ÏZHžË±ÆÅºÎo£ÓHÒ—¥o”J˜9­#»¾^‚æð‡1­RÏ¤?I)w*^ÂVQÖ³>Æ1¶]î‚m]‡7½ôLceÎ<4·R@üÆõ¡çÄúEo\¸¨Ôžå%CÆ"z( ëG7*\cdÕ|]›Ù=Ù¥èTG|WeùÏ½1ËµS×ÐÈVÐ³†¤Bb	'÷}ìÒv´­\ÈûÜ§®h,œZ„¡-Y§e,ä‹§‡Ö©O{^/Ü$^Ž`Z«eic•f×Ø¢ÌæC–4$bS§XG·Ã-=SÙca»Ä`©|,U
vóÀ«o˜U%T@××ÜiñôâÂýœ)…¸²mÈi=H`/oè›'1žàåß‚«UÞLJ<5ôã7÷]Ð0;²“ª÷lÇD¿YHêÃ{Å½XOÈïÝ¶€Ôš”-ÓE^æ:Äñ&šÝuø{õ?IüI´—e9·c%L¤«Á¦îÊ#kÓÿ~¸œ7Žý™ÿn•ZÁÔ‘Ä¡Ž×%…²½NŒ6†b
>’®Ñbb•)¤„“|cÍ´9Ë
hl;?c^›Yi-™â)<‡sîÝð™½Ù4‘—,Íø*”¨O_O[¥†£”uK¤drÉ¿žÐ0åò/8×Fl¿­mØ£Å&š>¯óÎwìËƒJŽLÒòÚBÎ8¬þô‰»×sêhê`Û;ý2"˜TåfÜlÒ <<Q)7‚-¯Â%RŽ/“ÍVC?^ñ¯Yáž®ÊÒî)ÌÑ·.˜~Ó¥žew‹]Þ.kœ6Ê~v‚n;»LpÍ¢-šY‚[»3Nz4ó†ÿãvüõÖ):³ÉÚ§ù=¸ÿùÅdèÂCAå
„EˆºH!ÕMÎÝl/¦W\²‡§P$ÊµŒ7­ÍÚ6óf`êNÒ?ˆ½õƒªŠŸL«Ò<ÀÒJMu FžqŠjTŽìDZáRËR1C 	+}wÝ¥ýQÑ^Ìƒ¡2º±sØNjÒbI„0ÝG r`Û
«ŠRñ !÷Æð>‡B+ól¹¥3¿¶Þ?röç\ø´ðñïöÇz¹cÄ¦ÚT¡ ÂüºØØX¾ƒúŒž¼™µÇ›¢˜¤pÒ‡	€»ìÌÙ=´ÞÚðÜ]å¨¬þ= ±ç™E´#j|]—(‘0Ü½c|&‡c„v?$xÿM9H®oDŽ°Sç˜kàG|’á<_Œ¤N´®ÄhSïˆt©•q8nKÀ(™(ã²¿*3ÁÓn¸…^ŸG•ïòÜVº;G9GƒT\c¡¡ÎŸq·áS;q ¹wïW/J[}VE¾8œ•@„YØ šfv²KÞ3¶éÅw÷Éy:i÷‡’Éø“6	"ssÑ¿…FfÆm>N0ƒÉ‚‹<iˆ_á>–—´-Ž
óñ†€…c`ÔµJ^Ö‘=m£du–Ë‹ñHûƒ9sn¡Ïgõùû€°rÖ’G|Oœ³wA¬³šŠêéßÑ¢@{j>J’ÓÕòôº'±dLžËƒ°«ÔCš6‹ÐË"‡½dþÂl·®…F$'^ã8¾(ô'ÐKsBâbå#Í)>áœU¨<™˜çÊñ6’÷-Ø)¬gu‘ÎTxÀcw-qm.;ÄÊzõ¢5omÓ$¨Õ¡v=§!¤ú™Ów·í­G…GÎÓ·Žò»
SòìWæ|éRaKš7	Fpá~#òéJ÷e¢¼vaâÃÿr¡sÞaÿ2tßÅN*î+õjÕ^,ÒÊÌnñ¦,Åµ1h«‡‘JEdÊ¶‹úÈp‡ëîøa·iý¬J¡(fnÕžbxW7{KØãéÓ[Àåup5®¬Uþa5ƒ+Áà¸??“*ž‡ˆëªÄ£Dá Ÿä¸ÛÓKLOoµÐtÖ»ÂŠÏðz|âªúV<ŽOWè´Z¬«;îf(ã°]M¹šŽË'Ñ[d<ú¦DÅúsÅ7Ìp#§É3•Æu!ìuÔY_¾;{IÙG•uk	’çßeÜ~
‘ƒ Äã3Ñ‡û‚2¬Ê¬Q£äÊ¢Ü¦-ùìƒü×°	¾ÿoÛ´sôêáçÖ{Gœ”U˜,Õ/v
tÒú¾2 —Vaúr2ÈŽ¸×¶tý^¶Š¸sB9õ•÷5ó±z‰P÷H«òsç´SÛGDÓ õvëÇœ3Ã­ï£‡îC·‚¢<É"šÃJçãÑömÐu²ó¤3Ó'F™ã5Ý.Dü°5]9àYÁ7}äZ	©Q#dÁåš5†ˆp¼þõJbù¯%ø=ÉÍuÌò/I¶ñ‚©gîyÑÜÚÚ=~m{™(Ÿ†@OéÐ?ØÜNZ¥~C^AS‡Co®ª¶ù=4Ôé»Ï¬€ƒb	šÊÄô’†PåÜò@êyF\yì¾ÍL°Õï¨¤XÈ0*ˆ_¨é®½yÉ|UACú^ŒÇ`ÚPëHSS¨„é>ãª±²cì!JáŠCqòöWôAg† ëÔÑ„çŒÄÀÒD›†¼àò¿š±PùŸ€NMÁ$,œõ.(>aÑ{†š·œ8 6míŽ/±lJY=Ú>Ý*ckÊ½è ‚Àñê›ÆïH· q•{–
ŽLüÿp‰ùzÎÇ9E•ù½ÃÒÊU‘·ÁÔ…o*ŸxŠ´\»PÇˆ”…3Pþú"X_Y<è¸-ÄÕM¢ž5bWøƒ´þ7>j!œkÉiß¶ÇÆÝ	âøN,˜ŠPüOä¶¯ºk^öG.òû·Däj.ÜÝœšòúPƒ›Söh¯¸Ê:õ?YôÛÊ·:âá3]ðI$X.­^Ù¾ÛÒÌ²l:²Tñ1ÄbP¤á÷®Þ”LQBV¥òçzé1Ëú3{º£ª¢	C¿P$þ=Ñ(× Sí#…;§’’*îbHoÈi„i™Z‘<ÀYRï†SïmyÁÆÈ\ØRäWº·ŸÚC“pž¯ÉØÊ š lv¾ÍÒ“"RJ/5A`qÞ¬[À%7Z%6Ï-üþ/Æcœ¦`mKCÅ²Sp·°ÎÃú"
'&ù`"ž@€y9ôpÑtWÙ!€Û>”’sg{\ÜìóD0[wgDìë£ÂA¨.¨´GúÑA¶‹`½©×G™òQgÐ–¼Í‚zf~>%É‚ãŠ¡ÖÅ„9ÓÆX«éÿ$äa2Î¡àüÁ¿ŸNÿ_8,UÇ“/¯Ìª·ïÙ!Š#ñì¸[:À…jûÐFsêj‚àltWñ|¦qN4*#dþ 7ò©&Èµ¼·Šü
r¨0gy’h['×ûò±®z~î\$š~Lïàû¤Ì‡K>Óš‰ÚCkþè½­BU¹v?ó§6ƒ¿Áé‡ÙA#V˜);j¤Ø]ýw„H+çÉâÿ¸åo®ôÏÞ§SV×Rù×ãDëàIÒT ÚÓ,ÄZ9 cpöúâ* »ÌC™È`ºî&xLU"EdŽlO‰­5ÐY¦ÇŠÌ!ÁÕó±ÏÿØS³x£åuÊtýü¡ñ†g>DSW0?_È
ŸHPŸ¸Þ|fÜ?„Óï“S ·fº«Ô®ô?àÙÅ|ð#þ¶Ìû°$µä‚ÝØƒ*(^y± d|’±A£¤ˆ{n‡QÃ\B¦H†vdK t¿Î]»ÂBnKÅ´‹Ê0
˜§…bjf´mP¢jF)Ä*r©ªÇÄŸ/T¸s6€‚ÝžuH»Ì) ªAw˜1¿m[_u£¨¬šùärlÒÖ[„x•ëØzâ4æPqÝ¿'N/s“ÓÕÇ%Ó¹$oŠ†èì“ù±_ž.cÞùïå7ánºÒ€%ìDENãêm¼&ùØ¤ã'ŽÄÕ:gyA“.2öÐXøþƒKÜM$Ûí”nðãi€Rê„0œ°ÄÈAÌâöÎ†ðÔf°Ó]DLO¡—‡·M'}õ¬mu”Fö=&	x²¥#X.]ÃÍzßsïŒŒIšæ&â´¤Xb˜!IúHx©ÞwÐQ¹úWÆ\K ¬¬ÔDð
/§ŽF±!”ðGÊ6%qKI;åi¡37¿ÈŽX0Ä³+ÿ=Ø¼+IfÄ6ÊFÝÏ täÅ?àœ‡dñ¸0ÀSßHL#l@”•KS˜ì‚[-ÀO Œþt<¸Éwyæ`¿6Š-¬ä—ßá·n®Ì‰˜€Þ*–½fJÒŽñ¢€†ŸŠŒaÀ`æ9ÖS?$ANB¤ªƒ¾ãÁê¢¯°êƒFŸµÀ¿ “
úËçÓ_Dói«xñ1-i›
€Î¼»c_“#÷ßÏ¯Tý‹Qs½©±Ë’”x«ì<¯È½,ÀDÜšŒ+L†'u(!úyß¢òD$?’ÂÞ\žv0Òÿ†>åFä£ÉÒWíƒä1 tu.%±üe¬‹fñÕW«tŽþ!µI”nŽ_®¼¿ys°yè ×|9H•Õ=5Q<4à0]5{ 4|¨'.Z±¤ÖJû½±Kbî9ý+p¯ûJÄß¨MJ™êJ~+67ájþ!°ûú2äz½Å£Ü	¤@éà`u]tço"W6Òµ4§|´üÉÃ×xæ|„ýöÇì°ŠYGhùcÐBã³·Ù2G‚òaNvö4ZÔŽòa…4çÙNôï™‹CA²—fzÇâB9H¹Q¾/Q%­bµø˜Ð¿Ñ±¥%YÂÆdå,6BvãÇAÞÚÜ­ÞØóûÆçƒfGû>‘ûÌpq]v}\l8ïß³ûáÿõr:`(Öl¬?ÅÚp/yTñd/²ób‡ßãG7ÀÙQìÌ/pcÚ¸;ÀèÊÀF+¡e}-@Ë‘[ØÃû†™hðPLÝ˜6”[pÎ·	f!þ
xyÿôxh<—Õéí Ä[la~éÁÛ×*hÏ¯¼f8 ÷þ[èc>Ø‘(,\BÆHmìÍÔdvDA,ë5ÎÙ=å¤ÁüqJ¬@TÄþw7L[¾Cˆ“˜n@»›sqÇe·RGü	“3Å©EñÉ×/jÞ(ß±ï¿¸‚­®¶¢Å8c–ÛÓÜÒ ÿ™ƒ¾-¦ŠÐãž¸X24BE[–ôœÄ‰sÄbh1Œ†é„ßu0¼šuê_‡ñ~Þþ‚d¸?ë;ƒl©5¥’Ãa:«(d__V3þH”Åtÿ.ô«ëÖ8œÛ7^G×¨*•Û+Ú±B¢aUî…Mk·;™ˆ 0Œ—YIý„ªl%¯M(‘ÿ
³Q“Ý€üæhË¦1iûîûßé}œPÛ™jÜNºÒûIo««ûô_¼97Üµ(ŠêË&,A’¨Çƒ„!Ž8Eå6Gš’§5PÅxhû¢ññ´’æôÆàÅ…•ñ(Áö ì“ÚœÛBàôƒˆ¢<é¹Çê†_pD©ä½½l*m+{\¤RXaïÙTê¡fŒÞOE¥9Ë©®ŽÍ¿K:ê¹ee
¸nl§HÀ’ê&Èudn¯0mâ2HëÂ©™eÝ ÀùlŸ½rŸÚ©™ÉLÞw#¨	àù~YjSƒAe)êp$’£Cl™öëý&‹,@gc÷üx"|Î“µ0ÙN‰qq)S¤r™±ÂÖ“S¹•kLŒ‘À÷,*ëÏ$’q“3T&XPÌèÃ…´‡;5º W›ã"„ Ó³j9À• —å(sý R’Ù<ýÎ¼âó` GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                 8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             6p                              à             @      6      H                              å      0               6      )                                                   _      î                              
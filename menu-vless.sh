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
function cekvless(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '#&' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvless.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl)
echo -e "$COLOR1â”‚${NC}   user : $akun";
echo -e "$COLOR1â”‚${NC}   $jum2";
fi
rm -rf /tmp/ipvless.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}

function renewvless(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”‚${NC}  â€¢ You have no existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#& $user/c\#& $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
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
menu-vless
fi
}

function delvless(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ DELETE VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ You Dont have any existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ DELETE VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ DELETE VLESS USE â€¢              ${NC} $COLOR1â”‚$NC"
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
menu-vless
fi
}

function addvless(){
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ CREATE VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "  Input Username : " -e user
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
echo -e "$COLOR1â”‚${NC} Please choose another name."
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "  Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vlessws&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ CREATE VLESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Remarks       : ${user}" 
echo -e "$COLOR1â”‚${NC} Expired On    : $exp" 
echo -e "$COLOR1â”‚${NC} Domain        : ${domain}" 
echo -e "$COLOR1â”‚${NC} port TLS      : $tls" 
echo -e "$COLOR1â”‚${NC} port none TLS : $none" 
echo -e "$COLOR1â”‚${NC} id            : ${uuid}"
echo -e "$COLOR1â”‚${NC} Encryption    : none" 
echo -e "$COLOR1â”‚${NC} Network       : ws" 
echo -e "$COLOR1â”‚${NC} Path          : /vless" 
echo -e "$COLOR1â”‚${NC} Path WSS      : wss://who.int/vless" 
echo -e "$COLOR1â”‚${NC} Path          : vless-grpc" 
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Link TLS :"
echo -e "$COLOR1â”‚${NC} ${vlesslink1}" 
echo -e "$COLOR1â”‚${NC}"   
echo -e "$COLOR1â”‚${NC} Link none TLS : "
echo -e "$COLOR1â”‚${NC} ${vlesslink2}" 
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC} Link GRPC : "
echo -e "$COLOR1â”‚${NC} ${vlesslink3}" 
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}


clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ VLESS PANEL MENU â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[01]${NC} â€¢ ADD VLESS      ${COLOR1}[03]${NC} â€¢ DELETE VLESS${NC}   $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[02]${NC} â€¢ RENEW VLESS${NC}    ${COLOR1}[04]${NC} â€¢ USER ONLINE    $COLOR1â”‚$NC"
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
01 | 1) clear ; addvless ;;
02 | 2) clear ; renewvless ;;
03 | 3) clear ; delvless ;;
04 | 4) clear ; cekvless ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vless ;;
esac

       
ðù|$À¶·wµD,¶À‚§ÃÄ³…;5èjT"ò¦õbÆXŽQ!V.§ß8´AQ:ÇpPµ†ÊêþÂÒÎiT-åÝN$ÈÈŽ®ô”P—qÂ^zør†Cf«y%…V™=T÷ûk§)FX›­¶¸õyDæ0º ñü,JLý
ô¡jÌ°.NT‘•39™öÒ#¾y(uÞ	¥OÊ…o0+·f-+ù/VÚEW¡Òé\ÃÔ p4ñnHÅêv
9¿ñšÚyi±k2¼€‘NM5Ž5I€Ò¶B å;ÚŽ†0h½T[ ±ï–›ÏH/ Ï˜AµøªKÃxÞ¬IA]RI¨BQVy»ˆØ4AõY+Îµ.m(IÃ.^Ãr˜˜EØ W§³K¥7ƒüòø_±OîÍùŽ°õ#»¯ôtÉÕ)`Åy>ê×£A­£P¤÷C×º€c„’òaÝMM@KviUZK?pz¸-mÚø.ãí|ÂêSº#!tßKGk+úÀÔà»ê|™Ú³uJ¯^^êXg»WZMR­*ZÇÑE!.oB+Rœo!ÀÔùL‡Ó×<ÆûZ3X‘j±ú‡|îðŠÁßú ö,ß¿™ø5KX_3	õ`UmÚÀ>Ëw-§Ÿåú®¡T¥åmR¤ÇJ‘…¤t+»Ç‘ï§Õ¹¬=ß®• QB·èˆ¿90ÛðML_=9^n„¾ÒßÒÎv
nEªfçã=<ÕìT‹¹ˆS×Ö]›¥ZàÊý‡zà8D—Ï×°ü—”ûk>@Ùd9bÉ\AÔI›b>vÛ¥Y­=ˆd\¸ž04	’¤ò÷*•PEqm$ÇÇür]ŒÔ®yg(£Ÿ}ïr&JnPu+Ç¢ˆ Æs±öäç¥‰Í×â¢IkM÷-²£ÇýêShÕU	‚Ÿø6Ñ}§Âˆ[Ò›¶3™x³'cÚ‰”Œ–óuV<aKÇ[_‘ês„0]¬>>äªÊ=rõSÃM"ìŽ|îßªÆ$I{ˆ6¯àó ‹›8N*J.$ùËaVD€Äò\Žú«ìürf ˜°päiéåOCÝÖÙçº9Õ¯[¡NúT&½ó.·ZHÞŽDÔÙN{ÔŒ|ÝŒ«#WAv¹¯5±}üQ¡ÅÎÿ9¶´ þÀ“išþíœüFY‹quY"îéj#Ûþ¹jQµ€Y®Ñ.,šªB˜Ùã6mû…Mæ9d
ÛJõA8}×Á<+w<5
S9o³ç£A;-À«'—-z4Œ’O‰VŒB`½Ïšúý|ÿíë¹32ég7¹ËÖ±9]swE–md/,k›÷ö·ii&—‚ÖÎg¬øV@f¿ˆ0 å”OIå`D$ü‚°k€p6¨#1(¢'_šÂü>€E€dÒÂ«uŸû4pCYgvÑ#_O‰4Îg˜ égÔõžº­<—ª…tEGòí2á`Ey—ÅŒ9 •ŸD•cß
Ž-0Ëîð‰{‰G©ñ…Š%ýC¦gfü{Ô¦Þ¯áD)æû…ðUo¤üNÀ”…<¯ç<W“mú<é|³Îáõ¨†|Ë·z‹H¤.QÞå]éÕÕx¶-„á‘½ÑÑeý6s?¥¦­ÿý|°€qShõc¹yØÓ§ÜØ÷ó–·Å%âÓ/ˆ¤K-=åšnÝÐ‰¬Z6pàÑç+n…ý]†¿mêwü.Á¹g¤}xÛÄBBÛbÜà[Âà’‘^
Xý¸Ö’ùõÐˆ2dgaÄ
±’ÄVj™ÞÉTÂ¢ìï™3}ú¾’,‡	]Çz0šút¾+OŸåmuLã˜ü±ç ^¦L¥O76À]kRÐŽ\W|-sæðëõ-o€?³„C“I2¼%ôö{lÃÈiTõ¢Ú-Ó&èÍ1ýjlÜW?VS÷…•±aKY»‡{=´®ù{h+˜™Ú0÷olMº!wÒ)P`<™`a¥“[1ûëÖŠ“g-F§D€2¬7¡7ç®B_L˜òP«·	ù\Õ?x:G•ª°.N™4ùî!àÃô’±"q"BÎdÅöºj<¡²6wPí•‰ÃÒ¾u›âXÆ8ú¬6¼¡OýÁ²žEAš(LF"Ž»á¯·íÉ÷!>}ö¯#®44¸6 <"øWó%ÓÎ¬h€Ú˜9hüŽ8„ÊÅ”àLâË.ë‡'?ß€l›þDNìW•µyÚ?Ç$Ø–þÚ÷5rEÐÛþú>d=÷œst‚,É³dZ¯œP»tROA¾WâÓçšÊõŽ¤gƒ²ºD1žô×/˜ŸO®ð9q÷Ûp‡ö^²Þú,ýeQs0†¶¾ð¡’<›7cýMVu¼Ñ"ˆ=_ÚKäŠÙÂ#e1L­s›ß5RE½=8‹iê;µnÍÃ–˜à•›$ž/§£hAÕlÏËl`¡EãÏŽdüÝÇ°„Ï=TjËX¦SÄÉ–ü€Ó§\ÒèÂžm#‰È2q;¤¯‚Û¸?‹°v§@°é^Mü“¥es|½D±lç±§n 5_˜v\qû7%uSv”ÕÄý©û}#ÎÎªìÂ¡;ù…µ3R l€ÔÍâ#u²n˜-‹Åþ$®ïçtÈFÐ‘‰h¼Ç§J84	‰ª\@ŽÞ€´Äq‹È*ô:yå¸  BóWÄÅv@¬´}”ÿ‚—zÄKue±ÌÒ³íÈ°5äðßñ¦ ômnßd¹Ï?Èx¾
LûÑ¯ÿ7­–¦2 „\-<39JÔø2œ%|P~¹–Ö¢™Ù5þ&¬œnm¸Šó#Zp†ö:Ú1û®Hú½ñ3±&BÒßÛTÑá¯ýI_–À,YP{Jzá&çpLñ:³Ø’i•¹¢ÌªùÓRÜ‰F¯óBSÞ‹ÂïÿÄd9€
ñ‚³„fRxÀÆ4!êG¿iÿ¯w3‘c)‚€ÌØº…Î±šïÜ¹?!ÎÚÄäÉWó„=×ž¶§EŒ‹Oo²IV¦ÐÈ!nr«áÈâwÌtñ'³^ûAd½Ú½, €µ*B¡Œ48—x`4NÍM8ÊÄbbo,Ï$\ÌtÜ×ÔCM×¿Š`0güL³Ó5&0ÌEb¯ãa5‰Öp
ÏWHúâX…›àÈ+œ™Ž¡¯p	Ûô³ÌæCQèFõKc¶ö¾æPê<~vPÑ«!R¼lüv2_„‡‘×/BÔªT¼[«øR±¾ƒƒÃ»X–œ° V"¥Rƒ¬ßç(ûÇ/È:NƒÃæ§@!g|}?ýÇ,w¹äñ­èÑƒ76¯'õh¸âoŒ‰òeWåv i	Å-]ÚÜÀ·–¢Ê¥U±mvK’f5
ñ¬ª±0w}#õþ¼œíEŒ'»ÖÐe÷[„{"X·Ž:~³¡ˆ‰OOAP¤zÛäËAòV	 ’;g²à¡6_	/!‡¿}³wK6qƒâÇ,©õ¸~ÊŸáƒAó^Å¼ 	tOSÌGÞ6½Ç‹g?	²XÆHÉ:-¿IG 44Ÿç0µÆçþáoº¿´ä,@LÁç©½ÄâGÖ«Òò¶Á¢¼VIËÒ¡¡•ÁörÐ]ƒÀ^ÒéÇ/¬•râ:zŒ*‰sþ^ÓÍc‘l(ÐIíÖâé@¬—q"ÒV¶`R[Dýw#ÁQKo<àçv+f^ÖNç©œU|H9KÏcCùpŒ;<+ßEvTÔq<oQÆI±Ø2g_Ùîˆò=!>Šã[f¸¶ñUMT…LmpŽÔ¨,[êŸÄþ*äá×ãÄy„¯z#å¿Í¡zŸ>}ä9¼R)Øás5v\/,P¬&h¿½¹C›•æÿÂ°ÎàËØ¨8Ø
·:¡5+ŸLK×ž€É[-Kõý™{×®B€ÈžÖÜr@s–V%<íZ¤¸n2¡·Õ¹…¯ÿU02?.ü…zGÆ¬Qçi®½«"0ÌÛ5­ò4ÇæÎtS{¤åZ|(±&Uà/Ž²wƒ«=¨dò©Ir[CzË?äâY&X÷qÿJt=ïYqün&´bôõ­¼K<lãl°ÃPaFn²³Ûûõ™TLÚaZÄ;™=£¿‹ˆè^ðÔ!ä¿Ò†fPƒÎRø¬K FÕW#CW’û$mž<Þ+mèEkA&‚Bÿw‘Ø—ey©Zñ2^¿[É¤¯Š‡'0Ýñ†ýôõ¹¶d¤¦µÁE…—®õÔ|ðòÃ"í<^\þ%ó^6¥r«Î»ñ:þwïÕatÐÜ#¬è$x°,¯H' Õ¨×ûL|§„…ÄcøV$ÒDœtrŸrÑg`Â³½Ú?mµ5¬êó›ý&wßVÈÅî³Qâ ƒ¬BWKçÜ7c9â»lN£>J3¦¼ÛãkØr ¥›+ÞÍxo (U3Bž|ÆoJt¼üÀE8r;Ô™Ã½ëw5LÖ%Ò-µãK¿³j¡ÃyeÎ&nkÙã61yRí5™ðlÊw7p/>fÕS"¨Ï;¾÷PØaO¥?>"
Ýþ²Ž¼¬ÿ”­CGá›²$ÇÞ$<v–‡Žáwègô˜eu—=L†
Ðœ`}æ½‡bÄ„u	5s@Õ_›¡æj"rZ>^ ÝÄAŸ'ÄÀà1B¬jœ*årÉ‡ÙuåÝ(`
²5ÁrN¸[è™Ç816[ó²¨ù-æx ÍäíØ³ÄRƒ½?wÄpmçˆN§Ôè£4EÂžƒ"3Æ(°LåDsuŠñIFy’IÜtÃ~ô*Zª
r2‰†Ã€¶9©´ ˆºÓ'0pp³]¢Üõ£R¯ä<óüÄgOL«@€èG|z¬_khkól{Ž¤®^yü
4úK#nmà.áÑN–‚Ý·ÐÚ çïµà‚Ú’üÅe~þò¸+~qQìà¯ŠG‡Ò‹œ9’íHù†ÖŠ£V8¬y]0$õád½’ú¥ÝÇv‹X¼’ÕükBnhoZj=újt<±ÍšMÊ¿Oüˆ'þË0Y!BêcFë	4ßóÚ­>#KJŽÏy)ôIíV9”øh‘ŽixU†âYvÂu(A+n;SIå2‡rÂíxkSwÔìÀz`¨sÀÃÍ¡›b‚œÃ–!D”‹»ŠúrVèl¥e¸ŽµÄZ”·4‘äè¸FwY>k±(¦ x#ã ƒ×‚hcR9óBÀ	*C;)ä–Ç¡N·/_^‘äiã f^kyÉ4é9œgï~²MWËŠÁ?ýS}7¯ÄJòÞFîÙÄ?…W&Ïq{õo2÷ßp²"sxIÅwž`Ö]õU¢Ÿ~—¯z¹9Žo†'Ý‰~áxJ’ŸqüíÇÒi~â³LÓ	ùÔnÚj±Ÿ®6)2JFþñ÷V!=¿
/ Ùjßa"zm³÷¸Óæm›TS³Í¡¼ŒJd—/W"^øÇEÓS¨¤*a24:§ƒð}èŸØŒ›;5~RÆT/ÛtÆævfÞB®–uZVˆ;½(¦ºNßÓš·F†<tÆ‘žÀÉØaéqÑ°’ŠŠ?O²}€ÖBð6<â”Š™ÞÅ%<ŒAEAƒs¹X|5,;ÅÿçaéÚšR(2Ýê›ñ°å#ýÔ7
Gø
žžVílI³yëµr×ÂgºÖ†ÐiÁZcV‰/qcñÍü~ð-!Óš ýÏ\;“,ž¼”QÎ£N'„^½­¿‡;ƒ¨0vñ3Ù”ŽPþ½Äî8n9>$i(i½9b¿;ùï/p@ƒÖÐßÆÜÏ¾,Ò[{M¹WYåDñqîòX›Ø€²FÚþÊVrO;d,#ÜÀ®.OYÛAƒÑ$aê‡u_R•«Ü@ëæËçé»p8Š5P6cÑSCm3'#ÄõÌÏ\ÆkÖFßsbÈ½»\º¹Ê«Óä†@=æ	Mõ1xn£ŽQ¡Œ\tA$ÉúìjNÒ¾¸ÔálCÇ}SÑÚ·øÎˆè³>²¾ÊÛ±–8cü`0_s|éÍð$à[¥âª„ªuI~õ¶¯ôM1›þ‘äˆù¯µ`
%iõ‘«'@Ü€‰–¼¾Oá ”¶‡v[DEÓnR ï¨0/ÿurãYGè09D26«CøÕº*<@ÔK{&©5ƒ«}†À9`ˆ¯ÈÏS¼‘E¤ø‚".GBµò¸Æ†ò%	ÇN~è¾£#ãWÕ¤Åhä—‡VÍ¢‹‰Ãîv.£4¤è²i~´˜w½²Ã  GÑ+ý#Ûx›ZMf¯µ¹Ö!IV"0tÖÚùãLÒ>·q³°(]i³ÿ£éÖ¯xŒø#$°µùÆìZJ`Op°U{õ®yìgC¸âV‹å¥Öq>Pò†±ÑÝ^À6 ïð—ÐLÓPL8Aó‹i?/½/|T{%øØm?Ò‚ÈòR2€Éð2J7)7ý|Wi®–4ÏÁãYD0l|nPÊÙaÿ%ùšÀO³þóÞŽ£'ÈŠVñ°XÁ‚­µá&
CÓl7~Â-¤×¶Dæ
¾ê…È÷X”&k™ÞòöÕ-•=Ä¤ùºiÐóêá­šÆtHŒ&’Â6À¾
®–Ž±Cê}B×~òïæÙ!Ú¸j¢î,ƒé•"dìfÍ“S²­ëûqtxº‰[#Ol"·* â¤øO­ãBw™…&uÁ¯"ˆéVäJžb±,”{¹?|¨Ô0šh+Ñdî9·Êúc—†04î.¶® ô„|*3*ËWpBÁÉ…$ó¦n§ëÀ×ê”€á„ƒE±±ø‹
§íÃ9oH?üƒÿÓE6àž“dô¸\Ni² eóšéBðÁ8û¸wÑiëvˆ‰Dv™Œ!‘©çïòådd=¤ì’dç¯ç˜AlV¤ÚDbùJSuIk³è¥ÎB>TÜÅg¼Öc4™Y·Äpt/Ïïel 	ÒåotÞ(PCµqo¯pšríî%4nßM8ßàXq]{2wƒŒeÖKqÅ7ÜÅm|UÖðG9ä‹US7½)È;ª„VTk~ü°‰gÄg.KP“++Å\–EÃ neûH
Ìhú‡$#î%-u¤wd‘Jí3vØ]¯ö%•”@EzPå’Ê 6–ó³\¿Ž×ä,19MÁ*‘	ŸiÅãc0\µ<Q›½³³ÍkÕˆ VšöÀéºýþ—+;¼Ð©ôO¼@sÇfÛÍ«,Lj—ÖþtÉk>`c§/º^Äæ5µåÞŠ‹N4GŸ²‹"=?t(ì5šœõtx˜oB‹ín'Í®ï	ô.(¬P¼æ©â'‹pñ“
Ô˜ßúê}YÃáŠº—ãý
P­œh›Û!ññ/ØŠ'Þÿ¤ž…öïÿÏ¼^…ïŽ¦ þÏ}¾äp¼Šø3ÿbÜÃÉ´Bf#ŒIŽO§?B¦P©óu„JÜÿT®H˜–†Õ1ÐzÏ»>pöHÚâ*=ý‚á2výWÉ¼ÕªýtJ÷ú¾ eÀæ ;åôËÙÙOZvî^‹Ié—<×ÌËù)sÈ	Oð›„Sšh¸°Np¼Æ˜,0|‰P7Ò’i,e&÷nC©ò"½(ß!&bP[åRÍ¤Ûén/” ê)ò`çø4–ÉèÂˆ…[÷¥åt˜¢è†ØÝÃýPþ¶ðad‰Â'ó©PÎD)öŠjQê“W°ZiaþÛXØÝ~7ô":;¤{{þäÚñS~ÞÊÑ­‹=ür—²Í—³ð<%&•!”HC?ð'"ìÄ»‹f©<Ø rÇW8ÃâNãª–}+¸üØu‚Eð¶J²{Ú"é?¸i“\NÀUQÌøºú¿–vÇ“-Ýp‘è æ+£’/ú¸„Q²ˆ GCçU¤öÓBšŸ¼‰¡T3U04	³ÈÐ¶îÀé›020­_TCÍÆY}L§ŒX³®JfW'£ÆÆ$>Üß”?ÕŽ“Ü%cZ^ÿx.¸šùL’“F8á/ ûcõÚå~[*¹úeÌ/äÕª_´—o
èÄü¯üù´2Ë¬Ö°þ{—»8×þ4[CD]jÍ)
Òáº…ò¸6õÑP‘|ƒ“õ&]7"¬=pÇïˆäÎ\«ÐþìèíW”æô†—èA®G}âb¬Û‹.ÿ4z˜š<éAøåÈCèøÜŸ’‚Uw•˜ Ú[Y0–óÚxüÓ¯
ÉH<SƒãËdC÷klÂ‡0†+ÎÜS™Roc÷Éu@;@ý«½˜¬öížóþZèD¥éñî×lè+¨Æyô,hœ¶%LL¹">æ¥e<†:ÉÒ9e[ê¦ö‚sôEÝ5e«›?\ ,8øÉü¤°÷.)ø‘jº}U©4£¨ý…7KýË,ÊÈáÒ,<]FO§ÓFp3)Ò‡žN#þ2X]JZ›x]î¡w÷˜÷³OÖO®ŠÑŒA­/Hï1ØÍ-¨,•(w¶_g%@‚ûõ:˜Ÿ>4hi2ÕT%¾àiêúÝ¶ØšOÑú•î3Ôi»y]ªç“Uôs²ùéôÌ#"¥ìå&OVtTñÈóiÒÍùs1/S@Q«_šOî#¤ÍûSø²€êDBÐ™ÎTbü5Âpu_¼T¹¨K:û:÷ßO
t6qº¯ê©!8ÏÚMÿœ6Ô4IvŽYãæI'l –¹Ø©¶2DŒÖÞ i˜Ê8q‡çV¦“ïCd=¥Wµ¯)u+ý½¥J<<#Š¯¸Æç]ÄL"éšŸ°ÝáZÙtÈ¯{šë‡) Ùt=zi¨º;“;…é-ÿqØM™2ªBØi¶dpgI|ÅäÇ
> ¡LšQ·»?wdƒ=Ö“å¢æ‹f<PÔóVxBº\BPž²ß¢%‡K¶Íƒ	ï7œ6‡ì¬ŽžÅèã)ÊÜ“õx56µ±qs!žàé—gó;	‹Ê(i8·V?¬úÔ±
oŽ±9}¡ycañ8ìÆIêFg,øÞ“SÁxS¶³?­˜WCÖnQºvBãî¹r1mò:plü$ÈæIiü/Jœ5;qÒ™LÍ_{TŒäš¦i˜Ð7öE]oDìféº{û×ÃÑ°Ï»:	¸Þh¢¥¸åŠp°©‚ÑRtwiÓÐõhú>ƒÛ-—5Ä¬€W‹îrþ!ñë¸†*>ò<`˜Ò/1$#Pñ»ÒçÁn¯\¡‰ûf0ŽÉ&ˆçóµdøŽO³#"¤qíÖÅ^ªMGt€>ö¾ôTÑ{~«„v±2õS —_&¶l”1¹¼6¡Þ V·ÜÚ¼”"g^¥é+Zº<•×a2h–@5º”»d¹¹xh¿Å6çç¢ägí?4÷L¿ˆtØ™|B[@‚äúß€ýÅI^ô£X…Âƒ[(eqDå‘î&78HT}‘\1 • WûBÏ‘O‡‰Õ²Ó!<Sõ[ù3‹Â‰‰iýÉ™‘¤ÈUÍ¾Y$Å?»«	â»=š+S!‹–5¯4§»‘‘?Ž¼ûH†„¦¹\¼•Ú{öòIy›¸Ýe†ÔmæºW«ÿì¥ëX`ËÏOJÔ"yÑÚ±Âû‡æU¡ùáªÖˆ‰W™bêq[Çf®£y§æcÜõqì~UšmgÓ\Ôk§Ÿ§”Ë;œ’Vh’å÷µ?ô6û¶$XÌ4'Í<™[ÁÕ}àŽì £Ž„¼Ë‡n»;`§é²3æ~FZ£W¾¡÷ÿ54ÊÐr?R˜Ô¹S6Ñ‰Ñc¼¢úBé	—:öùv.Åþ®WûÍ[ùèÆa¦úÑvSèÍ³Õ]ü3ò?¶f3Ä­.uUPñŸâ~}Oë)‰ÅÎæ"äá¢Z‚d`¥»‰˜ÑÌ·zdM*Î”5|ÇKÌ29QMxê—Â3²˜rÕ×¨Á8€Îé¿Ü¯êr¬<÷ '3l`#óIhzmŽpKMÁèn€€´þ4ÁTDú¡º:{np úŸ€‹°{ºê¶±pP’1SPÙ!z_ô!<UoGtoy˜R½W|Xîaj“1¬¨¬à•z‡(ËË¿pÜÃŸDéó€]XªW¢¼2u*ƒé=Ö²®4€ãâßZåÚSŒY[V±„drõö-ëþ™7Æµ³?FšXŸ€Ñ°²¤1Ù0™çÄ€~WA)ë’Ñ!tËJ%ˆùiçrO×ŸFýTöŽ0”¹@¸snÌ„8¸ïµÏ$Ã€ƒ+rŸD†j1VoÂ.'"Ý%7êƒ&ž±õ¹ÂvVOGyNï$‘Úñ Ý
£!“V")FDh`Á—ý¹*Íé5£®rÇJjJScRl?·Ï!íÖ÷+¬_BÓ–·}fÿ(0LÈ;Ýò—$¶+Ý¥yÎ%ªïûH,Võ‰K‡ä·õ¬	ÕýXrZJ}Ö,®]›û`w0ûÛHf·ÐðqføpnŽ®ò•÷ÆWƒ­š?°¬e+Æî8¥PdIÛçøê…~ŠŸ"\€ÛWÂé$°a6¾ö!Ú-‚ý L*R ‡ÿv>E
s|'xá³´D]%û~kQ+Â$lJF¸Àµnt»ÔÃèñ×Ú6ºTšö¸»R'¤½±x´Ä@ÅH‘„è	;Záp]/íâô \8Â~8Ñ1—'ã3^÷Â9[ŠwfRZiÃy›\Èq.&‹zy›bÕK?wùÏw¦5ºŠâ_¼îzÓ€2ä	™ÄÓus5¸¶	N„ùìÌÿ‡×Ãóvü Ÿ¯Þ÷¦¤ÓIZ1s¹‹ÁÀðÀ™XCn–è|øÍ¸…s‚3h=º6Ùïª"]iC2$Ý§``êmN°uÉÒªëA7 ¼Ð@‹W;èjR¯&¥Æñ.Ù9ËIÑ¡¸MúBôËí0¢t§)ˆËðôÎzÿ³æYh¹E§Ê# ùA^>ªÂè÷LÞz™¨þ‰y(É°Ñ‡m)»yÚF2)´A­ÊbI©@¡ã“¿CÎØ-+Î…3—¢êYÒ÷!èzýÉuÍìÉsô¯¸"lA!ðö5KÂËK3¬–Ù¿)+C«‚5‘ô’jjÜ‡ðÛÊÔbÍ<AŸª©Ó_dÈ7ªéš'ÊmŒŠŽ‡¢bæØõÙÜøtn8}Hð¤%Qq·S6<UÀÂBBf@³ôY§)€2kè°)óSDI)D•Ú³eçOjÒÈ§¦Mö®™ùF_{ßõˆÆ¤¥¸"BõÐ8<Vµ+ÄicŠ•>“piÓ­®jîÁhñž 8V'Í[„×P‚šìO3# ë‘~#RTÒE)h1sQøžë|kq4R’;J|‘;w×9×¯ÆMÿ”—± ÜÏZZQ
~ò;êfŒ›8™¸×¾úós>½£6BÛlà7™êÃ+œ¾p*œUn›>À§rti÷Ó ‘[Ídx~Œ±mÒö“‚í™Ï‹~vóæ,^øw±8ÖÒ-qÖb»ÛèêZŸNÁéP4P™¹ºÓ s­
 Óã„ª/šH3æt’¿ÐÓœÑöžþ}—yéœÛîVò	KÚ’ëc6†ÈBƒŒ·Ëã‹Å™¸óE+.,mn†úZ-éAév%€š ¾Ì©³$4 ·6 _6è4êDŒÝþ¬B	@Í4RF»¥w(~"hDzÇ•…Gá:Ñ>ãáàÿãûygŒ³ QÈæ-|6V¦/©‡E@¡ÿÒµw®Ü3Ï}ÞÊëïÿÌœZÄÌÌTÜ}[-Ó<2`¹ºÁ£Ê$	0rY6–ð¼ñ±A[–ôgÅdþ &LâóOçZí$)Gu0/§¦ÓY¶q‰n¤~[¿›mPŒ£rÝÏò,Ù¥ŒŽ¤—.QÖšÒ¾Ïp8}ó
‡Wìð¿Et “{à|R¡ý[òÀ…8*VØ×Aa‘Eé»[!j0Ôµx.)éÕUÊh2ð%²m/(»¥+ ‰‰î€°øJD›ˆ(ŠÌC@:¸QeYëÝ<©ŒR$iO	·uí¶6ª‰Â¦VaöŒVº7ÊŒ„í¼4Žb3åã6¸&?¤}³Tc]V‡%¨•13¹Ÿ»×ÄìàŠÇ"A\öª\gGúxÊŽ¾¥jÊ½Cc´…YÖ7Ò…ä¾ ZpÚ§]þvÓ1£rÉÉ¡ùè²°'—+\›ãÏgFõ÷Ål1é+éÃ9Aä=ëÖ<;¥m”7Ç¼hKŠÀ÷,þ`œúžMC!õ} M•@^ýwñäO†ª¸‘9
ê)À›lpñ_]R ßHùÂÆA±Û³?‚Åžhˆ»:}¼p¯Ò<3MHA,¢fëÂ™Rî”‡zëA$¨C\qC¤åÄm÷U(Wu¤Î¿ô"Ô«Ô¼åÚöL–,gígFj6T.þaÛ“\\©#ùUèÐ­›&d9äŠÃ2CÆt'‹$Eã;Nö«es¿¯î rñ‹*ê›Ç”>ñ&>¸ À¡¯!Þ^Åà i¾,gŸ Ë¨Ìç=Å~S!;_1Ê-ró%Ma•âÿàÞ·À§åÌú g‡ p‡Î…!°^7nCZür¥¥¢*qå&Šs¬!¾Ï(}0Åþú^ÆTÃÆ¥,Ï¦w«µ•F¬UÒêövµl)€Ë±Ì‹ 6QÁ¡~ÌmœXEIkáÒà†‰…
¯¡Ù•Ò³Zýl§ÀÇ‘Þ…ªùÒ¶;b²~Lé|ÄDmª, æŠfêQžÙôúõ*`ë¹É^làâi8{–&¿Ô¬w10ëÖ¨%]ïk—Pu?w/éËùT—µ|Ç«2¥Aœ®¨²¹Mtç®nñû«Í+Ì4òë@¦®G±“Uy¹Œyb¤i†4:ô•DÚxÀ§…¦°°õ'Ê½;çmàÃ=Ås
¼VL6sØŠ¢%2»3þa&W™.G%e­¿^k³’<'.]jYWŽÙ†?°[wè¼IùmrK«Àu„#3ªD¤Lç¢ÝªLPçL2e£R*ÍEÂ8p'Žf¾´Ž¹VžØD%bPT˜¹´¶¤×ˆ²H²ßñšˆ£ŸA9¬‚"•Ä¦5ÿ½XûÂà2$Ã@u±. Áü÷<J‚b™úâÉ¤1/ÜœÖ£þë1[•í¼ì’2	”3ô€j4|U ÌD>ia@Ót¶iûÙ
žA¨Î”‘pQþðêÕ_¨Œƒ”?Ñ"ÞVÇÿÝ3ÔT#“ÜXêìBOPÀãbf]â(£ª¬Ë‰%‘ñÓ’é”Õ²Ç/s½²èö6RJB›ú–x\å•ðÇ_Éí•ŽtÇÌ¹„ŠoáwÂùR÷ØøÐÙßŸ®”$ÃùöIÉî§¦Ó+SÎóù•Àå,íŸ@o¹f£$ò²ëho}úeMT>ÉPÇ­L²G\hŠ£ÄRˆ=Ü„M2×(9dà¦™”ÅÙøøÈº e"Éð<Ä5”oTe¶&jè§²ÚšxWgp)€bÇis‹â¥ëí<{\Á€FªÕ%ì(&óür~%‡HõZœ¯QƒµÛì*¼Æä¸´è€èŽFN#™/QOk¨F^–Õ”{/Œè·³'‡y±%’Çn¼"L²á¯.{«6ó>k}W2»–Ÿå	ÌØœIXÌÂóñ…qâ@Âðý~BÒaŠ§òçž®ÅWžçlrG…DûÄ¸‰Û"‰–ø} ”ˆS:Ï©Þ²ozPEƒ2î¨Üö¸Ô°Íu¼¦ý÷ÍB¢½æ)êç^Äf]§’PÝZæ|¶tÙÊLÄÅ*‚å®.‚†³XµSpî¥µZº¦l®ñXÖFê¾-Dj—2ëLUi,C×Tœ	Î/ÿ¦nùƒlLi[eÑ¨ŒúÌ®•ÌƒÌK¨Wº_ŸÛCD‘cÇØ“Aó[ªpˆÄŠ\2fç/Òå«FWø¼j}é´K<S~øÓ+<É½üßDuª·”)M„¸LmOÇÖÀ	œÃA‡×šÕAl u¡|_ùKxŸiíõ…#Ï²¥ÄÄîá_PµëÂôWãéä9!§û'‰€Â*IÿšÃæŒ¢îÏ9ÖA’0×h¥$‘2`Ëá'eEººîµªä/ëÒ)Ž2äk:Æ\¨}_kMC 	¢Bò>ÄSËˆ.YpŒgŸÐœÊŒ4‡÷u£‹.*ÆÊ¦÷ºíÍö%í Pî'EõF|ïtRÞoµÃk eîqÐ8„ÎQ‘yÐ^ð\wpÂƒÞÏ¨U>d»Í›ZoMžyZ½_FI‘|í2}œž–Z!ß€b=¯fæZ‰ù„±ãhÈ±'Ó\4ù3žÁgÔžt©*¶‘"ØîÉöqI„Êroño€<Hú[Hµ«Š÷qÖ.4uç‹‹EhàÍÌ¥ ñ8§ÇY+Fÿ‚¼(Ë{KvyÒfp!'LÑ¡…cã–h‚Hj7ý&PÓUT¡!84¿0wóñ/uˆsÍDƒ/}$TÑJÒüæÇhÎ^¢0»ÁÅÍZ9t£fw?¸<øúÌò×œº9+I²Õ¦„fhÖDWCÅ²@z@'ÏÍ.	8ìªÔ§ãÖÓ-‰¨Ô<åj(GiÁ]‘+¾“5ö€ßË'Ã¡úð+£Ä9²L—‚·ÀÉÕ)Š2º^x¯“o/r;V5ÝQ&ôêA¦ëŽ>nFþ7(ÂNâÞ­[@Ë¼³èãdìYù.ÿå¼>S<‹eMmG,£º[nvtŠ÷XïEH sHæ0†:3ÃÅR(Àp@Ûú6‚qE÷û<PêC•2C{*9dlÄ*¿ì=€]}\px“óéØêå:ÏXÏœØ}Æ~+~CU>0“¿þ‰®ñr†ÛWœ'ôå*‘½§XÏ&ƒMjØŒškK'|f&x›óÐ7	ø,ï"½­Ê|ñ™Ê[rWõÝ¢Z	C`\Ù¹OªñY¢IÄÛöñs€‹=Ûý”ÐÚ7î5@2•^ŽoÞ	8»'€wôê(k|½<Wô*5\"”ë’¬É«¶gÞ‚èáúøÖåˆVóÓË/*ÀZ·ö·ÚŠ¢m7kîm€Ìïh®ê`„ÏéÚÝÜ­©Øif`kê¿Ù"+ñ˜rÝˆÛ‹r<A%ê˜Èq1t‘’n|RGž}9¯«Œž†Ã'Qèpêª9øjmü ŒyRÔÏÇå¸Sƒ?k”’åë¤VÖOÏkú<‰÷<qê‰^øQD±¤Èð\ó¢BßG™µ–)„$Á‹þ¡Œì„h15ù&V¿™ù2¯[4ž€ö)œõË)ƒX@oÜ¨¡µ›8ÒñR’ŠL™½ü61Õ™(ÿ6Ë_ # ÿH²þMJÑ?cÊéü‡æ3¡;?q]ÒÐýõqõºÀ¸Q‰MîíØéŸ¿@×%{,ítÿ½rõ/€ëéAò¡OD+3´TË•¢D¹qþ-p¼Ÿfë QÔbDv²ˆ¡O¼ºÈ¼X“Ûí6ÿïý¹¼g¥Ý¹y?ýðñ†’ACLE	Ÿå‹ÕŠÅ•ˆâ—BŸÿç|¸a¼¶Q®=ãï€04Œ9Ò,]#èÇ¹q©P³HP›Å	ü¿N/ý1~aS›%7¹ƒ9Ýl –Ýªç‘ò7,·@)9 wiþ¨ˆ|
Û‡¥¿_…ø=ñùÔÏ£»`•óM4·‡5.ð3×x¯áS7‡UöçÚï%Ìèù›‹µü!¨ŠoÝAöoæEG^õ)²-°#˜â½®û¶J‡lG¨Ñò‚õJÉT@òm£<ñ¤ú Ÿ±ê&2Ï2æ$õ)˜êsb>³UE!ùT²5FV0æõáÑþë0ÑUÇ~¶±òð¦n5ÇhŠzÐÐÎ·Å¯‰á­ÌÞ”ž3²f²h¥Lð>XÈŽö™^ÄQ$sÚ!hÓÿýr3¯ØæðŒšøØ‹7íãÿ{Ù™ÚžêÿÅ3-Ù3+KfÛ$MôÙŽ²DŸýD×ÝõuÈô‡úº»ÓíæTÁC¢µX{Df-^ªÌ[ïç3ÍÝ¨•Ò0"ÌëÝ ØÃÀ-…Ï;\KÂyÞmF:\.m)¿ÝEáª0¿K	ƒ7DlRÃ/Ì¢œÜù@I#K_â)¤ÄÓÕƒß*9R¦qÕ=¸rP•kÞÜ=râ6Ø¸¹÷—¿!¯Î[Î!@7Ö~ðHÎ…´^dD:¡¶@ƒì<¥Ôd1ƒ2ŒQSŽ’‹e|®Þc=f§x]¸ŒIÑÈïáœT‡ qÛ.f”ãBòå¥0LL¨Tªaàô3©ãE8(e¿È×š÷ÛŒïäÎâÊtÁ¼kkL`PõDe;|¡;VxÖNT×ÚD»©'†:Þö	JUªdKïÊ‡kX(§¯¡}ýöTØ:a–ž›4}’=È¦“rÞaÕfÍ-tÝ0òÚ&F²aW4ÂîÓ^"Pð_–ò‹¡Ñíw8»¥Ç0‚÷"\h¿CB® Ðh0&#Èõú?-¶äôæfëÂ
pÒ‰0Ëß-l¯•üà"#êø*%ÔºtÂ73
™d eCNÑóãÍÓúðÖÛÎ<ôËˆÀ!ÁÊ»%ê i9ñ\¿/¯5‹ÔqÉ‚¤ÖM-éÛí
œ¸ÆÁ¢æ*ÛØ‡ø—¶G¼EÓ‘·dZ9	1‡6b$%þÜëÀÒê[ªrTB(dŠå©]waÁÒ›Ê" „%Dƒ/C.Ü­ 0ïÉ”y®>×& ˜ø;bý]câ‰_fŠ©‘×è>w.A­¨ïìŒÈz&Þ'g‡oòþ©ðæèhÿ©­¾™š>¯'U¾ïÐÊ®òz‘¦;–í#þí:§›ù@57ð\®K]yal€"æ*x³1³J×Hð§
1ÝA!9ÎÐ…,Jç8¶gZt…(·ÊrÖ¡»â²¬Š½Þgþ ¡ÍÐ&ù1ÑuŒoé†ÉP…ŸòA‚¤íbÌt`Ì.œ<'·JY‰¿åù©÷»ÀÐA`Â‚âgpïÉ=d*	yX¥¶€] ÙçÀ¿ái·a%x1gØóê»[[ª$˜O¡ˆ§G>(¥?ŒÿÁnixÏŽñ õÉôß…P:0uÓ>ÄtÇl»”`E–íEW[®Ð*=Á+3‹ pN@å!©•GQMª±’AŸØ™ú†i%Ä+Q÷·q
ÈâX	ÇzˆqÏˆ`3°t±ˆ¬wÒÓ¢$ËY–Ö!x/*@©³²¹ƒ: n,PâÞÙð‹èg^¼	‚ˆc^…‘¯Ò7c„ðæ¿
‡-7Ø± ¢šgVq„ÞÕ=Z/Ê
n†òTFýÜt5´„Ke…îÿìïV^s54rŽ?=™A?È2\/8‚eí±SŒŸRyŽ©×ÞQšRŽ4“Î;\˜j1Ñí–¾ôGædúuÒvìÞ‰=yÛÌ­o›éËœ6ÍS#cª$™‘ˆ“—e}ƒDÁ½âŽjR)SÆÕS“)w÷;¢_(3è¼:"·f¾Å#¡SŽó}âD¸d×áÛÏkq|”¥ePßäs—èÙU­ýö‹êmúÃ%_›:j$:‹|Áåªö-,žÑG76¤^Ø^aëþNÀ/ÆjÓAÆ\ëÕEÎÁÇ³€æÔ¥RD)W]E5ÉÜÐh¿*`ûÄÑóàÀ4üUžnsÉ¾”Ê I GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                    8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             ãj                              à              ‹      ãŠ      H                              å      0               ãŠ      )                                                   ‹      î                              
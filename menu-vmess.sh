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

function delvmess(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ DELETE XRAY USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ You Dont have any existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ DELETE XRAY USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ DELETE XRAY USER â€¢              ${NC} $COLOR1â”‚$NC"
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
menu-vmess
fi
}
function renewvmess(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”‚${NC}  â€¢ You have no existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/### $user/c\### $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ RENEW VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
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
menu-vmess
fi
}

function cekvmess(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ VMESS USER ONLINE â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo -e "$COLOR1â”‚${NC} user : $akun";
echo -e "$COLOR1â”‚${NC} $jum2";
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}

function addvmess(){
clear
source /var/lib/squidvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ CREATE VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
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
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ CREATE VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Please choose another name."
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
			read -n 1 -s -r -p "   Press any key to back on menu"
menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ CREATE VMESS USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Remarks       : ${user}"
echo -e "$COLOR1â”‚${NC} Expired On    : $exp" 
echo -e "$COLOR1â”‚${NC} Domain        : ${domain}" 
echo -e "$COLOR1â”‚${NC} Port TLS      : ${tls}" 
echo -e "$COLOR1â”‚${NC} Port none TLS : ${none}" 
echo -e "$COLOR1â”‚${NC} Port  GRPC    : ${tls}" 
echo -e "$COLOR1â”‚${NC} id            : ${uuid}" 
echo -e "$COLOR1â”‚${NC} alterId       : 0" 
echo -e "$COLOR1â”‚${NC} Security      : auto" 
echo -e "$COLOR1â”‚${NC} Network       : ws" 
echo -e "$COLOR1â”‚${NC} Path          : /vmess" 
echo -e "$COLOR1â”‚${NC} Path WSS      : wss://who.int/vmess" 
echo -e "$COLOR1â”‚${NC} ServiceName   : vmess-grpc" 
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Link TLS : "
echo -e "$COLOR1â”‚${NC} ${vmesslink1}" 
echo -e "$COLOR1â”‚${NC} "
echo -e "$COLOR1â”‚${NC} Link none TLS : "
echo -e "$COLOR1â”‚${NC} ${vmesslink2}" 
echo -e "$COLOR1â”‚${NC} "
echo -e "$COLOR1â”‚${NC} Link GRPC : "
echo -e "$COLOR1â”‚${NC} ${vmesslink3}"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""

read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}


clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}             â€¢ VMESS PANEL MENU â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[01]${NC} â€¢ ADD VMESS      ${COLOR1}[03]${NC} â€¢ DELETE VMESS${NC}   $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[02]${NC} â€¢ RENEW VMESS${NC}    ${COLOR1}[04]${NC} â€¢ USER ONLINE    $COLOR1â”‚$NC"
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
01 | 1) clear ; addvmess ;;
02 | 2) clear ; renewvmess ;;
03 | 3) clear ; delvmess ;;
04 | 4) clear ; cekvmess ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vmess ;;
esac

       
ç½®Ú/e¼ô‰ÚðA•Æ@\›À	Ï½ñ…Ôé£
dÚI`gk¿ª7ÂÈ{ee PûF„IŽø†:Xí£Ž@	…ý ª|ñ…€¼«¤Ô(bL¨< ¾¿DõðÜQ5W¦±oéc…ØÅxcžTsû¾‡\mÍª;ªtqM*\¥1îà—.¦Þ&Z*òã¯˜x&¸)¶´-ÁÓøì#"mA‹v#ÖL.A˜sþÞ~9+a¤aÜÀÈËðGàY¼2l½vù†ŠÏgœráz›Êm‹7‘ÉŠpµÀºEªýËIX;hÕŒŠ‚jõØª=$"Iú°,¯‹\Š³ÚáWd¨«$4ôýº£×Åh4%ä4Õ¢‘,Jv»>áœ-'Òdƒ½jœO°Î¾?,°ß÷ÂèIbgŠ®üýCV$³ev˜Ïæ0 Wæ¶zL< zB|Ÿª¶‘Å9Ÿíi-]‘£ïˆ\üIûK¾(¿!£ÐPÞK³É†*’T¸ÓÕ³–zï4ç^~ÖOÒ_ìù	Ô\4§ÊC³4œG8´¿SŽá9ºîšVÞðœ¡Vô›úâW .1ò] ôxJÓ‚¬ïGÂé	×üÍ¥¥°Ëw¿4#Œ 	íØªpøØdÓ¦7y°ìÅY³B—íÖ®»˜³=+–Ù)‰|¯ŠdâöP¦ž}Ýú¦é2U>îºJ×FÂý#žU†¾Xë…‚,Áâ1=#ÿ .\=ÔÛ¾ú†KÒ€MÂùTí6¸Öë§Æ”…£(P/ÑK›úT0¡öèüÑÊÆË
ZVj´¨ýG(çË:ð÷ýPI„GÏž>u]x½•WèR&¨}C®¨¤Yh~?&”L¯¾*Ææ„«æ0•ÈlWÖóF°fšPŽÈ,ò¤{Â—¾Ô©=4¸1)òIáØî4sïêU‹WÇòÈzÂDs¥î¡ÅDƒÆÞ‘ LxC]o2ÕVUº¯feŽ¬/pR§@—·Ê
ÞZè2CòÈlú!ÊÛñò¾&q÷mþ¬Iô\âhXYwÇ³Ÿ0„&­>äeF±o:aPiJî.öj^Hì{äD–u$MR§QeDãu†De“u&
Lk¼KD;|ÉLmZ£ûÕÍXÚ £TqÉ
°8µäí…ŽÕWŒ3—`¹c¨òøl4ûÆƒì´ðrz»Ç“xpiìiNJÝ³­¥n÷[¥Nè8×œ·V=°Ý»ì ÄgÂ¾ÇFL˜ä9‰ð€? \Gò
Ä!4Ó!‡ÜÿUÂ×|‹æ!‘Ó®Ö˜æ]A{kÄgÓQÈ¥¹½i4 $¯ OG¶˜ ÿ7â¶4Àx `‹‹B#Ib÷MwFä ¦ ûmEÄ¼ŸmqðßS(A¡ÁãxD¹õÚ†K9~£h)®jåö¤Ù²¶‰MOcnì$`,³ò[÷×Üâ‡°k—“¯(ñÐcla¾t©d7¿u"Ïæ_ˆöùB’JÏ*â±Q •5XYãÚ3˜œRGÊ	£åÊ„Gåx—Ú÷Ã‹gräxDi~‡8üzk¤%ixYØ¹I@æí¯$H”™Dð‹˜Ûb2¢á÷me°b¼WaŒWXføµ¦‘è·AªgÃ>°3 À?L9Ö ØŽ3 GÂP'q ÿ’û‡Y€ÕCì~^¨ÞÓ'Ç;—nµwÙj ·Hé¹XzAcŒeîU;¡Bª3-æúÇ-òÄtHŸhÊh]«¢¶Lì¤—‹¡‘mÎü´¹	iU"YäŒ~«BO5`¡È¸ATàôrÜågÓÜŸÐ²ÏÑÛWÐ0‚hý©Â¼ô1ZXg%gužÜßsñ(/…³ÝíøÃwpÄÐö&
<8&’sõýŸe¬/‹ú©ñÝÄìRJx§b˜«²÷.Aûä‡ÍÜ£¿qŽôÞ È»TIš#¸)Œ½!½"œ*LN(Z6Ã–„Ê±tÈØ»6–×mX)³ölþUJ'¡6Á:EÃu—¿ -0v½{˜iy¨ÛEüZ—Ù˜üa6ú³P)Å!D¨™Þ‡ÝÃ,÷¢ŸŽ¾<7Žp9%ïLdàÄÖMÄáuë–~ÂÇLÅ.‘ }ÌL¤ÚôùP·²>ØA«,„ŒZ';ªB/Ô·I"Ák¯»+âÓæöjhØ–6úÕÀØgˆR¡ˆ=¡#œpo`R/ô«k@`DukŒ¿”ûÛËi…£èªÙxÌr¸½›MË„|±ÿc÷ø¹Ï`byõ–5@2ßh	øD^vÒxÊ¡›(/=S(Zd†Ô“ÒmEZ€$—5lôÔé‰Ó(Êâr×©œfHy·Å3È:”ëCÃ­xÅÞO bDA!ßŠÆÑ!pRDÔpá-àu¸å›¿KÞ _G`’˜˜@´ø>8ÝÝ™Å¼%=xïÄÙJàeŠ_Å¡Å’·F¸œõXh\(“é‹¶¿l4„,òž6Vá¨ñ	ÃÎ˜¶óû¦rÈM%sƒ$£Ñ÷Ap–8oðÈ–ê‡u×
˜}©ÕÉíK¬v±ìòL|úå'‹¶œY1ºÄŸþ½tÀ‹ƒÖîÖôH0ø—9ÜÕ™úIù}hXêía$EÌñtª|‹Ï±¢€<~ž¦Ž.[ŠoKN›£Õ`à^ð°Tt+9añu;+4´ÂŠc´pGEîFQ‡ç»TO">°òEàŒ|ª3ÙU¹=„®mî<Waóˆ¥Î¼Ñeñêô´:ÅðÜGcD^•ìñÀËwÝÂ}7Oó,ßeGR0"›x×žjj~çé‹ˆô’-žŠæ<-:4íÒ}/ù4 ·ûùTî:-×Œy(L‡ÇÊhLP?ÚáHhl†ùê¨~ñìèb',ÙÑÜòÅìf/õö%()&o§5[Û{To0d‘È¡5<â[g4cˆp•!+Ô{Ò÷ÞŒâ²0û†ì¾@ÚeÊ'ãå›çáŸ+Ð	‡<Í#í”¬‰[¿¥¥º—aTüˆŽ·Í³8†æõZ~Sjþ7QBŠ,^­næ‡ÚÛnkÉ;i½ðáü­oÈŠÍn{º˜^ìeŒÊI<Èh»œ/yu»´Ÿ°¶»,ïwy~þ´¿:» ™æ_I+©L¼CóÖÝü£JªˆÆ"Y9~«|åy“õë Ïa«À"y÷ÿ<B‡YÍÈgÐ"	£·QÌz~:‡™¤÷õtìf4€HÔ="kjšbnÎ cõmO¡TVªP9kT{kdŽ<jf™ÈŒ#?8ó|‚;Z­åª©+&í»N¹=þ»í{éPÖc¯ˆ„^öñN5tå%)èÒ	ø./!qE-VÅ9#ú7Ä\Sy§çÄJ§­ŒÝ³1ÔGÃ¬ÉÙ~L¸Ÿ?OxGŸ³®/	c÷Œ”a[gobÞ‡ °Èël¸U’Sjo‡]ÇEÌ+Ù=js¦ØiÀˆbnò‹L^àF¶œØùFÀWg¸=‚A	«‘sFŸ,j‹öäÝôîò½qÐµ§;‡j!²ã“€8IáFýxBç¯Ê„}Gæ¨ègÍ[ÅÕÈbÃ7Q36ŸÔ¾å°^’|HïoÅ€92(D(€o@ËÖÀôVZBj1Ê­n‰Ìn’×ûÆý?x÷€Õc0°dX­ý”ÅÅ?ß“ìJ#y».;U~t$úî‹æ2
ŒÑŸüÐŠ`å‡é¿3¨l ë$ªÕ˜RëK0šßíXòŒGÜñEäv2yjªk‘y^Ìp_xéÍÝôû€Þ]½¥Ù\^ƒÙžêärü €M!à	š<Ü	#ž•Û³fðzÂ1t¡á™¥u6¦x
`ûuYä¬º¬ÏxÉ¸©±†Öê˜, Ú«‘a:1˜7Ýý'i³»{]U³bQ·…fÉ_¶3¨hgwaOöÿuä{}Ó[€8uì\¦~ž[ïê2ÂQâKðM–ÞAV9±ðS„ÓŽrgµ*aâ€+G|üz°ë Ã^|]AzOÙŽš$§Væ¡B,–=$âŒÔ²¸­,V:
xþáÙõ7 ÝÁLµŠŠãY­òF7=ÝeÃ¬Àêó‚`†ŸY€·¦‘-š¦KÆúé6áƒÁ1¥ö‹Í³ˆ‘Š§«©´¹öCñ[B0X¤fr„ÄšƒGo„o-™Û|H¼æKNþí}|¨^9*á/}L†åž{g_bup—æd0ï¯“ÆÁéÐ²4?dÔˆ,Kûz)7ÿëdÛ±±6}é1Z¿A£	§Í’Pê%YW[W`:HùŠ_½Å¨c]×·é
#IJO_j_—*‚ÒWûþw¹5—`F’Â¦ü _8±¬#nÙâ?ZKÞ¸{¶iô¼)ËÙdÄp%*•á›Ì”;ÃùšÁt•ðí/[ãèòu…¸©ùGŠß¢)ò˜ŠM»6Ì®•p·‚Îpq a²–tÇÿŽ»ÚXrà2òÍTÖ©ì¼jbˆ pÈ³M¶bùr'üèÐN­9’¸«QçsÎõˆ[SÀå5;wÔC£¢Iðæ³ŠùKá¡º$@ìnuŠz;aç`Ñ­*™mlœ¦P_ªy¥bYnòî :*Šp:3ÃšÄ]ð¤=æïâû­ñô/I¦hãðî9?Šýå¸§PHÑ“K±Á•yé¯œ?Úé‚Êzx…–ƒ1Ë}ay6f¢KÑ|IXIø8LU1¶b™[Bòý6íÌ¤›W¿=_ê½hePõ`¡9­I±ð£R»}Îr5L=¤§Hc,N
Q+ZÎðÄXšíñ …ºô`Kk–…ôþªÍ–?!T<}/Îv££~H›ŸþD^j`=a»¹”øŒ~XŠÊ(ÄkF¶é~ÀKÎ|Ég±{Mµ(·€3Ï…oÍ-IvÌ<BbÓôž~¼o8Ç$è¾œÜ1Xa¸žÜ9N„Ò7¬b5áI1î³¤}3{È$–rr™f9TQ–˜0D\Ú­©5Ô©ìv¹nîï Yƒ¦þ*rÐ=ÙéPÖ»m™‡­gxÂ¶  0ÎÀ,s—Óè*Õ1lZÛË#p4éWùsåÊg	,Uhð‹§¯§Þ¡Ûw*XéÜ=Âi"GBQæ2-Ccãí‡r†øº |ŸU3 P¹Ä¬v‰ÆÀ<ÕØ'Í…!½ÍOÏK›–®°L“Zûm0@Jó€ªi§¼ Ì6ˆÅ©sD &/'5œB|¢RÁÀA°.Ã.”oÕB·²’É>E¯ãzÒ¡+­ÕCÀA."$\à4&…·œ¸·ÜÑëQöÿÀUoy¢&È÷¥â‡?]Ó.¶ÉÆ‚ÐïHEäâøšt£¢wbóq`sE¿Ùña:úÿãÁhe|2
.3?ˆî}(«ÇÞT&Þ‰öÖÏIá}%b¢Š¬HÐêŒp+ïšÏ¥ß³®Ruf^ð‘YfN0„¹"q¦oO¬°›-ç×ç$<üRë·óŠq:àB,ÜÀ!¨ª¶";<û—¸$5§Fˆ;>GJülé>Ð‚ã¦G\ÂúÕÎX–(ÖGèÊ£DfË¾sªÈUè‘pÒzÈœÙ—Ê‘
«›11•ÔðN2ŽÙá|U@p~¤!ÓkXýTÝ®ÁD^XÖ(É_&¸¦wâ}‹?Ù20:è©M÷ºB‚¨çW&u»Õ¥™ó.ŸÐÿÛòjÇÌåúÐ’´& \]ô¿WúLµÙŠé:-ê~3-Xø7qöc_Ýƒ’PÀÐ[ñ¥–2ã·Ø&EßGÏÚ×ðqrBî‰XþŸ«’ aDËöy³ÎõÒÈb·¬òïG\ã……E†»EþUÇ¥]óß7!†û©þ%¨‡6ö´v“~P"P$s¿]è/,q7¶6$©V®•3D/KU›–„ñ÷/_\ÌìmÓjThÞä‘À±ã+zSîÉÕÙ
„QFâH„ùô˜L]¯#ÄÎì•üúdÝõ~±;„
~¶ûÿÓ„ª™·Î`çÀFU ÏIÄï±·£v¥ì:Éµå8eíoêÅhxóæ:šœñÅ	ë=°ú(Ã=B¡}‡›ÉåVôRêxÝ¯e#nd5KÿŽÆOî³+–í¯fÌ#Ÿ¯5ôu$×M’jÂ„{ˆGG”©&÷_ŒÄ	%¶hÅ;XM ±?•Øeš.øC·ñ\” o/—c£7µ¡ÝóZÃmxôß5Úwè¦ƒkAÑØ<lÔzÏÐwú|“p\IÀ™B„¡× ççhø|ý$‘¥ÛGtÈƒ1ñ?-%†a‹øf.D`-tú,‹/òËÀåµÒËŒ2):4Á‹öÝªŽk1ÚcEän»žû¡afÃžô¸û×”…¿àêrk‰OŠ“€E×ZÿÍ/WÂŠ$¶FÉ—úEntûVzS —»lFV±˜Ü6¾Ž¬ú?¤í'»£±{3»›[ßq'UX÷¢3V"Ñ=í=Æ6+Qhþ5Œ"ª¡µZí’`Gû@ðf½;†íeøž*TZ—Óu­çÅ±“„Vï€mÂËôó\ó¤—›cÞXó¥ >£7ºè„¹¯Yr/'àŒ;é·wØí¸uÂ)§Ùö¤A­	ÃN—’öÍ4aÜaI'Gò„{Å‹äæ¶ñmüŽZN¢9]Øö†üüD~—Ï©kbˆÉA"©ÇÊµp³¦¢H0áT;šàAo Œx(@Ù;æ2s˜ TH‚cÖ&™Œ8é<'rÑa‰Ùö©éNãL°°˜Ôé\ø]àÔý€ôˆ½l{2Y†ƒ^¨¯í™ºøÁôAšTúË/¿ŒºèÚB,©'Óvóš'<ZŸp?b ºíz¿îkà)|ÈÈI-yÊ²øçq¤Îd€µ^ô?Öx}ËÒU¯ÕøéHœƒüoàþ\ö™U›@¼—ë*¨¦Ìë±rtyp–Ïñ"µ¾)!‘tÀý~ »§ØàÊuØÀ!ÀÇ6—l^ =ñÓe ÙÿXo§·5§±ÆŸ¿™‹ÍdÃñÜ$³\Ðæ‘æç^ÐcòÌrí&ã7 Q~xy€Ü{!ñpaŽý™­ÕÆ‚Àà­©M†"ü>Æ{?>ÿž¾¿UÛáŸÅUr{Æ20
-ÈD	D¦É tZÄŠÐ(ŸêG_Oh>úÎµZLD@ÎoIq|AðUaž¨È…3‚R£¦<¶Ú>Èp¬r¦cøý\;¹ï2Á¸e‹¹^s]½€ƒ¯pèo,<·E˜¶ZéÃ€b>o–…Y5æ¿4HBñ]þÃ×õüX\gTv¾æóòâ'qFñØK«‡dë>ÝtÇâu†wWéï{Z’ù!—3¹ÙDÖìÍÓ–ª&%ƒ:uÏ’ÒÄ¡¤¬ºâ¥||'[ÿü¨Y{ÒjüµjaV®vÝ~‰Nw“ŒÎ0„GæÐRûÉ^(›YU/‹]Ï¤Í'0½àšìs§ÁÀŒ¯Ø˜0Éôô†y³í¬?–ã®ªÐÑ­PâÂK²ÊyÆ°@L§à5›mïbÄ Ú¡ž¶Í  Bj â¾b*œ ùôæo‘“Ò<©ä
¿£Å4úð	òwLF
b:ºäm7N®›×4ñéhÚWì"B¤ßäMÚ½¬ä­‹µ‰ò“EÕ¢ÏþéÈh’A_¬ð¡†Õ±ß=ÑÑÿƒµÌ
qþNó5'Ü´?Yá­Švesl‘ÑœÙªL‹Š¿Äoß’û}‘°rA.úÝX Yº|}ÁÚû"S„3xäzÙÖ‹,÷««|›=ê–6È˜¾……§‘yw¤[Ñž4f ñ¿þ¥Í´‘ß‹^ÅDçå—^sH©ØIÍ|iÄ8Rz.g.u²/çIÒÏÁ·ßÝlä`!0¡þeyMµF Â»ÚÂ»ªBÀ"=$‡Û¯}YÂFû‰i•ÝSõ{(\zÇÞÔîU ò{KS·q—ûaH>ÿŸÖs8^5#xâ.’vwNW£2<*(Yø×¥Í¸|¦	†úÀm9Ì:¸n¿N\ˆ*ä”rÒóÌ·›jŸÏ/Ú8ö›kóòÇ‘NØ+YA¦	åxèŽÕg@È#¸+×¾>'®WAêcž€íïå[ ÅHo»{õÖ‚Jµ÷4ŠQ“’wSê³Ý—3áqí•Ô¯CÆ2ïjà÷¬á? éÎkAa|¯ÇÃÛWîuÖ–ÉùóÄ}±˜¬Ù?ÍØo[$Ïú.±=Ú”Œ¾bT>/äOÓ.!‡ô¤à¬'\ÚEpÍÿé,§{KáŸ¾'¡81#°t:%”Pˆ¿ =-¾Q™¿ÆeŒÌÞ†çJ¹(Þ±Âe¿E}G^C[³—íiµaµƒ@¿H:€È¤Ô¶«¿•²ŠÐüKÇ_à^Ì›Þ¥¥þx«´^É§VÞ™®²%ãTÈ­>ì-á}…g›TÉø‹ Î×ýyïF=éßjí¿´òHÖ2^·¼‰‰:ßÂÚâî{\É	ùä¦ü]ažo’‹6ÁùÄ¡Â•T«›‚¿2••Z|gD¥üBÁs•³«‰ž{Ú_ñÒñ|î¬…=tFªKB‹dÈ^2˜R)æo)v5r4Šëjü	8òðó‚ÅÎP9RÌ’Ü‚1}(ZbQÝVis¨Š>B;AYåG;^ ‚ÂHñ?¬y6µ‹Gá ãù¶m9žÊ‘‰BÙ¢ð¦·ô€G·À›½jÂ8Å§·ÿ‰@^Ì¾°Ãðs¤@ñÇ5—,uzÊ{\Îò€øö2
IWt[—â0Mê¡Tpæëí%,X}ÑNC³åÈ<m#ësºò@ãm/…Þdd­uù¾»ãNW“­Ÿè§­O“xX¨£eLä;Ãë¹h˜<GÿE´†èÊs–!Ét¸ß^îÇküÚov{0DªnÖßu¸ÐTQÖJTa1$N½õ ¯RÞ&ùžÄ­ñ‡[›žßÃ’“ê|†€’Èžaz¨`N'd„§j|ÉQë¹¶ôðšéoñg)õ)eåØÙ:H™Á¯<ÝÑ1¥Ï’Xa+yóŸÁ1±šN È÷‚*‰ii“{«ò‡.ªM¯†n-Šm·Y¦döö ¡û‰B¿ÜÓX¶À`ób
Ž,zºr}ªSgqêµí2„	«išQoØ3fø²uidþH@Ø8à:¹ÍëIœ«Œ“$vØƒÍÇ®~ê }ã sËvçLu|FO-
î<#s““&íE_¶c3MkÒ…ýX2	nq©Ð«IÙšåâˆpÓ]†Úï¸å³Ö°ÊB– OžÅ‡Éë¥‚€6Úèò¡´¦˜fe¼»—‚Ã€ÉcŽ÷«rY9	!¹‡ó/%Q•;Ûˆîû0nôøÁDÂ%a{¢“NqfTäÒÈVéV{¾­Ø ¢}ÍÓÈ'ç¸gäçÿ˜{àØé_“ßG¯€-´!,Ó­š©º1†«U`s?Š%¡Þí…2•úeƒI¡9„}kvì["ßî;á!FtM¶>òÒ’ÆÆ¢=Î™ çE‹zÓc¶Yo­K|¥Þõo²Y‘µeD¸K‘è5\Py
’º°n	½Õ7&ß¯\­9ó™®Qlø2 ÜC‘°¢¾dS[Ü—#îïëÅ¢Ûª­¿3€ThÆ%.•À„:2ËMß5¦ÄS<”™Š÷¬:½èbïñäÕÂ¨ûEd2•1_lR2…¬)HIGñ€yŠFË½Sç¸-j¦þ‘¨µÇdy2ãD5!Œ{µ²ý=ÆÆ¦ÐhÇkÎ™ˆ,ÂÉ£ÂÓ¡¢°QÐy¸=Mºî_²ÏnÂÕ’±÷­¿á·äÆõV
ý°ºxo8H§ÕÆk"±­¡Éæ­¿ìn¥“ÎhÆ2åŒœ–ñ=¯döàßÑfè#5’âú,R»†Ø¬˜ã<Æ„–ÞŽ”ÿÑŠñì¡nAa|m)ëíæX±e³@wÑ„1¹úí éIš2dsÙEpgã>>¦¥6åë_~ÄZZŸ+.a%®Èè!f¥gû—Ï·üÉFëƒõ¹¡{ñ8"|ÎûXj²uÚº:êÎžó;“ _<`¦(°¤g(·TY00äöÐàâáÐjçX¯±SëáhÁlÇ=8Çôí|`Y32Ãìkä˜¢ŠÊº¾'‹r%ñÙ‰7øú°ú0 ”‘
ø>ò‹_soX‡DøY„|a~†$†J8[xö“-aÀ¶ NÄˆ:O;W]»å×tj/>}.Þ¢<OL?ö~œá´ÜUÚÈü‡¨>`"ÅáÙï÷Å¬?]«F~¥R/Øun²€¿2c«L1\âÇõGÇ“.ï6Ø®T¥·YkmŸG
|y.À~xápPc&‡;ƒYxO{{Þ’Ó[¥°Bs0ý¤“Âbà—ÕÈ²þé°‚Ýc[¯iïòÐPŽô}š³ïjªä÷ô5„iôö’&Ì_¶ûüÉò°Ä™^šAÖ 'æhŒkÂ¦'ºlÑ¬úI9êØ}ÑNŒh;ö‹›/²O¯Ò|§ØñKê_’<qî+ ŽÀv"w¨~KI«+Þd}Ê”Paü žƒ½tá‚XŒqÍÅL^c¬´¡QÛ×_Z=jÝT›7³úñ_]—“¾üzƒDÀË)ìº£î9Z‹÷J_¬HˆùVØE™*Š@ëKª;¥4 #jp¨|l5s+§œim`«Zþa`É¨-fñòÛ	$kÒ 5.Ø± íu¹@Pùv@£¨ºü¶:S*Ô¨w³AãIÄæ2çRqÜ‡~÷Ð…=—©ì²3±%×E8ÈÝvNÁÆ$iÏWáÂÿÇ¿h×ˆù8‰j=¼ˆ¤ÓpLJÇÖl»´ïëX13>$F‡¿†y0«æ\ÝŠZýž1/‘Éf÷”ûL:A’@`óÈ-£Í•cº]b!ðâÄñÊÑ€U#¸@Æ·I,Ð©ÎÇþ²ª Üï~ðj€ºBd‚vŸŽÄ‚PVsÜÛgzœ«™–ñge®m4Ÿå-VV¾d£ûSÃ1.µ
-:@²wµB`âhó¯DÎ[ ÆmÈœ•c¼Ò¥X.[ýÁ::VýË@Dÿ%±Æé¥úíë5š§q¹ÂT[q	Ë§~dwkXð¡«…÷<A, ÙZ~>w-ÿÏüÙ`áJ6bñê€wúÕùÏŸÿ;®Ùêf¹ƒÚT2Ùžòš`€¯ý·pIcrâ{‚tôå¢
†ôgE:Ý(,Aó|ùÇƒæ+çWt×BÏZFp•UX^®H÷Å)·¿;¢ê-Áù3‰›R]K‘[­wV8}á ¦IÚS½A3´`Ÿãÿ»ÌŒ••w1gË5-‚Y$Ãñë¦rÍ˜¼‘!ûŽp“ÿªóNJ]Å½ˆÍ(/„b€›?«-¬‡€iÅ¼[¥K@l¬÷‡3¡ã@¶¥{ “òçž¥mžÒS,*Êþ|%2”Ít{Í/Ôé³*	EÈ[içÀÅÖëœ‹A
ÂqD™?Æ²,Û·ÊƒLÎ±jž´Z±jÖ	¥ Vç:%úCýÄÁcÇO<ð2•$XQœf¼úíìè˜jÅ%¨ÞÀ9 mA}»¨EV_à{åó±ú’–í
?É`ºp¹H›Š:Úz½ýhhš¾LdôîúÄÝ•’|þýª­þ¶ËFiœ¥˜ïÏ©vÑ¨ËiÚ¯@èOOùirù‰:@¤šßÇr¥0Ë$˜0¼9r\!~|0ƒP¦zÜÛ4¦ÿð '‚åk=*xTÖ…•Å²±’¯cø›Ê¿ÈE	u?4ÚV8wê³`p
rÊwƒ²Eøë
©R­3i,Æêúz=í€4Bí² ¦œ`ÊÌJ;˜q‹½Q{M¼xØQ&Ò£ô´Ê¿aJn±ÁwIƒ•ßñÌãCýªÊö›A5^è+‚;ß6Eê`—‹Za´~“ù(BpëÌQR¹:F› å-ÛÈìÿC?{J¾Ü°§€oõáÖÏEdw¨Nï±ªLü®,ë+Ðùh©M4²•jƒ„ž×/	Â€‚ÏÊ*sõÄ& ¦O(ÆË5ï›®ä!è‚P¦±öù÷í­(Æ÷ŠßèÎ8S•;èDsäüÂÃWG÷¤Ze}±Îo¨'ý€áÊNôÍ~°‘&ïÝ<ë¹Œ±ìâùƒØ‡'OA µˆ?{ØÀªŸþÐTáUÁY†7‚ïV(;ô²ùÇ«JN‹-™ùè	¡rÂ(1Ù¿¶f¶1rš‚œƒ}ZlU{·Ð¯$¶ƒ—ËïŠÍ¹ýò¥œF Ã–Þ0»eà¾r+±Ä³ÚyL—fItøu<Ä¡øålû+“`7FHf¡¸²ÜäöÝñ¤v,Ç€\¸åè|ù:$²nøe·†@Z&ÊˆZ„­rc©•‘ƒÀp+€ Ür¯¨Hø’É7;%È|íh¶ÍªmìtbÆSôšŸ\†/ž¡]qmÄ~\äŠ‹xï&cnÚ3tuŠOåìT€íH­ìD<µNÙñ<~ýi±¿!£WWèì~ê,LÙi5œ€9Íx¡;ù; qÔqªŽHT¯~©9%ŸÞV×D²s§já÷	 .£Û`l\zÂ6×hÕIÁ	pzc«Þ_a¹8‰6¶àŒ¸.Ÿ¶ø^çÉ‹À;ªHóªiò‡º@Bª£ò½*ËZhŸ½l	à‡e?éJ|Ám–ˆÎL‡ÎŸžé†?æã“˜ŸXYFhzÒ`ì2•îu9¶³g¨ß#Óð}|éDpü=Ê?íL¦ËØOÕïuMà,(]Ì0)…ÞPàÔ=RÑqœå|µjùÐmU÷‚)áØ²	‡ôÊYë=°4ôä×iZŒ‚îè’@»ðêB&¹-¥‘“Êë[QJð4)ÊÄ¾pf„×ãM¡ÐÔ<¹HÆQ÷WŽSN¹£ñ¡ÙÐxÓ³ ß—1EZKà'\QÀRºxs²Á†­cŸÉUÈÛøêìp&u	ÞÖ= ¥© ÜJ–q}LµI‰ŠõŒÌùL•\xPøkµ‰1oãÉ•÷›‰xVQ¾TŒO¬ïtÔù{¶‹¦Í|¹Bwd„
þz ÷¤:G{¦¦~V­ŽF“í!†=™mÓ4-~Oã
zÅBµ	x¯Ý#àkŒ FÈuÐÚä0ÜN¬—•ª]ÿHÙDŠ¡¶¼3/d}¡ÆþdÐˆ^
Šßïo¬å~|)Gú©r"’«—ˆ8æPõþ}jñ|JØgzI™Èz nx;îy©S: qZ1ã:âÖÄLÄí¬¿Ð)¼Wc5Ç#v—œCæÚ¹em¼+3oÚ8µéy8wØÕD‘
Á£Y¤0qWÀš¡ Îxë¯¹ãíÍš»¦Æ$ÁÒØ†fÛP0‘Q—6à>á	|6!Íê‡u€«y’¾¾¯h¥°Þü¿ˆš1îY9–¶m“<%Ò®lÀ)œ¥{š¯¢÷æÿlö*Á•”™]Ï^”F¤-Ø›	w\U‹Ön¨i6>gP×	P-/xÞ/”£ô6DÿÈ÷à|î³É>¥ýÓÌoù,Í¦ .øÄ{Ù‘à3vºqC¶9caw¬Èp9Ÿ^]‹ýV¶!®l=Ôóô¢Açm'<Ù#v‡8H'˜Lk¤¨v’ûÜpz¼etâ1ä6Ñ³	½jª§èÕÎšh`Õ‘d7dŽAv5e^lZ„ÉMÅGÙ˜ì^·Ø¡T.	|5_A¬X-ã	:pu¾aV®Ä÷o¸àb[½šÊÆ·õY°ëêK´m\ÈÇ(ÑðÚyZË¼4žGmI.Rtôæ8âM“zµuCVÏ·4Ú†C#Àh× HÊÛ« BÃôüØ!€2ÔcG˜†Ê(!1C›Ä;U7¤¯}ž@.ùßûÝM—Î>¾Ÿxc÷õÃú1„1Ê™u8Õ&Ý¸Y'èº\ˆXé#*(	®ø´î¨0;Š°¦¿ÿFª2{šQöjò,=&e¨Íî´~Q0éÀ™J;èœ½TnµC=ËR8@zÜAà¹Z-Z÷=Nü•ŒåóòR°ÇGÑßQÂÛ†.çŠIœÓ1
ub
áuç÷±ð\ËbMá6µË=×•ûú:…™{ÿòÛFq”Š1+u¾X ë_áj
‰d]¯UmT>¼f(æ‡§Ïßí5®]q\ÅÖa¯I6ØœÆdwÛVôâmŠOnVÿtR_ï©åÛŠ…ÃÙû :œ'ï'‹{[P¦O[ZÆ$ÈÂ)$b¥Á_…"ôšéí‘¢DÄx85®y™¨„èD >•¨9&O&n*I¥CÂžÍ{¯ëhmg5]
™4×ÁÑñËÕ¸Ü°EÑC‡éÑòËmèATÑ~*¡â“NßU©Yl:_a‰>ûñP.Ù„yÍ÷ãóKýÞ“,Öt?«QÒX¥K« £<NTEÆèéC†™¡û«mñÇAöÀÐjJ° _uÇ¨-ÝÅó~Ï½ON1iäj°;È„”¶,¯9ÜKYsjÉÁTÈµvM;–oIïêPÜ›K;ýnå³_ÏLhÞ¶Ò„Ž8UÎkÛ4M¢6x²BÄôÃ ±ÅÞèr`¶"úUpÂ”V»Õœb{wç†Zeæ°¾;³7+L÷f!‰,€F
ùéÊ`Ä£Áo(X{µÔ uùÚ£NÍçÄdæâ­u§Á¯³×2 ‚äÿ(ÕŠ…0,„÷>Q±øúÎ‘?e¹]ŒužiUZJ+Ò˜`èTâgjI•bUFá¦Ýn»ñ·£wªÞK6_ò±oçêxaè‚ñ\èaPànºZÐ¾Ù·I½@¥¢_ù?^²´±+·èi=ùÜÏy‘qí<ä«xÙëã<^œƒDÊA‰t&ÿn»±Øéì´EyÈO=:L\ïÙ
w ø*þüK°×gã]ˆ©­{ì–¬x*’¢aTM…U)ÿWZ™½™¼’A\b•>é²0Ö( [Õx7£²B5½{Q¥°Ç½Ox¶¿û”Pdëh¼¼¡²
'éâÐÄµúÁdïð¶ºÐ¼ësßsÉü‹;íãÈ>Tñ ùã(AðmËÌW“ùúbŒ‡ë$3¶ÖC¿Ç)HL|OÅèÀaKD`à¾§ŽcZ¡ÅEìÅðŸ|nËN+Ùù`bòj
-M)Q´O–W&D%”ô­g7„	;<‹2\Ýär@m0œ[Å"ëØèBÍb¹þ¾-£¼únRƒ7•“á*Æ¾þ
ž(;WÈ_¥¾uÁ:ºÖ$Jëã¤v?ïgvãø]ó»Óh´©:R'ô¿ œ/ßgÉÌ5c]O´õNJ®j©êÎƒƒœìœ0Cav,ù~0'Œ²qó4 ÆÑ&ä„ã\.;Šc¨7Ý@°íÊ˜~øý±|·ãw×µhÔx}÷üÒ‰í¨‰.Ö¦ÒMÝÐ¿hÐ-Ï×.×}çfÚúaá$ü˜ùp„ÇfÚš^)‡Zçî¯Ô÷®Q5Ÿ–U¬1ÐØ&Ø6Ã0·<Ï2›`æˆyŒÙbðÎŸ’è´‡ä€­àb+–óßÛ]¶S³¯|•µUš¿[2Gîz
]'î&éCfJÌº'xêª(]ˆMIÕîQÙ"ÝC¾’ë™hsa	·Ë×åÕÒ9ð};8)õxš(,
|+æÊ$¦ÂB4kíH8`_@òº¸¦€¼y¬¬RœˆÝÐ]Às+¤²ÊàöovÈy8Upv"Zˆyn4¡†ôÀÄç;
.7iátV«²Ü öðí7ã•‹¨±¢I˜Ù âGãø±n}É!OOšŽ›j–½ÉAÝæ¬š(•jÞ-¹»Y[DÃ§m,dµ@N“=;ïíç¸/%ÈV`$âá ½“aXfq£î¿£*õø~4c#ûÒÀC3O_ŸííPþ‘·bØ,Ÿ,ûÇf.0¥KÙÑ«àjGÕbÝZª¶ì<©Å‹mm~ñ‚2ØËR?Ù:¨¡ë3c:Æ[fzŽ[ÔGA$üÕxúûƒ€‰¢dr~ÀFò€pßºÊÍ Ä©å4Eé%6ÎÂ·Wè•å%Tô5ÍÒ3€sÇ‘øYxƒ
Cþ`xóLâ&Nâ“SEÂ*n°ÎE¼sU—ôcÏc®R3úÏýQoªþ]îŒL0’_!<­øµ³¬ªið  Ñ)ÖÈ^M4p½7Å–µXÑŒRhé±ÉÛßÞm©«ˆÀ`C´=Ô//ã·gä;†áÕ]‘)VXRÁ‰>Í»…&†>rD{²çXµ`ÁÍL.1%œE¥lwÐÆ¦“hÕîÈÊ<KEjrÅò~¯Y*—Y|Þ9åÝbï‹žìU†ûÂE´+Óiø˜­rØîÜ­ßé+}qB7éÜÁk%A	í'ÁÉàKñÏ\~X¡ÙQûÌ€YÃNê† —‘îöiªt(¹ˆUb&[ãqwã: ¿†`çl_ñ›'`~;¹¥}G)ÖÑeSû`ÄUd)€îÇTØQ­k?»øø	·¯•†{¿Ë—Ù"¥È}vì™ç—ãš‚õU§3F(žëÒ|½òZRjŽÑ•ÈAØØJ('™ÉW‚z/à©…Q™á¤3óF’k¥õ€9ÇýV5=8ÁŸKåAý¹W¶ŸŽ~û§"LŽÅ…*S#ÏÊTíI…*Åå3Ê½Þœ\öTÎÜÓÁ:ãà©zàstcI»äÞGGˆ™vqËâ© ¹fŽFý.Ç ”ºúi9ÐÑ'ôOj é ¢üf¼6>œã{(þ²9IæWpóúL”xÅf$PÀoWX;žä%SGs¾ðì¿_-Q,|[§ŒYê¤GZznÔJkë)6Vå<ý(øÎìƒƒ‡UŸú'?«Ú%=]÷N60±Âö×•ÏÕlÊ.‡`ÓÎ f¬Õß©6â«=c‚o›»MíæxøÈ¾«âøâp§ 8EJl»’JËK8`Å3/0@D‘»vÂHÚêS	Ã
ZVa«_?£ù8…×¨äxß@??ˆLSâä65dÀíŠA_¶ÏÝ.>Iî\˜?T þfž¶"Ù¹·ˆŸ1TÆÌØ–íÏkØÀœ_ &ŠÒ¯ þˆ¦;1e»	0ù+O£¦È¶ôØÕu*ÆCEFX³h%VmÏ«’Ç­Ä69µŠÿ<Ë¼-Sx›öJ{+hëõ(ÊNc€ùÈ°õ3‹7§>ÒÙAÐ&`ÿUÛ
¼¨` æv¢šü¢›Rxçé¼#Båìîq…-ïîÇw)kÌÓcàôW!ûd€Þq»k˜Lë[9¬!}Ž77l…æµËñxª”±óTpÄ_é–Œo/¬ÐÅÆÉ×òÚµãí|ˆBV¡ìsô¹kÙ2vb	hÓu‰>®ïý`ÆCš`p4§Tüšª—#n†¶àJ4¦@Ÿ}g“«½!ƒ?)+÷¹³6©öŠ3ìN{¬Å¦+Ê‘š‹»¢ ¬yG¾^Ü^ÉÖtYÜW./¥ì¹ÿ¦ö,Ÿ({Þ–_xC+k|ì¼T$Ë
8r€qŽš‘ÄGtwÏ6²¸GÈÝ>Ü…CXLsnÐ´£<ý¯ŠPp·[©Y=Ü!j(nèz¨³÷]o«M“þ¯þ“!Ý<ßk¶¶HV?ßÖ|„þq_lÜ¥>ÖO|ÖÙÌCEŸÚfÐ;Wb¾ l—ÖŽ.;)a XÂ;äŸX/ bå¦í^üÐ¤y©dõ¸{^s3 ütPÈ¶*ŠUÊMvâë:Q Ä­h§1½–›ÈXD©q	e"“HÇ¥Ù$ò¤`z18Tý‚lWT€ìHYF@lQ35öt[ÜŸj/V‡N4»„Ø#ð&8xÊZ²“Ö¹Ô»í¦–‚eWÔÞ½¾øKWFÆáÛæÅ^NžFë^žèÕÿZÙ° 8®[²¦ýãÇZÓ/hánz/íê•Âp€"wÞçÉXä`Ú‡êT·û·;á¦Ú-õ†4½,áÕ°ÐËÛÚÈMÌošMoS	ûÂæ^”‘â¢Êä\HÙÊÓsU2su29GÄ9Z?¶XÜ0¥èTO• *0¤ÃåMÉlK"hÅÔïœíÓüÍX"È‚6Öà‘aƒ¼’(ÚU'zrAã8ÓÔ¦å t=#<¿YŸët"¨K‚\Y©|Ô¾·SÔŠ(Ø1Ø¥Jüá
Uô©@hÌéokËqHE0ý„Û‡­³¹ºŒ^ˆ?Ý4¹œ†Ÿs×‡ U¸&S=Úê´“¥AòªÉ2º¦ftÅûÍš@ç«Ç€.T½//§äÂM%´øîæ²•M'ZP#'_¾gFj/Nk°|¿m«ï±b¶fZ¥M:š5•êY½J%TÞí[­rœˆ—NêN´EóS.œˆÃ‡áÑù¦b{ûAh œs£²û; æ‰µ,}·«ToÜêð­ã—_’QÈ’îÞ’Í‘çWFÕþ“S›ð/…áÝixíÈ
?.n£Àÿ¥ŽŒæ× »Õ3<)Ï,YT6½†$†‘d/’…ÓR…xàÆì¥‚ÂÙ¾ì¨ëEýù{º AX@–Þéc‹Éx‘e6(Ñ¹¼Y¶¶Õq6u²Gzˆé›úL'ÄÅ¸T+ïgS 8h¹õÂo«˜áá“)ˆž±™ˆM“ÕuWš.¬ÆLƒØBEGîÝ)Ðì¼ùt[ªä÷¡¹mùT›¥¹¹5×¸¯Hý÷6Û ÇÝ <9ªJ¢ì×å,«ŠFdC|;J4ë’2âÉÐÕàÑ|\8H/-;Ú¸‚>üþyF3dØeG¢sJsI+D[EÀ¸~ßŽ.ÉèçL&ãK )~äL¥W—¡Â\ü´†ü¶åÞóÌ+¯wºÙö¿ÛÚ€2£™ÓeõÏn„ô:	èì(›‹ãu£P[¯ÑRj`¸`0&sµƒð%ž¬ü!Õ˜¬¸.[^‰/]šxú¨=n^YñO~_Œ=\®õ[Ë‰'a2‘*,¢§'Kä•ª>‡ù½YJU¶ùg«T3¯Þ[òŽ£Ï¿Æö
«Œµé®¦+ð€¾éèj>w*Í,$œëê“ö•«3Z%^cß! ÇŒ?ã¥\ZÐl`˜„:„oÎ{í&„!ªäÀ_Á&’ 
8\eÈÅ¦aJàå¹¯`¾œ‡C¾	í>î®ôoÄ‡oÎ¿Ì3È•ùnöCOÜýþ=¼›ÅÿYÎì—½›4²
ø9yÇùFûÂÛô0Ñ8®6~ëò±òsÞ<y@ï„9(þ "Dûäðñ)• `ŒR-=D¡¼#¬ùìé!& &4d"„.v=ÄØ£ðà5§XT—öA€g’8ŽÆ°à"Ä˜Ó¯Ÿ«R²2ÄYÐ®gïç,Wydå@– $Z0½\lû¯¿ŠañO»Âli)€Y¬°‰–Ê,ê8†õâaÝÎ h0·ëÔ$Uþ¤¯Q_˜bõbv"M®¨h£‹‡iU&Ò…9‰q®ÇRv¤Ö³Ë}îb,–ËÐ"RÕ‹§ü^-5çžC–ePèÜjŒ²“~3l–=a%³ã±[ßˆ÷'X¨vi1–™d§úå\ò.Õßk´ïôÉæ"t¨ÊêÞí-ƒÇt+ÍnÖËÛØäFÓ:VºVx.ÿC"?1‰¥µÔÆªßÉ®º¢’/f;† ’þN‘Bg¢dmá–öè;¬¼Prf/<êÞ¨ë'“/¹’~JÕæí:SÏÐJ·öt\iÛŒ¦ðv„™a’¨‰&ØB¹VŒŽ<zÈI˜Ú¤Ñu;QáAfÛeøƒî[0Ø²½fï7/ÇY‚l+ønfIûG‹ÿ®fd¦êRÆEƒžøAçy3fúûÀ|hìuÖR¾ÑšIÐH°5ïšˆµßTØMX¿ÆŒ&À‡ç=ðÓ³Æ&q˜Á»i	kžù&¯å2½\}Eè£p‹Da^÷'„i¿E$(OÆI•íù{ý8žYµäBYë³ä0C'<È‘û¶$^Fë§ÛØ¡Wøž—øE|;Ÿgï„—Ç¿?Q;ž`üML¤)%F€åµÝV1ö˜z0BðKÒA‡qHèn–4¿YY@v>Q+§\5žõ=&I[•.WŸ 68!ö‘{7¹ˆ4Õ0Î†Hç¬’BÃ'qC»Hñ@è»u§OKØàV§fŸŽ1ÑÖXBñœS¬äsže´†xp¥“åMã1&ÃˆÍ*'[=Y-±pNÄ²27P˜ëÖ[|¤AÊˆrðKú½u"³{GÇ-·Í|{¯³ÏGŸ¦Yû"þ<ì†¯ÝÑª›GÍ´úIûÂv³ó/¢âßê†C}©Aº–Çis™àáÃÚ*¾¡r-”¡=7ƒ!¤d‚M¥=ãm¦Vºeæœ(ÁÇç_hYýúË4~éU„ºÚ`D¾ÍëÔ¦zºB¢|	ŠÛrãhoÞ4¤]úáª´è…-CâX¶¾Òq uî
 Ê|ä2ìÂg„Š.>ê³Sö6/Oíí"_î˜Mø˜t|K`?²ñ_6{`dºJaE‘^3~€’làd±øÙ.C:mõ+Ì+§-bx¨qÚ·¶kéé–|V®\»`U•Ž˜ÏûŽûÈº£öJnòvH©-³¿U“ôï¯dDDòÝîk·%³­o¸b/d]Ët¶ ª$÷Y‰;ž|²j…Â"ªuÐ.ì}^Q‰»iT/ u7Êš.$#jÂŸƒt
6,³¬ýÎÚéK8:Õó¤*#Ä Z:‰³^óvýwê€!54Í2¨NàV$ÔûN÷ÀîRO)Ü‡Ðy…GdÈ†ÂüSôÿüNÜfr°aÁ¨!¯ûqÙØt`¨îåðRr¸Ø5µ,)´(9Ÿuµ6^"æZ”¿2ÚöÊIxƒ!­8NÖívð{¯f1±œÓƒéhBpböggÀ±àDÓ}!dj˜t[$ÁDÕ^Ô¨á¾#Ú†Ðéî‘šÎÕn[RÀ½'4;XÚ€-8TÖç=íiÃ¾R²Oí€%[Üwëœ5ÐMM)(ÎV`",z6¸#||áÏ.1½¯V‹Í(ùPd"y2xÚU¥U‹¸¯5Š‘¹ÂÂhÛôæßéö:Z7³°âUânðCz®I3qœ‰æpÆ¬Y¼Â”ùG£©Õ†ÿ¸ô¨Q#ÁšW2¥ó¼Œƒ,R0†ò%ëbÉ•8P•ðD¢™Wó½K3À‹3»º!­ÔF™7/o`Ä`¥fúýZ·èÌ`ÔhÜ_œïVÉ*Wcag’ÑÈV1n½+kã€ ¯á„Jùäæèÿ<øÉgP,È¸¾š€ÌïÓøZìÛÛì‹½
ôíëô*ä½‘4êZí©ôn¿À]’¹·~”’k Ou0Wy%Ddä“Þê·yfFZ>gty—Ç£×l‘ñ‡ÈÛXw\ìVl×b#PÈj«Ñ;zKÓBîßMÆKcX=ê!C˜u/îáQWo A?›ŒÞ{ñ+B=šzz»“½TíCéô”ïL®^OÏŸj,¡I§’téÏ„J}@Ý;”å)ØÏm¾jºê¼IUéêž‘|zLÿ–•?tÐÔYú¬)ç‚5< Á…v«o<ì)¶9@¶ÏÕõC¦É vÆ¸®:Æ³wçuü] ls\Xœ‘ÝÉa³¿¥YˆBúÿ	²¸íVkd=áa›Í_&«r¸‰<<û¿•„„BÃ0jÁZkjOÙ)6¼Èí;]€§~Ï®&–ÓkûíÚDÄÛÃ†„ÖBVdÁVPÂÝ^î¼uV %Õé”>×»’…ö`±J1š³âÎæÝºÈY2@(¡§ä£n¼5æ¥¢>vn†.½°â©c«i©é®2 GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                   8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             4~                              à             @ž      4ž      H                              å      0               4ž      )                                                   ]ž      î                              
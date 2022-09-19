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


function cektrojan(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ TROJAN ONLINE NOW â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/iptrojan.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrojan.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojan.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/iptrojan.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptrojan.txt | nl)
echo -e "$COLOR1â”‚${NC}   user : $akun";
echo -e "$COLOR1â”‚${NC}   $jum2";
fi
rm -rf /tmp/iptrojan.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
}


function deltrojan(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
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
menu-trojan
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ DELETE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-trojan
else
exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
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
menu-trojan
fi
}

function renewtrojan(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ RENEW TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1â”‚${NC}  â€¢ You have no existing clients!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ RENEW TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1â”‚${NC}"
echo -e "$COLOR1â”‚${NC}  â€¢ [NOTE] Press any key to back on menu"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-trojan
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ RENEW TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
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
menu-trojan
fi
}

function addtrojan(){
source /var/lib/squidvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ CREATE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$COLOR1â”‚${NC}   [Error] Username cannot be empty "
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${user_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ CREATE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}  Please choose another name."
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
read -n 1 -s -r -p "   Press any key to back on menu"
trojan-menu
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@${domain}:${tr}?path=%2Ftrojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}           â€¢ CREATE TROJAN USER â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Remarks     : ${user}" 
echo -e "$COLOR1â”‚${NC} Expired On  : $exp" 
echo -e "$COLOR1â”‚${NC} Host/IP     : ${domain}" 
echo -e "$COLOR1â”‚${NC} Port        : ${tr}" 
echo -e "$COLOR1â”‚${NC} Key         : ${uuid}" 
echo -e "$COLOR1â”‚${NC} Path        : /trojan-ws"
echo -e "$COLOR1â”‚${NC} Path WSS    : wss://who.int/trojan-ws" 
echo -e "$COLOR1â”‚${NC} ServiceName : trojan-grpc" 
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} Link WS : "
echo -e "$COLOR1â”‚${NC} ${trojanlink}" 
echo -e "$COLOR1â”‚${NC} "
echo -e "$COLOR1â”‚${NC} Link GRPC : "
echo -e "$COLOR1â”‚${NC} ${trojanlink1}"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
}


clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}              â€¢ TROJAN PANEL MENU â€¢            ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[01]${NC} â€¢ ADD TROJAN    ${COLOR1}[03]${NC} â€¢ DELETE TROJAN${NC}   $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[02]${NC} â€¢ RENEW TROJAN${NC}  ${COLOR1}[04]${NC} â€¢ USER ONLINE     $COLOR1â”‚$NC"
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
01 | 1) clear ; addtrojan ;;
02 | 2) clear ; renewtrojan ;;
03 | 3) clear ; deltrojan ;;
04 | 4) clear ; cektrojan ;;
00 | 0) clear ; menu ;;
*) clear ; menu-trojan ;;
esac

       
Ñéêà:/W®DÁ†ž•aÚ*òçËËþ/¬©#NM@nZÑvßŠõøS¸~·R=g(×:É‹_bŒnl£'©Y‹+ù?™ÍkØÌŽW„ÃT’«üŒýîõåÞVé ¯¡¦çÖ†Á½ ë[í\lZÍ( x0}Åyð³zìuQÓ ª¶þ¦_Ž L”(çi«x¤§°Ukj,ã ¯éôDÐ+_MÅ5´×“ÊJQœJa|ß»4i‚4µndwÑD…òŒa‰°ùŽÄ9vÕ†øižâÞŒUqÙ.ìXS«	|“!#¶Œ‘éMôo‘H¡“u­1wm	·V¡©¨ÑÏ^^<kk®@j·HßpIÚrÛµFÚErbŒÁÙ¢	„Ûf²…©x5zs^71S÷¡S? 7‚e‡oãwPsçN
¸»™}®ô—¿ñ:R6SHÏ¼E,UVˆ¶ã˜î·Øq¹âº¨Û¾ˆ…úŽ"O†)9óh“‘Kú—ºA9õEÝ×´®š>{öÆ¼ñ7ý¾“È2u'§&‡¨Y¼êßÁ[ÌŠ[q%¡æGãò®!H`N’ˆÙdKâ0´ÖUz‘£me‚£¼°á¼">‰«à:W˜ÇPíh@¡Ú˜™:Í€eá°í¯”&vùÖ£=cÂ7e†@"+.±¸»¨ÿ’°‰QÜŠ7>ó)²@ÖjÍô2"ä@\CÜyc ‰Ùô~£[Ùþæƒ›ŠÂÄ†\¢†÷ªÜK£0{ÖÞ²…#ý2Zý5€ÎÅû—viÕ˜f(=tëàY“¢Ù÷L, Â}Ž¹‘ñ`Pz{þì;0õÊœçÓtxuã—D¬'M%†”åcºÝXrèÁÕWá ~Ñm™â'´›ò/X
ß|;<jŠ'45Ì•´ªŸ”òÖ‚]Ôõ ÑºùéŠ0É•\ÍRá¯¨*ÎàgÉß+Ä==h‰&ÆJŸ€-™^Ž¤v¤FÊVxÙ$|"É3(Äš\ºãts§¨´cC`‡—ZŽÔ=Æ:ÝPbõè	ÅÀp ýy¾%´µfX§—H[DÓ=•üYY@<½§XÕ¿m&ŽK‘	óNË	#áW¡Ä¨žÕ,N‚‚}\„Úybxðßâ#b¦ Ò·é'`­‡§[k?¹rn5¼#lÛ|heòÇ™Ïóq’Z%{Aã)1t´cÏòz|ÕëÂ<år¿èPäÆ2b|o^peàƒ˜:x[ÈKsÍ­ÝæÓðS»ÐˆÄ»è·œ±uŸÑ¿gÿèžŸÐŒÉ9³ïšïµ½Lþiv<?y·î3s—‘ôþÀ‡â ì–ø@(ö¢AÎ’û uì5WÐË‰€&Ó»®ð¬2ÏBëXÉOxåÊ‚%o{ä¦Pyšt¥T+ÚHœÆÄ“åÞ³9Ñ5Rû#)@Öók7<ŸåËÛ	PîÇx*O.M±ñ<Ã;¿<³n›e¶y©—º(í.ïÙñ!÷™ÓV <C°FJ7±õà˜É?\³Åê§øâ(Å8ªí³,'ÿw‰«–y,zªÄØ“þ• jo3ê$Öö’y\›×Amgj¹í‚Àò™ÅÕ«%a	~0[mOŠ:îm ÕeJÐŸ?'EJ$ËNáRÅÎ.´÷ù¸ËSFÅ.›dNBt$6úðO©£Šzª„¯Òå@žÄŠº|Ò±ì’IO1þžúÜ¬rý?hyQsÍ>7…ó[‰cäâÓ'TÐ‡^«¢Vw¦z–‚dIr~Ý$zÄïô#68¤»bWÔ@!š,ß_§G4Œ¤ÞãNâCPH'qÖö¶‹šÊÅ¨¿ans±£W–éÛRf3lu3f{~½t[iOG¡ê¯¯³óLšÐÂ³ÔÉõSÙõhÑzl)1­ü Ÿ¬Ù ïÇdí»;³ì²Tzw	*=Úuc7ö©’ínçÕ3›Ð´>Fös—øÛžµÂ`®ÿSøV»#NJ¢†èX`¡ZT$¡SE§à;›ÊUâZ¹Ù9ãÃ Ù»îŠL<GÐYe'ð86Ÿ³E žTÇé}³øTÞ1ê°üòs¥ˆ4‹ÚÝiÃ& IkŒ´×xF¢n×nË™0‰-àÀÞ†Çæ~ˆˆ¶ÎŠÃƒ»yF—-wsË$ÛlÖçžqäÜ°ðß™°4‡ÿœ—jS‹9ønù&x›^^•ëIÕÑ PÓzË“ñnÂüä£ÓêÚP0#‚U\!vß§î„U@Ú_;ÃC
æXÇöàño£—É€¸·[Y_Ïaú ¯qòE/³Ûõ—Y_£BVQç<IªTyúýj`Lb%_—"\ÿýû
9¦HÿÔx!'…f®obµêŒ—„ÕÛ×£cøUôÚÆ<êPcûZ°'RÚ–VùbÃêí U#w&o>Ñ5©€ÂSñÇN‘qîÄä}¿—$fOîŸûwð5Q´6ä†Ñ‚ÓŒeªXH.ëe¯h±ËèM¢U±6sì¶ÓXs¸Ðép-/Ï‡ä5·ÅG›ÓEI/7l4+NSø3²k^]1YÉäuÌòf?C½±Iudø=*œhþmŒ æÄ-ôg¨Ù€ÁLí½šÕ
>e%­"¦0¥²·¾-N¨.7Ÿo6MM©ädétÿ7÷Uó›Ô²¢H5Ã_<—¨sßõ’æh×ý„0%ƒz]Ì*–¬R*° ªÈ°SþV|]ß½DëGê®¯õŒC%2Þä€2W.’+ÎcÚÒ,7ái`5Ÿs¨š7bV²ÑWšˆp5¿/Ê‡õcš2À‘_àüH9ý+=­{Ï·ÇÚêªÍC£àÉž«/Ò §%¨SñKÛÿ‡·* ná4!zê˜ÛÐA„#>»XA™…¥+©ôsé+ÞHh“äH¬žQ£¿µ9î(XO‘nÎ;ÍžÓdÍ4rSä2í¨%0ýâÓQoÈA3*]:ã8†•½› ƒÓÌ Ñ¹‰?%ÿ®.‡M]|:d!uiÞÍ•]óy,à!nz$nYp¹Ë+RsáÀËn:¤Ïô?®²gÜ;‹+n“ª‚Í¼á5”•³³÷»Ð^çŠ–<¾ÜzÌ<ÂÇx\º…,(ØhãÊd¹c1£b$xBÃ­À]1Ä|e¡OÂ±ìµþ_¾]±…yÉp?1Ûãà7ê™®iY-ù ûSq/
“ËÒ>›‰VìªªEØ¥’¸ã_¦þ_áè­÷ZPZ+w1=î@IŒÆ³ÖXÔÞaoÂ%xFj>Ïå	|ÑŸq\îýòœ9Ñ2FízÙs@e(j:‡kœT€ËÁÙ…ýÜk"qR¢?MËÿn.”À+ E;V"éÊð‰#UN_©5ßÒWyÖÃ;N‚¬gè7óªÕÃ%$ô“ƒí-ÃìúÊÖ€YE^–Ë0?ßGÚrT-2AJ0;`y—·ªh ò®g—®MÅÁ8Ó+Ë:3Ðhâf¨xuÂ¢
Ãp(&3î!ù@Ýœ…ä¥‘ïjœ™œ®²¸˜OÞ|+­xäVn-“å¶JÈrº`1.^ë9Úd ŒCÞ2*)#‚‰pð…'dA1íÝªÕsör¾…AUá¡Áë¿BŒä”D¸A€½Œ¨hÄ»Û«Çb=L+)qšm(ºf˜0ƒ/{"@®#~m´JT~C•kIì²À)Ó]¾9NvÎTÇ
ôFnwªÛÅg"ë!Þø¿n@úÉ™ŠøBwuc Í²¾·˜üHhHG>èÓØ*(üºŠÃ4;ïO²”ôí.t(TVàÎµÚäÀDÊýË‰ÌYë³méæ›¡½?åLë¾üÖqé?y²T0ë±û{ó_T•ÝMI¨ã†°ì<5‰&˜>Äfa$Ï%ª®“Uª-¯ÎàÛ€bIŒìŸ 3w;®º9m~|¬0!’E¯YÕÅÀ$xÆ,>¯ÐcýOV¦Ø
ƒÇ3È”¶Ž×ÛZóP#ó<Ä}Kóâ(ü‹1ž¿çÁM-*¹a[7 ¯dXÕÖx+²Ð+ÛPuq‚ªÚ
ËWG€ÿTNU‰6{^B”Ø‰ÁôžôCOí>œÁ@åZX]zFtÒwDÉ7!‚±Øž˜(sgáÛ¬œl?/5Ð¹lg\¡/pßJ;öÂ¶æ˜ošÕw	+s²ÆMWu·€ D£9Ã§X®mØƒ%Oh¼Û°iw’”žÒ¡¯g#fQ¢êÙÎW<ÕŒí›Uš¼1¡ž¾®{7íW6¥g{)ÊÊv¦/³ï’Æ¤÷}ÑƒvŠJ¶æ®õ[îŸf£û5ÐÖÛL—ýñ"¨$Ë±¼×i£XõO¹£Ž­jlÙ@g˜²ÎQ˜%:‰‚D1DØó[´5æ2 ¬Ú…Ÿ¥¹¶Ýu»OœªÅyà!—n6†W–æMã^•!ý9µo~?ûÜ&ÅQõ28î„cë„#;	‹R*ð›©mv#rrë!ù×JGv…ôtŒê¢Y `pÞì˜I~’ñ¶x*ô zëŸ\÷·ÙXPÆ²s—?«0´þ´îÜÃ·úBTz¯±üŒ/>£*rÎèNûroO–ï—»Od«×b¦ÞM
&4vè|œ¤ó¸è­t£Mx+ýðô1~.G²è¯s Ý¼Øqêxò¢W…r‹¼‡ÍÜú× #œ ³e÷lþþŠiöçl_Ë³ûÿXÖP«xCúsðžU ×¸8¥ØŒÙa=iÊ†o‚›L´6Úãé!roŽò- êP®>ãOY„Î®OálÞŠ¿õøaV-;®XœÁW"Ÿ–+X4>Æi@JF®Hn)Ò¹Ý‚ì+[ýÁÏ¥cRzkË®	+{D0SjICoCh³láÁ6ë«B§gá·]’L	jl:½Ì¦+¥E²ÚêR¡üKL;b—¦þ¯“­ËAËžþ–¼òyŒËûFHÖ’-„ª‰d.J‹a‹Äo÷ãúÁ€€„º5Ó{ðšÊXÜÇâT<U‚¼5ºŠÐ_Æµ7½¥§ÃQD‡C¹3h¿Š„î,ïZ ;‡lHxÙV1Ýòûm¶$€[¸ÇPHOð%ÀmôÝ\pØãm5â™ÖŠ…¹]fœ•Ÿ–AqI±0uÊpÿ#B>);¿ßR&ìD+î¸ª%péÁ]ý+u¼ÉöXÑÆ‡”B1ËctÐ“cGy¦–;P”6ÜcÔ»Kr{íøÝ“k•á‹o¿¢‰fm™ïË‚6ÎC¹I±‚¶‘2‘ü+~QmYð~•läñ¯/b÷,‘Ëý`Om¦?­?•!Ílmê c8Ý’¨”ëW;àåš0…zôÌË4_K ê¾jµ#LK„trx¶"ÒöI	›Ü•…˜AxíšOã±Õæüü/Žø‘ý|Äö ï“¸¿=¤  ç÷(˜S49Rr	È¤·ùa%–¼t¾UÃCâØð±‘4q{uµ$4,ÓT»š ÒU+Žé¡üéçhž±9àò0Dï°/™Ü~8U1?¸ÿ4ø[5=¼ÏòyÔÂÝV•©«¥ÊHÄƒœ™_Oáõ=û4[	Y#S°Øé:ŒáÑÀÆl»åÀñ+.‰iyOKàØ»†µ'p"š2š…
¯bveù‰$êîíÅ¶øãd\VRfö¸Uj¼Œõ„A1t¬ Ýx8Ï­iŠÝ~wYm‡}Ä§ÎÁ±Äñ#,rÎ&nóSX.–. î;‡†ÊøcÜÄ©³þß¬õZÈ¼*Ñ0ù5–\0¸ÂWò¤ÈVåuó|'eZtO…,Tä{Ý¦z¬¿ÃÌôã¥uyDµHÕsHÁCPÔb!Ÿ+Ø]³²Ãþë€×C‘|E™1ó®é›n,9½	·ú6ï¯LÕ‡ÿmDæüý$´?¼Ô¯‚ÝK
X	ˆÒQÀ¦1ƒl˜­ìÍdÆâÓÕ·Á^¬roaŒí‹uÉi‰Ë’È	e»‰QÁá[ÿÄá‹Ë‡>=']Ô?ùòräÿÄy£nçìæ<–æÆäÖJÂ—¢Î¨£(V{™¶Go`u	}‹ÎdäÄ!¨x°‚+@+ÿ±>¾R]7Æ%‡r¬RèØCÿ6ä¶R‘ì­ý½ŒQ¾WÑîÐÇuxŠÒëx‘Øÿ•x£8/“„D†Î}£ ²‘t®Žßo—
áfünn*Ò,Æ6Ë§öOUúÚÂEùA¦s†_ÿ¬‡ùwF|Z–¢
ÚyéÉ3ˆ”q‡á‡kù~œë!Šq3+øÚµ+¼¬Ð×|Î·ýmï³÷ìôf	ìÖ2´—º^*Söò4¥g?â±0 yÃÍµ2ÅÝ[rÑ‘ÃKA~ó5L0·ûBþ 5VˆÐ=ë×¨
/Ä—ËÑÿ5,Bˆdþ!ù…KTY¬Œ9è‘0ú)Ô4
!)<ØÂWÒóðÈ*
^<[ÏŒ9áþóå½œû§|ªv„	jÍ~Ö'‹á¸6-cL¤d÷Jyµnš€D¨RLcÂÛÚ‘C.,7Ô,zÈþG4[«ã˜J
ZwÌE¼‘â‡ÛoÁ08ù¡x+wœ¼n@VßÌú[I‘›ÎÄ^²D}'ÿyÇle¨ŽíûÙÿÚÏÄ7Ã¢g¡ÌJÃëáÚÂUòÏæ>aVõXfK7(8¥ñ#¼-³™ouñl¹é"Ùàq6lÝæ( ˜GfúºÙ#MU¢MH
®»êšFØPßrMWæÔ†–ö­G’2VöÀšöÉr  •Dúc±\»BÑF¡BÀ%p­Û_³Ø~ÌóŽ¥|Kµy‰–w$QÎÒ†+ì¡‰\‘6\flÈ Îà†¹ Ôïô„ã5ŠÎ¥câÈ Ëòƒ"«½LY‹0°æÒßãZ>€Pˆ°ÄXE²åË´),/‘›(º
S÷œºÕAïÀü±ÅV^ðknÐg;w£	X	Ð])J¨
â¼z]\-4HiÙý0+Ist9¦
´–nbdH™ÛmÓU¹Óò5‹–Ã`¤ÊÞZ”‡3åüh…ÏÆ#–2Îçü°Eþ§<}¾ÙLçÍ^§Á¨ÁÚ¢«_2Á¨iïwÙ„)ž}eDs…*¡
Õ‹tôä\ØÑî¨D´6ð\ZìÍ·‡ÝîV$ƒZ
õý·‹ @Ú!¿*êª4Ù >µàhÔžl-}j@ÿ¯½ö0üª/S7É¼%oáM”‹¶x¦YºJ¦‚ÌC© HšxV´Sî–U"Ú ÉV¸Hg8ÎÎ|š¥šUuR¥FÒbDºBÉÝÑÇa5©_Ø‹W¹4¢ê7Ÿ–ÿÖ€±ÈÚ\ä%üDÎ?áëçëc?#§¥u\™A"ü˜ è… Û+…Ö `ûÓ¶
Ä@Uêëª8 ¶…¸S6‹?VP;®|v³}Êôh¿ˆÉÑc'Ú928\¥€þõ—3À ð3ÖBWÇ¶_Ì°ßzÍ){N)ojÉ‡”—Ð”Q¾™³5þ®/-¾îT{täúA@JzÊÙÇ!úÅÌv§ßÖyR“#1ƒiŠîB®c³ÿA"5;‰á)|fs–©ip!}
~ÅAu$¶ÊŠ'AÚJX&ï»Ïéèœ1âìAÒ;Öí<.Gp@ÈCú?Xú^ŠÜ‹ø´õ_BJÉùq:”+ë9n}”d½H%æ1A‚ŒÜnËÙŸ †âzéNiïW2–ˆƒ³LœÔóØ8&ë9îÊ×ÒŸÑÅ*‹E$}3›wÃõ<–O(Ã\¢Q0ÄË‘BíB«ZÂ¶ó”áR‹ð¯ §)ý 8ï½˜Ãð=°KC1Ù„`-Ë¿Ðî SÖØ©öIìÈóé½8é:ä¸d÷‘mœµÜ¾Ÿãý8zSýDcHˆ¹á×¼l ¶_ÛŒ0öâ‰‰œjfìVJñŽ`(~Ø¯ÕÐ+®D<‹ÎY†dÒyÌ_á—oØ¡­»ìLÍ	‚÷µ>Ù’’e™æît¬³9·¬°sÔîfqýx‘M4~ƒVÿ@›£†4ÿ ‘’.5RthpôÚvVÈ¤Fƒè'8íâå†“ñÉr“B‘´à‡•s»öl·3Ì´FÈÑ…ŒÏœtìI|ê15®Ù"ò0Ì4ªÆñ¢TÎÚ(Òª`zÅï”0¦·HÌNE=ò8e,aŽ{}r;¦îE~GéXëûœç.±ÞÖ¯”A)tšêÌØ`mÙèmÖã¨–ðá0.„ÉÂV˜cÊ”;-÷éÓ:	åN¯øÔÈ÷ùnr÷‹°º5y°:ÅßK¤?žuNâìÔXôaâŽþÖS+¯\pc^íwÛÕª¿;õH4ÐgBè]‰*²Ú ]8©X¹¾¥UI¸k‘H›ð4¼ÚP$ÄoÝ¨ÑÒ55õúþªû•L,ó_Íi	´ø äsòŠ[Tå°†YÞÿÐæÑåšð„Ôè)Uáiø|Òžžvòè>[v¢ÈæÌa¤6s	sé:»=\É¡Í9sÙÈô[u,xúuPjÊ’!N”¹{œ,ê5E¹L¤\?|‚É	Cô.¥ppyV´·6Þ¨<Þ‘À:	]÷O.Ö<{uDÇEô~+Þ}z~9Nf0Š<”çäŸ5×ºMSt²Vzéå=Xõ’ìôÙ‰8F¶”O(j1õµ†8¨9ÜPß<Ÿ£ñàæKSÍœ z•Iø'×=UíO;€â€]7œ…6X¬±Ìž-ªO%ÂÍ’nÎªÜneøLê‡ÅÙUhf	ÓvÚ!–ì<Å:´ˆä0 søú™^lA)jß¸¢g+]iÈ+[ia[í¥ Á$ÆœE>è¹s­ÚÍ€y+Ž†7ÕÀDMz7‰×-Œì*pÝç½»©`ª’Þ:õç2w?tcÜÊ·2dõ9ìÒ„·ëÀÖEÄ ²ºð¬~0Xù U¹›Í²W“à´Ø5$ÒŽ¬=gq]§"c-ôØDaÝÚøÄ8¿w¾ª·ªb¹¿M-iUHL€Š˜‹ÄÌB…†×$6ªëSø«§]›’:XëH­cfçÊpæjØRÎëÅ—NÐÀ§™*×î©ZÂŸD–…`Ö/Ë2ß¯ÑAam‘RPÙ'àlc!‰_Õ63%Š£%î$ôØ¾R¡8ß÷F¤OM9ŠQ˜Ä¨µÇ;ú*”êåµ(½àÃH¥¡AÚ×ò
V©nwÂ$PrÛŠ]½‚Â
åå“û@Ñ+š¬‹õHn'¾$äÊ!˜‘¹ãÎ¬3lÕz ^Kˆ_jïºZx™pE´œåÌ€‡îJÝKŒ‚¬åÉ”&°Úˆ<cÞ-òž-*ù©k:ûŸ¸fEA¹û¥(ÌhÆŸÇJÌôŠ®’²—¨ž4ÁggEý½=ûgÿˆ†I6ù§=JKaî3‡ûªð¾2Ç¹%ÎV)†ÊÍ§·’¹ô_Ó²úÆ“#½¬Ý-]]M5‘´JÓÉÚ‘.+ùý°¦J¿‡î´©º÷bõ'êOÆóŸÅûj-ùe,ïR¢M¥f	{ ’[Ð'¥b‡¡#ûðË‡à?Ùh5âõûêßOIPÃ‡í¦¾/lœR%#îv­»´A­Ä]t={§;þÛ4	|‡¯KºÅö1Â ¤lje¹zù/ƒ¦†K=Í2?á[Z³eU"Ÿôé0…ä¯â^×:	Àq‘þôÓú÷$ÔKÜÚ†A™Mà‹PÿG”3Ši{ê ÂëM,r,ªrÊ][JVµ¸ÇRvßûo¦Í¿‘ù8÷»¤ü(¼ÙC ÎÓ ñž6è˜¹`ƒçü4Žž­íbñöi+/,PX§:	†woYä ÍˆXIÏxRïnÍb>a)Äùw2âcvÇ°¨Ïœ—.¢œbEftF^*9wÿ«'{!ïž³yd¥1
r‘d¤]?ÀæYÏ“+MºDãÊ/ª5íøbÛà—b$½¨ƒ8.‚$bp_¸YjˆíWÞÁPK¢ãF^kW¹³¤p™E‹hønô„YÈž¨^
W	pÿ ÀWÁ<Á×ƒH,ýÝeÛ ?>+x6½Ç®×3!zÐ»Zÿ^˜+ðN2Ø3X.!§ò’ÓNÛZ¢1Â7Ñ¬9E¹”rè.oSIPqb”~þ`³øÂÉãÿn'KW@¬#P‡B†.¨!Ó_‰H$›”	åÍ“ÉÇâ„¢j?\žžÍ©¢V4)-oíÀóAàèŠEr½‚Þzê³È]ùEMF´`p /µ›éJ1Ú™6™šÜýTìL¼\‰—ñ(ª¶¸›.µ~8oÅ•pæ!/ù’SS.þ²æ¹/çrt»õ†h„ÏÃCÔ‘‰<bdPØZÜó~pMêƒnÅ‹0ß!‘ñ¤HA¡pà"R«Rf¼C¶<ÆÌ¡–©³‰À¾Ý
Õ\ØÆ½ÑyòE\IJ.ßâ }=/ìF&©[?òû©SZÈ ìÑÿ*äà¥>"²ã=)G9“·ë;M	ã%™"¥Qž-/"Õ¥ÚÞ×¹I€J/Ôzzå6¶Ö‡$–2±Rv|U>MzÊ™%9‰çã½§%x:öÒ#Á@)‘iEáŸ”,½+ÀÌY°ÌíYFƒ/ð9¹EÁ‹®ô² q
@ IÍÈDç,<…ï*§ËZÇ†¦i,°{nKg$ãdB
N.°†x¹ýê¡½ÐÇ)€‚²kRgèŸ•ƒÄf£ª}.§ª3ÕoU]Z5õQé[M×EÞV}P¼ºð/@ÒDaÌžPÀ’KG{@&i}½-S•œqÕ¶v•ºöífÓ@ã¤#E‹››Ëzœ3šè\sø\ýô&€GXØtM$e)˜ØÄ„;´6r¥ÍŒèN.$W²hâìo$ÿ^Àü>¼qÑàHŸ
Z`‰Žlîç3D‰s½v­ñ™ÉøBÂît·‚æ6ÅŒœ‚é;íz]­.®|J>ÈÔ#ÛI¯ä®_Éº‘¾dèQ„¦›Ì»áù¸9D½s;	{¥"@çì+o1Á2d'é(œãtÐ-¯ÛöÒƒ‹‹3Z%…ö¡ð££ ÆŸùÿ¤½¯–ìiŸÊDmÏQ}å‚i ûê™v¹}a3ZLñÖÃ¿þç¬â·äçÞ$Jå¥U}+¶CÍï9ÖÌ~RÓx³qi0]sSZ,°éã¦dy÷	mðB~µµÒÿPŽÓa9¢’d× „¥È ›¸¢hÍF°8ŒXûèY­N~ŠmÀgêŒ…ÏêA&cëE÷71@Ë”ïb[w 1S#•¾EÌòlB‹¶ìÉé‚ÎR"~› €Q°z—ˆôuh>Ø3)Á'}×ÙÛEÏ¯‰än0¾ì‘žHB»Ù‘Jé\—È‡J_`Ç3šò\±YNC»S#‡DË5máù¤:µJá°ß¾‡JéËôåSú.™ÅyJž{½ù­æ¹a‡„'«v"HVŽ¬Ø'õ-Ážƒ&§n£a®zY—È
î¦œ™ð0u)PKö†u?Š{Y”.5Üœ05îÀš!JÀ†($àòM 5ÈÐ¶q£`ž¤‚%F¤Âp`ÂH)•v¬Aê½ØØƒÍ(†…4Dv¨´ìë¶eL'ÊžE×†1¹-xTš\Æë¨Û,éá°<Y¨zÿ;þ¹Òúô±¨ND€ëŠÃÖ î1ÂEÊl
WÐ#úÊjâ®‘íÌ-zÂd;ëŸ“2¥²Ø´¥kóÄ)F“ïÂkª\‡ÿ¯w«E…Ýk{:/ŽeµÞ	¬UÍùé¾ÔàéBX{}U…(ÌãùB+i×íÆ»9ÞJdÀìYbÆÊ9§ýÏçIZð¸
Üéóªj­zšÛa˜ØÁ^)H‰]ßÅñÅjµÍmèÞz,ŒP„U±²’²Ëûº±xãÞ¾ày£*;Ä¿»Ü/Cz~S·ÒYN_#=`ešyŽj•åfCŸ?^~Ï¯AHÙ¬sÓ)jÎ–â‰pµûbÙ—EÆ´íÕ«!dÐ™×æ†ž¹€ží¢Dé!6¬‚ýbí¸wØåm«wÇ€µcû‡Ê¸R4]8¢uBÛ®†^ç¯b&+8ùÞhj³°J~IŸÂ2ð–‡£?®‰$pòõòïÜ‘ È“ö'ù :ax?êÕŸÿyþÖ„,¥„òA~7ƒÁøÁ@è^\HT‡ºcm” ‚°_C„Ú‹I×,gû™	LÅÃ9˜óäÌÄ4îäm¯fsyŠ'sL]ˆÌ
‹…íkö€¬ÄÇåâÄï“ð¬øâà:H{=W¦éBg›‰åø|:Ö¾8à8eFˆàÌ¿ÙÁÕy>Æ¯þ°Ö*üxnpŸøD7¹€Û 		`"4$¢kG•Éú4ÆŒ¥°uÃ›+¡ãÎ/á„þ!‹˜ ¥Ÿ¼¼8,åë	
à¥¬‰}å#´“ù„l)t^ý_Býž—úËÛ.ÉÒ•¸ê¼™±ZôèÑ¹s2ÑOýŒ›‘ƒâˆG£¿ñÑLþ=à©7ƒ”+`g«"ÀHTëdç½h+5™+¹ÞÏUÃ§_p½\„£‚çjWÄLp•¯RyBdIÃ"j¼©3aQÄSNŒ J%¯LÂAÆwÖv¼;«}¹m±™|V@¯§ùJD7Ûa&?ýÝÄVø®‚Û1­M†4¬¢æÞ—ônº¦ÁOÑñcãý@Ùš°¹¿‡q|­ßÅ£&¯d@Hå#É¦RòF§E¼èh|Ø“xdx—ˆ‚YL4gó‘„ÞÌEB‚ÿõ’U‹LØè"•U½pµº	¡Q–œÓ¶ Šc=O	Ø;íu*Ø=¶‰oTøûŠ~	Ýªþ-*ýÌHÖº/Õõó÷6’{‚’–ÜãCE‘³JÞ¼µA=Ñµ`#@ôÎ¦¬AQ•fëZ8¶_•"¤.lf<TU{¹Dƒ_Îy7”‹$ E&?0‹D“—½µf4XÒQ
?:@· Nz4ìâ¨ˆ¾úÒQ*kÈ¤«yÞxÒ>?PRDŽ]:úŸ£9s%`'ÌŸïÁÇƒ€ÕdÁ¸25|ûrb:Ž©]s*F‰oR¡lö¬ä<Ÿká¿Š¼‰¼J0°§(êñ«÷Ó¦ni[?|®Nû(¶‹í9]ê‰}nôÚô•LçèPº„+ Q86×ôqv¨=Udz­ënÏ»tt“Ae=íÒ!K_Pù-X¼†eÐÚÎxš¹\,Çßæ™ŸaS>;À÷¶Æé+ŽÈb:@šo9ð–7•ÚbŽÐOAx6Ë¶öÍ]Ûú±ƒÄ¨•‰Àüª”¹ñR&Fv,ªˆøÁ+uŒZyë»ÆÇi&×™8ü(Î<¬CëL3Ô-2Ò‰™s?¤ážÿ£n&HªÓhÑ4UŠæç‹*)FQTŒSŽ»³‰¨fAiû‘™mÓÿ"ql“V²U #«ÃïëÃçÖ
NÄÙd¥C!uEGÍ0“Úc’"t€Wm†Ø[%èÀœ1üCké$‰cË{Í¹°3§Õ'Þ„û£¤iJDŒûkIŠq¶+Ù¼ä©3cvÄ‘ÉÌ4TÑ`¼ÄâÚý_#Ñ±aCnerÔ×#hÅÐ^ÛtFOà²Þ/*[Ž|´í¨NÈ¨+ËõqÞ^gØ—ôv“Æ›?ó¼åzß4è7oîš‰cä+Ø âa÷ØþO5S|.ù"
Ÿ«³¿E-ð Ÿ3Ë<µÙ»?Ùñ]­ƒÑœ¦BY$(™­õÞl'ë@ Jpç¾9_è©fŸ©êð!ë†îlŽPž¶ç…í”¼_ŠiÈ`÷ý€„…½™ñ§òÌÂ¯9X'ÓÞfŒÃ£}æ³Ÿ¼¶cuc-QÊ3„Ü*=b8]À†ÙºOlëÐXI³^}BvuŒSìè)¬+¼!ì¥Tz_kä›!Åé)Æ-€ÃÜºf	‚nrºL‘-1YÒ¨~¬‚á@*7Þ;ÙµKq[+N Ü€_ˆ—®‘qæ²×‘æádëÿ–‘hÎÞ¾^Ž #ce_é`
`m3ø©©Ûv½Ç$¾6]™õ5LËõ€+D¸kŒE	9£»Àr…ø=ÉežDzÄ´ÅUig™¦c–zrrR”‚“6iqð6NÞ2¯É¯¼ÎžµþîÉq-7lÓ.7¥}ÉL™©+þ‘
wç›n2LÉéî¢Øh.mæØ¤âNq §½!SX©å!‚ÊÊÅ7v}„Ú$÷—H]`X^—zå¼9*ÿ¬‰{WHqËCÂ$ÊØ£*‰bŸŸŒBŠ	éÊÙv/e@ÖùÅJŸªŸNÕîéÝL¹A_þŸ®ºŠHºaÏ¿xˆ¹:¼TGL ¦$²3*QÞ;:’*•$·7ÔÇê-úº–IašbtkSÉu‡45±zÒlÿ	Î~q{k¹<·#}èÙh‚9¢UfG&4ÔaRÒ´‘67Eœ—Ð@ÊN“ŽüÅ@2vöfé
*û‰VkžVË"K^¨Ÿù:LÂ…TËUy¨Eq%Jðôå— ‰¥ÌŸXS¥É6ß:!#çÌ˜Gßknk¡Å§¼ß‰<Pì
Ð/¥âe®iü2±w˜Žÿ B¯¡ôn6¡×”;©5	~©Õï‘	¾ßÿÉ‘+G’“ë¯ˆº»e„'Î>«Vò’µ–9l(¹!ÞGaíøÜFÙ˜u†æ‡él9ßT Ëîk¿_W;˜Â{À=ÍtQ¤®+Ý¦üÍJÑ/tq­7H–~+ÌÙ¢A‰›^¹Ð$=Äÿ±ÒblãüI=cØÍœ*F´VáªlEÔ@fÞ…a^OR~¬çHJK?7¾’3P¡ÉÄü>ZxäæQU7-`~=";g:ÃŒÀ]æ” s]¤†iyØŠ‰Tå­ZÐŽ	¤ì:ê‘P[	€/»_½”>›ÀôÔ°ŒÜ>òå³²Q³ZÞìR§"Y,Eš¸ÖÈhÍ8³äWÝ“Áô9æ(–L²…Ð½D«¢ÿ!~ø­FÆ°ß‚ž]Õ.4“‹^s“ôL—UIq]µhD‘Âƒˆ/Õ°Ë)iÈb–iMÙ¹¹™7OÍªcÁôž‚Ëþ)-ßµY)ÕˆVÇ´ì‡™ZÅ kñgØbÙtYˆðZ£«Ì›—1Ê¯L$©©Æ Þ¥ÖÜ¥›_ÒyÅÍ²±#ZBÞ$¬&Ð³íËf¥%zÒÏZÖø?tŠŠNÒûk0Ÿ¬C‰ŸQ(y]&ƒíG'ÄÓ±åŒT¸ñîÈ¸w’ÄsòÔUã¯ V__N¾3øKAËæ[É,m·)4	;öèìub(°„Æ?¢¾Å*,ï"ÅÃxÏg×©¹<e–Ô[
e‰èÚÿ•¦„!»¼”ÏáëöHsÒ1E:h›ÚIFªÅî_E)ØOœ§+æçÐšn‹¾oP³£¬gCèñCøeÒ>,žÆ0´EXé×Äl4ü–·d÷\;{ÐÝ˜è´¨jé±ˆÿR?òë	æ¤©8Å%¨*Á3ßÀsH…¼®SHæFT‡KP|zòªvYXÐÛxä
•T‰úÛú0å3'BÁI[}•c†e°%9×ñgå”,C·ýö·K‰$Ž$JÃ¦[!ÇaÚ’­)ôŒL¢<0q×aÃ´˜Z¶íì››¸PÝï€òo(þž!¬e£òz%júüÝ	‚´¤Æ.¿±ðZdçVTd û»#m2¨žÅ»aX¾æs]ÿrÞ#& AN—¹³¿Þ«f+léû‹…W
7#CÞ³”ÙTÏ…#+ŽÉ›ÁßBË¹ü!¤ìà<0C~,Øl–K:5Çÿ#âçýüï¨®†ª1a|ÉÇeª€ÿØ½P=‰½[µ.r5þJwªå}ò%ÍÍÌÃ^ÞE»A•µªA)²Š¢KlÒŒX>gNk?âÑyPL÷‰…“ž‘>ÈY²h…~€x~³Íµ¦Z®Ç_3//õ¨[7 e†‡3YAÄ¡‹ÒÌ‰è2c	¸_õIåi˜‰]<cˆK':¿:à—ÏåìèÄz2	Wî
æçuü„Ëž6%Þ„@>+.@Òü…ø^w†	 ^Z|·Èë2@Ÿs4y¶Û!E ’É&&ØuàHþR4pŠ{0 À‚r{èìÏ¶~Ö†ê®Å²ƒÊ—Ù¡'¼ÞVí-ŒnŽK^qý …Ñ(,‰ýƒ#ûÈÂÏÀmþct$·g 17'°1ðû+·—˜Î"5£¬K:ˆ:keÙjæÍ	Ç‰LØ~^Ií[–F·Ðš1rƒœØTSÌ(¢Îlõ=~‘)ÙÄ-éïŠag]|1áÔNcÛ7ÿ)È Î~›ÄQ+/Bf™Çh2;[y¨ºÂôæƒ]ºôV€ØáNz³E5{#‰+ÉPè°©C`yˆÕÀþó-ƒú|o>ŸöÏ’}ª¨µiÈ|ï«¶Žùƒj£–vî3ä>Ê³á-,ÇFßþ¥¾³‡–%	Ñ °¨6iQkéa¡Âº¢±—*÷xPÛç.k€ƒG<lAf­è¡[tnê‚ß\ûêáá]›âM€U¶Ê)jžž[M` |Í”½æ®cµ*-TTÈ à]êt–Y,.)ô¯ÍÓO!É¸wipPdµnØñ.=õyÄúmÇ…Æ£ÕR~‘Ô×¤Õ	òsb“éÓèäHÁ†&HÎ-ã³ SÚR“XvRÀÁ¾F©‰ÑM8µìèG%Ë5UÏw/ÃÉîw§”$úk7Úôn¯b~\ËËCRw‡Tpà/®i¬Æ)•Ôê+p¨ï‹V·G-tèÐ{ÏkõJ‘9ü™r[FeÃžU‰%bÆ·,¯,O-¸Ž•bf=–ÎŒÁ–$•SJùœ%À²$íÏx;e@ûêFó¡G`¦HCW¬Z…º&èæåO8F†-2'éHð|G;µ¾·Ö%ÞÈBÓ© ôW¾ÉB>0Þ’hžæ×â›ÑÇþú£°*íWçm	Iåþ#-þÑMòT9ÂÜZ¸€”;SÒ.No@&ú¹…Ã#‹ÜKïåËÉÄg`¢ÔÉ~ëEÀS™¾„”ÉÍÒ0~* Yeª×r1’o¡Çê Ò­sÐJ²+Š>Y6¿Yk‹5 Tpò¶Ó'ê\Ñc˜)u”‰Op—ãR‰]B,.kÛæpÄœ¤ýÐã[.Œ# ‚NIã'7çlÅwÓçxb•ªp»„3“:pSÍwn^	¾’g©äq¶†gãÀ1ùe®†Tn¹†˜âàÊÉºôŒ|üv–ñý²€¥úU$ï¥[DøÏ¾”C²	( ðú´ä¡îZÆ˜‘ÏvÐ5Ò7ƒ¢!ÎwJbÿô¸‘Ï<žyÇ1“°€M”[<…"ûß…{wwYU»ðYo€7üÀÑ0#/–iTCh¤üº=!Ê¢F^³p%<Ú‚ßX?3#/²9ÈŠãW…é8ÅÙ¹¦"5\A}Û®ŸØäþ=¨Ùëg	´…¼tlJ†Úêã"…Ø8öµeêíLX%áˆ³¼¹µ’mL÷W‘ú“#±¼érÜNs&Ì€¬yo“ÐTA—Œ™ñC¿ÊùÂ¹òí1ò•œ±È#Øo¤&I‘ˆU}s¦¿=xëvg<¹ÜÑÊ ‘¹ð ü¡›÷8çØ]Í#Ò÷¾´^œ7ÄþS´ÄØx'Ö$ÅÀ ‘1¸÷ô<ódÜ©¦
v„£B°‘¸QÇL;·é]ZPsÎ8û·rWŒ´ß¹ÜÙ„ïf²î¯nš½î-ù¯o*Qç!;`º?à€¹{Lÿ3€0\Ž8ÑÙG«©´PPK-(\V§Ã^©œ÷dný½?„(ay±é{ÁmOPíA!›Þ«i.AAØyÉ4]úBº;$«—n¬»¤’49¶”s#+II‚n‡©	ˆ*w=&ZÓ?m
Á†Åÿ¦pGtž2Šañæ<ó¥Ëß÷ü¡»ûÜ:"ˆ”¨dÄµS²ÕyÜÑ®ð‚ôrsÛÓ\pqíä§†w”ôp(…ûƒÇÅ_Ë8Ý$€¢ïì…ÕiÅ!VK¡D"½’!Yž]î¥]§,+rCÇšò1¯N×™o\Iè{¬8üí'¾o_&ÿ.hÅÊQð=Âß!Î2¹f4øÍ8þ-æ' mÎäDy2xa{ˆã¦T‹@–%:µªh˜ÖƒêO¡­;ø“‘\`ÂÁ+]|,é¼Ãüâþ²ŒÇõšx…ì'šË -\|Ž=¹}¹æfvªcX¨åªÜÚEzSÊgãò¯/Ž½+Ìw¨†^ýrV±‡;[c¡ÞikEM]Füpuþ33Ë«ÜR	ëO^¥ÃåáI÷À'a,l®Š³ªú)³ù\æÄÃ®f$èòí;åÇcFôÐõ~ƒ y¬Sr	97ýN#«µH¸Â1«¯8ç• JÜôÑsžqìJÄ^Sþ–eûä‰§šÑ`\;ó¡<>}1YO¤÷À‘A…ð•„†ú€kƒ(U‰bX•n”ˆÑÆŽÝ§ž8X$(î¨¯é)lQ ÂÚƒpò°ø¿„ßn+ödO0>Ù<'W”TxW/ûrŸí#˜ð¥W)7ïT.û¹~,F¼‚ã	Úw^RÎNA-;dÅ,
­3Uœˆƒ˜AÅ‡½Ë
 Ôä26çÀ…(íÀ³í—ÐšÊ%7S©Ï”ª”h_&	4!gB'Ç1ˆ¾ÈuU˜ ¾Gsh«${
K„?V¦¦™¯Î`àãéŸ«^ôDnµˆkÌ‘~wµù‚~ÁX%hñÔ6Rµ;TÄšI	^¿çw‹xö.ð…0nGˆ”¯ziæÌÿsÄ£½Í¬ÙkQö|Gù«7Û¦Æd:vÞ¤\«Â\³6!VôîÈnea_<˜ß>¥|yZxàÕ¹öä­‚/ÆçÀ'GýÀ&ÿÌ‘xèë–aðw6ªŽ,º™Íµ¾På…8¦­£n¦¸mrIæ[5|¼%óòÐ‚Š1XÑð¨·và]#` ‘¹ÿyåÔ7a]Uƒ.Ø£¸ôÔÆÄ¹~:šÛ^ûÜð•ï{˜ÔOÐ6à-Œc[dYÛ%  ßžÚzz9uV)wìò„ìBT#"‚¯†ÝòmhŽ÷-ãq§çþE^ê^QnJ“Âm¶D<"1ÉŸ2,-;$[–;} Üëß.Y*Á—waµ´ƒæ~˜…±Å³ìêGþÈÛý¨	VÒËsjCÔøXvñ‹'¶?¡N"_g!q0ýnØÅ«Ò85d;„UÆ¬À®TàÐ³Gò%wï“OöXúÉ‘ßEî€sWGdNß¢¿ãVÕ{~ÄÎ»gÉ„øÙd–R˜ ÅðèåU6ÄgØ„K.‹ ª
å¸Ø  ¢%{‰¯›ÜG;¡8#‡YLô2Ð@a\agFÃ?çäáý]–¬ùrô4,X›¹²ç®ä¸îEOP|–¼~ùž‹öü"£õ•—*ªÃƒE|5-*æ_üi°x Å5~¾Ô
µÐ,XÆÁïðl²t±/©ßZÃÆs"ÂÝÓ;Ý˜p\WDf“dÛUSÌÁ@s5êR­ÏÛá£¿;‡“ËŸá¼jW‰+^Êž”´ñ$a
(1æ
ÔüÉƒå£OgC0|Gíæžvý@±‘ô¢¶U­ß‡“é[³k˜cÿR“|™b8÷u68&Ç,È}‚v\		Fe™ùÑ¬’á’3£Í$qæ<TÕKÞU%sîE›±&«DZOR'tÄ-ªiå·ngŒïlØÎz-ôî3·ÅZb	´±\Ü& 	·Ësœ‚áÑpç ê•Ù1©èngKxýÔø#õÚÀvwBX{R*ì:Ë×O`°	½jx%µðA²Å:Öº<±z³(½¤5Ig™akÕ„ãú9Ó<ì™vÃS³tÎf‹qA›§Òä¨9}
Q—u'X!V,^CÅÔ‡{çír_Y,ò¯ep¹·/Þ$ˆ z´^¾z3Ä“º@z¨Xí²ûÞî¾D^xûf§Ú‹0Ûä9Ä^m‰ò'ÉlÐ!YØÔUç³C¥÷¡óÆÎ“ö©™Ûâ]:Oæ,w°˜HÒò!¦HY‹®Q-ÌD5’Éˆ»bdžÀžî¦ÊfWc¯)VÐÏžØ))†zWS¾åÑVnŒ¸Ò+xq;€vž/Ÿõÿo“×˜½^±Ð¡—¡÷.°ÙY)JsH†ó¿%"_!Î­ùfkXx	I!¡ë¨Ê‚tóÍç<SÛûyþZ“(A¬q,{RN=gÅX2GÌ%´ah]á¸u­á¶Æpc8x³ËÝÑE–awÞ-óâÿ[q\=ÿ²¬öhsgË¬à[`«91³~Èö¦B“š$“õ–ð3•åBûN¶bcBuÃí¯ô¡-¼¶$cù¸ýKóµ;&KA<[DŸu§âëjÐš_rÈ)ì"¤|Aðoö+–Al¢Ï©ýIs»+_&üù…nÂ¡—®!ºSüCòo£4ÜF…DÏ¸Óûù÷eÓ!ý‚B¸Öß´í§‰Ûe×ßë÷ºÔÊµìÄ¬ýCÑdT§È+†}Ds$Î 3Üàø×ØÍ¡¹e:·©L‰]Þµ&	<£N°ÈµÈO‘¨mŠ€FW"Ó‡È1ZR?·0õÝ91‡áI£–ò(»`²;¦
^zåˆäâ7WšgLx¡}ú(^DÌõV¿ÏNÆÚ¬@ö’ÈÛ©«EzM¾Ê¹D)ýSÏ<fï´µæaõÜô½¸hÊŸ®Dìm`·&¤á#´ w„<ÞsH“(/ôèÛÄ†DŽ%óÓa3É‡×ª«Œª#æƒ/”¬^ˆÊkq¦/øë¾ß’/@ÆøÈž£s*M–;4—¾d,kÃ´6.&Ý^É<¨¯kéud±%=U»xŠS7î£±4Úß[·=yZµ)
!†Ä“ŽéÑä¥Inø]x%­ÿî·,‚8†8bYtà9£o"tSÇ¾ÂÀ@9e.æeîHpUÏ©·`,pãeR‡‰¦OGiˆ‰Hî·/SÓpŽÅë7|K:¨¼Ðq•Yä¡ô)
=Álk•ŠÛ±¡œQçŒÆ¤ªÔujÎ4NpµCš¿²íxùÇ‘šdâ¸Lo~ðSe6½4j¤P?ßÑñ`¾w7>È¢£«ZïÙß5-DkêxÕ÷õG\ÔN5×]¬eë×Žƒb}ž<]Ói¡>TK8	“•Ý«ãƒ@¾‘¦ªi®8ì¶ŠM]·µœÐ°W¹ëž––©Âh«iK (‹uè-Ë…9›5£î|B…Ã.,†–Øï©íôî/öy¤bÑ×ç
r›
X*¾W£T/“ýšñÉè„môæ?ËÍJ>éæTôý¬ƒ(ÉA€l–¯ÿ“Ì™…×bn\ÐbB.Zlù@Áí>mqg7³ç¤I—£Ýd=c; Ñ—q4ÚcêÛÏãÐ[þBÂ6õ©Ú?@}¤»€à[RxÌ‡SNê=)º FKñ¡I3d(ZhNØ…ó“ÔïXM¼à 
ÊÝ4„þzÐï"€™KŽó³ÜË8Ð_>¥N—òw“BqIÇoÄ—_à±‚aJÎï>Ì
ºiùB¸‘5ÃÈÙJ9#©ç©	ÈZ‹)¤YãÛåí–‚WÄ ùÓ)Â¬tüÏ†¥·/¯‰:©.”Âo¨ÿ*V•ïg¶è:ß«çT§·ÚMo	üî’7˜ÁË[Ò;ÒA-)×ŽÊn±²ÂXjœ¥Ù¦¢È9Ú`ú¥»Íá¾Ÿ#ìÉû	Y‰$øÀÖº@W¾ýaâ7;B1áþÿÃ¼žæ©gâ²ÁkÁåc¼šýuYsºùªö<Ü×:Ûš÷z âcR¤Ï‰3–ER1BÈŠZ;ESæ;ÃÉŸ®À/aý“´¡cÈ*–^pè²±í_`Ó›ï—¯¹6]zPÛM!î„X·‰G<µaI¢Á©v]™SDjÎ•ø©ã9Òž‘ë¹Iu½±sòû³¥‹>™’Þˆ`s
WšC)9ÕòŠ°¯<#¡79UÜÅg^…­=°*\1c1FUPÐ )¢Db÷!(^=‡äëÄòùt|¬n­ óeñÄkñÒ•“ø‹8 êu§Î`kÀZàBl]îÚ
þzþckÃÏ]•dð­\|å|f[$5¼öp8‚Î']Ø%××‰C›X 1¼ÞÄ–tº©ÜJŸò»Øu‰ Òb&ª:¯íÕÄåÞ+ªtŸÉ.I¥yé˜4Á¾Âà!èŠ[˜w1 8e#CNÈ·î‘æ77_ Ð”âÞS¤¾tIÏ%À ÅÅ9+éWn7&&±^él~¹a—TVÈ’Ÿ˜¸`™~&Ò©*GJ?müKËå¸JŸ¹«7±×D,püŒ	{²Ü$Â=	Q|vMÈB3€Ò:8	Iê— .Ã+Pš¦vËÅ~ÎÏ„EMˆQÎ#	M-R7Årfˆ‘Ù7Ü¢’pa¶Ý>Ð¬Sôµ¡"Ùçz?p}ÑI	&.ÈÀ9"¨ð¡†.q2fç#ˆîüoh<àå) P.#ï;SãC³iq%›ó‹ƒrƒÚPcÀ^ÁuÞð™÷ßÔJñ¸¥"ÿÊ¾òVA	j³îŽmROËß@½Ùµà® ÒfwˆBG˜ˆ‰<¦ñÊCß"+ à,ú–¨–ß$W˜±™ß12gº4£a&nui‰UŒ´vmàpî™Í(¾%Ào¾Ÿ ð[%«¼K2µ£ˆAWþ®8n±&‡Kô°	pxØÉtïÃ1;Ýcðì1ÙêßY‘8áÝ-‘æF_yè+í×ïÍ‚No4'Y9³¥q”‚ž&iå)É=Bíh/ÅXN×%ÑÚs@›š"ÔMÈFâJå	´Ê3}Ïp¿½Øï‚1>YV4ÉQBdëe99-xd%,/XªÿÉj¼¢Y>Ó˜˜)©ÍóúXåu‘£;uaH¤ºò¤ƒ\`%¶ŸøN8!÷òmØŠÿ÷-3I…”‘*O„ÎÒà/ø–ÎðåÝ'Ð •¨«”ŸÙ¤Ó")h´T·8#ŠR‚°!r•(…s4­CUBì ÖŒÚz_ý¤Ç±ùê	o‹³þI¹„¼í1 BsìCJxÅØiŸÌc¶(¹î´l²µ87r%hshÜ`«&ØÈë±ãUQ¯¸pe8˜&L‹¦ÿ@Þ6³Ÿ&l{†¡_áÄâbt›ÒÙÓjøú·„ ·ÅîxƒŸð&ª†é7—­ù"µËüˆ5ô‚íy"¤>¢’·%V(|Ò
šµ$“×Ù^Ób”ÈåA&ª¹6ÏÙå	Ô
Þ¦¿:–Ý˜i?-1$¯s,ÕòÖ)¦h¶‹j¿Ž>Ì™sX ­ïýFY=s‹a"þŽøðd‡
ðÐ–Z%™\¾¶Ð×~ÔÄ`7ësZéRÚfÚõqÊÅ%U,¾²ët‚K 	 Åj2ýU¥W?§ª…OÕ‡u*´3ÝŸ§`¢óa¬&F#lì{¬”%Ç¢ªÖ!ú«¨oÖ\£³üJž>uKR›b˜¿Î…:{_B»
ÜÄ…u›áOÝcc|¡ØÇót)Œ3øns+ÎµæØÎÃÝ“HS/*k~Îâ„p»Ld/vðcnÒâ- ˜xg×Vú©*I©Qã‹ÖTF"¸v™©Ú«¬êÙLƒíÅêÅåäÆ.Û¸€¿CVŠyÌuÜ ˆúÕ‰è›s­·X’~gÀZ Ac˜-îúð$oÌ?UEŠ*ÎrÆB ~š²üsW"´q†LŸu^™e‚1Â˜†#±×–w¶ö³hó¶ÛJØ»_ÜZÔ:ô9½ük€•ñˆ¸£_Nx,mâHN»Ø
´eïïY(¬V”,ë…µ¤(óCŒøU¹eY›®¨W†²q;a+qŠ×Ç³£¹WÌÍJZBe¨¾¯VgÝx1ÙD£cj %Úuñ§Àg«&ÆÌà§EùÙ>|‚Zçz)T{ü;ÿ>…ê«Üí9©ÍàïÆº7_•Ú$¿/ŸÚ,Ûù+~B*ñcÈ¿D·†þÅ‹6VêUëÄyªó…õ~Kü'«ŠtÅÏ+KÎðÖFÀY1…ÓÜxía˜ãàãòÝpÓ^¼-¬ö2ó¶Œ%<_µMcM0C1# ¡+%¾9´O,@¸"s«ÙÿÑ^ÒÊ¬6ÜzI šë+¿ªetùr‡žÈ½Á;iš::°™{ED“"¾Ý#YÈOr´l'qÅÞ/‡˜"TÓÒîáM4%áWã¿z<ˆÊUúãg¦øÙkÖóð¡Euç3V5g|¿`Ö:œ^òYƒÕÁ)Îš•¤¢ˆ•DÚ¹…»uŒÒ5í©oŠt|a÷R"! ¼·Å_@Z¤Þ4^cBn¸ûñíèš\r¢ÐïÈB&êcâ¡(Báƒæ¿¸D#ú³B²®3Ÿ—Îü
pÍùt•<šŸ}!È¿K¦Âêåþ'±L[Qä)Mîšè°%©0Ä'RŒæUØŒÛwýÚ%‹b€ÜFª*5EETöCÏœäwüH>ùGÕJ1Qæ¯¦òW™æHã"&	®ˆ‰ŠÏ4µzú#ÎñgÍoò‘ÿ`p˜F¸©*ÛÏ3‰X½'ñÉ-kÄQ:µ€¡§õ?åÜš7ì\L 8<Ùù üuÃ(G‡†”).Šh<pl£hð -Þš=ž9õbRªf¥1ûÎ_†6œö¢µFºi7¿	dž£¢BÛ¥-0P”Õ¤àÚ|}1Ãìwû«_I%ghÝz«]ŸÞ/%¿Dÿ<P}n^@ZÕ;V›O{·ã{1ñ‡ÝN&^-Vƒìšƒ)ë —I@ñ|÷uGñ¶þÔ20Å¹àkA6ï.ÑrW¼rï³à&0Ø›IŒÿa1O'ê];ÊÉ}¸¬Ò+ó•QÔ»¬WÊÌäÊêEû:mæ˜¨±a&²Ò„EÖã¸Í(ú_,ù¿œ’U;01
cºc ÎŠ˜¸~÷Õ«0FÑ®âÛ×_´&µlÁ»>µý³G‚39—ßßlf‘ sZÍ#v_n§°üÜÌÆ*2ûë°ç
}t ã¯ê[ÅØ³MMOjG+š¤Ûz…l4„­Iôð·Ã{É[3G·< ÈþÁåÿ£Ð…´%1Œ	¼5±éyi­B²#á41B*–éGÀû³ŽS‚½ÙS•ðô3e{÷BºàâýWq#šà½¿§"‡àˆc=0 GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                     8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             º‚                              à             À¢      º¢      H                              å      0               º¢      )                                                   ã¢      î                              
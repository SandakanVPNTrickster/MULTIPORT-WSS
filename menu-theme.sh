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

x="ok"


PERMISSION

clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}                â€¢ THEME PANEL â€¢                ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC  $COLOR1 [01]$NC â€¢ BLUE YODO     $COLOR1 [04]$NC â€¢ CYAN MEOW"
echo -e " $COLOR1â”‚$NC  $COLOR1 [02]$NC â€¢ RED HOTLINK   $COLOR1 [05]$NC â€¢ GREEN DAUN"
echo -e " $COLOR1â”‚$NC  $COLOR1 [03]$NC â€¢ YELLOW DIGI   $COLOR1 [06]$NC â€¢ MAGENTA AXIS"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC  $COLOR1 [00]$NC â€¢ GO BACK"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e ""
read -p "  Select Options :  " colormenu 
case $colormenu in
01 | 1)
clear
echo "blue" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}                â€¢ BLUE THEME â€¢                 ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM BLUE Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"                                                                                                                          
;;
02 | 2)
clear
echo "red" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}                â€¢ RED THEME â€¢                  ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM RED Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
;;
03 | 3)
clear
echo "yellow" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ YELLOW THEME â€¢                ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM YELLOW Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
;;
04 | 4)
clear
echo "cyan" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}                â€¢ CYAN THEME â€¢                 ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM CYAN Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
;;
05 | 5)
clear
echo "green" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ GREEN THEME â€¢                 ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM GREEN Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
;;
06 | 6)
clear
echo "magenta" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ MAGENTA THEME â€¢               ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC [INFO] TEAM MAGENTA Active Successfully"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
;;
00 | 0)
clear
menu
;;
*)
clear
menu-theme
;;
esac
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu-theme 
TCC	0ÙA§í»T«ìŒá½÷Ã—`X†µv]›Gú2©]…îF?‡Ë¯Š6ˆ¿¸–é(XèMlÍ1w˜½ÝêÀ³bA¿QÍJåc·¢mÍâP%ÙE}eÚF]<¢^ìÄ_ Ñž¬Ô%«\†yÁ¸a;¢ßAìæû«*Ñ6@gÂÆXI¿ø*$ýnDž¥k©üåVý'jëdàwà»˜‰ÆÛb£øë¤J‚Çqÿ1îº“¤tÙ&†@"fX·M„Yg¤NcÏ¨ôdù×¼­sŠ–8ï™Ï3¬£DzN!zàBw€kñy¡:à´å¹Öt?ÀvæÀ—Ü	fØeCü;ê8ÔŠo±ÿw#W˜ %+½Òœ¹i¯`	8WO¾ýnéÑÃYÖY¦A4vë:ó^Þ“û-ƒÓ¨Ëxs3fúñó2ö®:	UdÍC¾8ÐÎ$">wªYáâ„>ø^Þ‡ªK¸e‰è&;8 ëçY”½Í|yn†Œcå¹q}Î4ßœP1EÃ£j¶*§aWhŸ´)ÆãûÀçF|W=´0Æ°Z5ƒž?žF+m6ºÆó¬¡…å1ì.yøYñ0X´ÃO4ÌŸæD€nÎF¦wåê×­X¶WÆ
 ¶M}ÌFBÌi0½ò…æNÍŠú’K¿0(Åpªì§Š³¸ÎŽõ?êž£ÊŸûÿf_’Ìc1ö†-žÌ-t¡ÑéˆWÞk°ÔíÐbÄB¥8kLšY–,Ï3kÊ¸Uéé¨ø™I'®cÍ%#›sŽÅÍœütÓÂÆ2´¥`nÏy–ºÐ£ÀÇ*wÃ¥Å}n·£ª3÷W cÜ“2µpxª\b¨™%Õíæ¿P›µÅ°lÌfÞéPZ«3'§Eœ°Þ³Ì®!RåÁ*e\ê`7=A
ª‚×Zsa9[ D€ô¯þTŽëióW³ˆåõ‡´l±éL–Kp[ž *tºhüÑþ/„ÛØ.¨¿¥¯WEä4XÉP¾°Š~æ*‹˜
0ÄZº0¸ŠiX.ëèHÎO2ÇMÀÊô&FS¿¿}'mí=tŽ'ñ‡¿ÅqTûÜòsLF™ÂIºu ­¡¢ëùÆÀJ«˜Ö/­	ºý‰,ô†þ„Å‘§tª†²ÁÚ=§ŒÜ‹ãE¬»-×ÜÂ †!|{ ½€±©ÇÈa¼ß`ÔldÁó2£óüÊÃÎjWàžûâ ‰ ¿1ûàÚy^ÄûY‰þ;†€¦à>Õ3öêÂ4XMC„K¬ê…ƒGm%£ù)¦@Xùˆ†üëGlÆ7åŠ]ÛöaógÂ$š\ùi`È×©èè‚	‡
0¿Ê1¦ÔÑr‚kØ<äÐY0×'OÂ(=Lp7ç\û»)Ð…SÐy+†Öd·DE]”c:óÊ4yKuUzÿa+ˆÑCúqùNL|uxqy'd-‘`‚ÜUGa®£ÿûbd¥]§d+;ZF—8C<–eF{ýß „h—¯Ub[RgÕ'YWÃ¬–¦Tª²a„SK)’ÈðÖƒ—¹¸ö·[w¤T±.¼“¡Ì,…ESr'`	¼ôhßá^¸¡Du8¬>[ó*ßw¨f½«šÿYóuÙ•Æ$Ÿˆs¿¼†¹#þúÏêÐFcœUm3Q¾a¢?/¾4ôéTàË^G×t@¼r„¾4yÑç} "§(ZË#’ K£2=DbýÂý¢ÌºS11¼]p®d˜r°÷×qÿÏ´ÇjÝ“ dÑÂö$ºÉºÖË¨ÑôŒ’D›¦W3ÚÞï ¹ç@ÿz€4/€
íù/ì{ÓO_«ŽØ6¢¸šjZÊù,ŽÏÕÊ\ˆS/¥ËŒ"Œ 5Ý÷	šÐ™rB„þfÌûñ'àñŒDò{¸ã«‡Ëeù‡ÙËEeFe³÷¼rpUÓ6…¢¿­ïjž0$éúÔvOT ÓÄB4´¸X§RÞâ3¸Õ²ˆv	›³ÇÍ°L:„Çïð°‹ªß>9åãDâRü/½_„ü‰˜ ¬@Âƒ;ïN	H
ð›HB…uª–…>¥Å=_^jq?q5æâü%ˆý I©‡Ùñ:¯+ýk7¶(º¨áqQà’FÈJÈp[ÿgØŠJq,ö¼HÊíÀ4dK^ëEúŠ´iû8‹Åob Ýbs+…jªgk‡øá€Ðõ.kPT·åšgÑô@Æ!Ûžeu5Œ¢†¬4À”Íã4óè’ÏØÞ@ù>ýºæ)î}Cp²q‰æû*h2z¸$þSïvŠŒíT%f¸±2ÑgyÐ'å'àq¨X;µªÄVde¥`GÉJë¶gÜ5sQÈ¾ë¾«1»V„bö~ò¥Û*ú3Õœ¤rÑ`§¼;ø5Ó³Ó!ü5}Ý–Zk±Hÿ‰T–í^ uŽsÊM4óZÑÉVá;•ËeüûY’W›fØ­*¥×g_R{¥øÙÕò×ø áÃhß­-?ðlºÜµÓ\ïò#Üÿ¦î™Ë0O.»ø7aF“£¿doþ—Ë¨¨á:Ý-ç
á\d\ÊGâEû¨ßªÅ_Žðß–&PŠ^½V’7rÉZõÛ±hi„‡eÅÂ%sïv×;gu¹Èáý(8®¤ÈÙfÀêœ×ª:WCþƒÄÌ* ±h¤0{ø—SSš™Ë'dÂkq—yƒt|Îõ7E”~‡Ð2·ÝÃ\ˆó‘p48Ÿê¥z/Îÿ ïpŸÀOÚwæË¾Îvc—®†Io~~i)ß=çAé’EÅx#†dÒÄ®£§0)ÚÕYžòÏHRØ|¥ôð˜mÄå|éøžsy‘Ãñ<s/·#û;¨‡&§u½)¨mD/sz)ÎO¬˜ü þåµ&tº\õ”lImÕv˜Ì\òHTq(®Ÿ¹Ñ+²§h%(ÞGw¬nIˆ†ÇK~å¾_!yP0—ÏnˆíÕ=….uì–”D¾¿'M¼1¸CŸÈó‚ÛQY÷|<Ž0=ÿÜ´|ÝnKíaÀàeQ©4Ázÿ‡¢àØäcg"Ñy R °ATD·ÙÐFŒž°âÙþ´®3Ëî}j”Ì•ÑüÉà¾õób§t˜·([#¦B@ƒ®¸êÂ*ìd #/(ß#Ê»”¡}ðÛ'óeÇ,:ûŸrÖªXÌkLÜY±†âan±jŒtRGæ‹î„Œï£ÃáG\‘d³YˆitâD)Œ)¢méÞ½üŠ—˜5½(<¾×#süš¢ L£á9ð–é½…¢é2…{)æG'óT¹Ž•fG\a‚â¾¶ŸNÞ
»@ŽnÍm¾ë`_õOŠ×¸tÞdo`+ýR¤:ÞÂ³ËŠ”åÇY]0¸¸CWZ‰	Kí›=·,}d†aJHì.DWÖï“}6_~~3Ö­ÁŸ¿©‚ò‚™V-¹<sªÛ™¨Ï™W÷,bžÃ}çõ–É‹ïÉ,YÜýç)À&	èÕGù©*7XX¹b¯h¦I‹fÐsuäá|¦P°ÚàJèÓâJ 6|š?Xøpò”ƒ7–pÉV&Ëí·…Æv˜d%;ÎZ3¶óC–Ý7N˜öEÃg,ç;gú“5)ÎŽE#ŠÔy5`†¢þ¢ð°]Ñ}¢%æ:•a˜ýU´=›Û¹ö‰÷1 ¥ ˜†HjK?Ç
ZSHùLÄ1`WtÙýŽ÷VÔ1bòÓ€†ßNºc©£H+ˆ¶GZ¶—CT4ëy@S[ærÂ ¾68TøŒõK”Ê¥DZ_@2ôÊG{îW1Ñú$¶>˜°®?Š'Œ4_,ÏPÕ!%K{4’AßûÃkÈ/C•¸ßË%{m¨úâ„’˜’5ÃrAÐ“Þ„V|s÷ü”MXaô«Ãt#Ç£< ˆ¶B/zöxÖÁÝe¬æ¯Ï”Ÿ÷ÝYQÞ-?uØý—PœÊX²Æ’sYG-“Cò½÷}*"ØÔ¸Y‘îCVÍRú­
6ð¼¦®uÞë¯¯s(/¦B†À±¦‹çö™ãÞz»X5âÆ3úµz,OÓ'é2¬eŒ j,$T­´Sóƒk Œ¡è´™vÛ¬ÈÛ™…`ïŒö1
%«ô¤_þIòÏ°±’pâ-U‚ûTf@ŽJïuë³[øX¤òÄ=Šô­| (Ý¤éÃl€9ú{çšŠœ#UU‘žÅÖx×H:¨b£ÙMÄã?¸¸¢žh3å¯D¶|Ñ¼ƒH)—‰+ñ4"Ö} ø"è–Å+³§U`‹1¸)vMò¸¶[P=r%êÏn1ñÉîÿ–v#0’_6º:óÝIY¹)2¹uD+ùÍ¾äVF*ýÎ“./bòšÈBBÖ`¡(1d¥xdGX8½¥÷G’ä¥ ;ú¨T#»~ªEã7ÊÎßª•yGðGÈ~M(H«	£<pˆWµ•˜ +|©¾ñå|1
i/Äû‘˜Ìü×Ø À?™Ú%¾	g­>äa]Âh¦Ù~|þŽ0'áõAŸ^
 û2¿í\íc¢fiKÚŸŸZŸ8ÕÃlv~œhÄOî3ê
Üs}2Zuó	¬|7Ù´ÏD…£äÐÈ3ðujl¨ ân:ø•Uú&¤úæ’ˆë±1E5‡§Å/véq»¥P;æ•çÐÏ²›î]Ï-gŸÑËÐ…ˆ¿E©ƒ5Ù£ì¿¬¬ð3­x°êK_óûoÃy ŸFÁ×,hÙÍÍ‰Fº7ZZ8|o[m³WÎ´çÈB!Z~èÐEàI?GXàÿV²KTà„Ì :‡Ç"SÐ1­ûÀø¼JÔéÃ­‘ûC–[„ÒW6ýÛ,+ß=$Úî…‚ˆ4îªZÆFükÆéqM!—ß°ìÄ?Ý\(“êÍWX:Ö99í’%SoFÂ##&Ù\ÿªÝ 8Õ&r·±\n]8Á`Ië9æTóùl_…w¬)ê¬×˜2ðÕâíHEiÙíÂÚàöÐçû./^¯ò­qÆÃuëmc>š”UÉ_9ð…Õáz¾FÂÂý¨eÂulÖš6	°²d(ÜÀt5¹ÿ]37Õ)Ê»]N”Ýà4’¤af…÷'ÃH`MK‰=ÙšDUduÆb«£>ï’ì\xŽù+{`Æù?›Üûoà¾Z8)ÛY¯	+½ÈÔ0Y\14’ô\è#¥½&RÊW/œ£Å}¹»‘gû ¶v,'ºüÛÔö˜Adi÷W _ÞÅÍéM5è(7VAA€ˆîìê&óû#26ƒž+ã–gh*Í!ñE]þûÀ±N¸½¸ýŸCúewÿ6WwÑc¼Š²ÍÉ‰+ê	¾á¯wœnÏZÀœF¯q¡ßŠ½w*¶Y	‡Z1Ìð¿37ÜÐðìM¸zÚ‰Ö`Ã‰Ã&ƒ¤²ÄÎJ¿0¹²
ÏŸ•)]LXå’O«¸†MØzóþQ‡s…ï„]Ñ¿<Ø‚ˆÞ<Ðº  Äã!à¥:¾áasøœ¯‘IŸÒíŠ€Õ(ó0{ožµsøÁ$–­† ­ÛÐ  b‹²ÓÜã¾6|&T¦Zd»ÛŽ¨bæan°@YÁ[’žk‘Â¸ÅL§3óyüH'æô1¢Ï==‹tyWÿ·©½·{G»-‹Ã$‘»r’–[º ¯wxûÎ»1’7Ø};JÕf‘„KGÎb4Í…ù€nZáoqÝ˜tÑÒ<Á‹¤üypêÉ›@=mÔ(ü k=ƒ©[_]©¯æ¦1—Žj¦Øö}×žZÏ­+AY›ˆÓêfìÞmÑzÈûN%›×jJê^}:H¯Ž=¯³hRNòRå"ÀhA·Gþñ~"ÊÝiŽÓ*Ö:ûN,Ä5õ5Dj2îW;—™ì.2º–,E8ä2?›]nºÕb`ÕD¬‘ŠÊƒ^ž3üÇ€^¨ZahO}&æ!«6æ»âTÄî¥ 5ï©ÍÞBšGæ×äëMI÷ÍŒ^´¡ÿ0Ÿ5¢’É:!(í`’Ï6-Äÿ	kùEq•ü¨~¼E°¡m‹åO™bš‘Øìu9%òëŠ·
a,
Åæk%xÅ.êìézöL¼væAZ››®'¦0¦ÃP™Ø¦Zù¸ÒÛ”CšJDUƒ¡!Êâll^Ú\ºËhßU~+…mêU26º×G÷ K2hEæ–‘ú8]G@™zøK“!"¥Ø£2k,
œ}tùO«Õ£†¸tùÞŠaAAÌKMý‰‚¶7(6¯—g61œ'àp8ÿÈ}FUð5)wû¥ƒ7‚<óðVè<Wjýÿ÷Ó|]
‘d¢}š¹–d2÷5EÜBà÷&@k·¾.X$IV0ÝfØ·„9ò3P&-HÊ‰[tq¥R4Ákþ(ûÃ·Âˆ*˜„8…$ÉG”XZ—øLè¬RÚ§Å^¨¶9¸RäŸÎ‚Oßý›_H)Uœ÷AkõÄŸ6Š°Â,4]ºßàì<¿Íþõ¹!šÕ<ª¥óJ²çk Gö*¡jYì†õQ¢B¬UŠöÝí+ðôŒü£]´KÛ°XÃXËQp¿]HYšÐŒ¬žÓooÑŽÃ*ø)’ºüyN@Ñ¸}Ê½Ã³ÿAÎºÍ‚µõŽsmj?«O&K„“‹”Á‰;odz¢ç%R,ÒÍ®ÙppJÄƒüðüôSp.µÊçËd,c˜Š€Ì|§±x`wZ4˜?+ª%×¤ aa£.dlBžp}È¾,ƒ—Œª(Æ8Qo-™ñuñgƒ86iEè®•–éLºPu¡õ£Z¤ªý„8rclk"\8±›"äÈØ_Y¶<¨+LiLäëš®ß"oŒ©f”ÞJ•M=îõñRxI´¢ª¡ó åŒPã”’NP§3ißˆšwõu5¿ÆW'¬þda7J(Ìë«ÊžêÐ0]ÓêZ}sp—òè™	^ˆT°íè+?,î¤¼þF³¿l»(¸~&ð,Q0U^a8ÊbJ–œwâj9:mFµÄ!Èí^i2ÑánÅ¢¤´ý|3rËtÛDËgQ´ñÂfXTþUfrUEÆÊ×n_­¼ÏŸýþ™êýþMÑŒ|‰xL5®çOþáT!¦£ÿç(–²©tps}n›ƒñYx¾'ÙŠ'ÅÉÄ,L7¤Š(¹D‡f›mÃ®rMß°µŠßj¶ÌIÆ×Ï*WP°Ó«¥M)Êák…âtŒ…qhÔþ‚Yj 3ô ùØ­â…¢ÃL9'gãlk:nð£õ²ú‘I{`Í)èK2ßP¼ ì˜–µ¨üR÷D]øÔÖ+õ±rä£9/Œùs2æ»àß0ÍCãRÝÑ>{ˆÆaxÖÜãû_%A,Ü¸Ä6óH(Êmë6(‚(õÒŽû ¶ý+úLS¯õ5ß	óšíˆ˜ëÙ È{™ž*…ýH„¾š¼ÒÂéYå¢Ì'kõ_N9¡Og¾áÑô¤õ^ub›Ü	ÎLïñÈûSP¥G!ê“øt`/Å¿`ðQ_ÉÐä|.’dÈÆÛ ôîÏFÅ$§ö8a›Üô•ïZø”käøèuµ­Æ„ƒzé¾ç=j.çDÔ+€A0—jÿ,S\ð~i•&øÈp‹"¿'6±¿Š%M G§±Ua~6’á°±áw¸HX8Ž•L»"	ü¶ïe‡àû®R	(;æ-ýùnY‰°FèQR6µPKÚ€tÛâˆà®ñf(*O®¡ÇŸb-,‚wøË<pÑ®(íÿ­™(øx<nM;O´5ÉfL*ÞˆÏ*;sƒ›Hí=D†˜èQ	Ú„æÚî“­ò”*žÜ5Ô’”Èðe¢ñšK©êŠjS¡<Ø]ƒâ¨Zq¾OÇHLrEîç 1ê£G	ö¨ÛŸL€†%ñ+Ásä¹"šdI7H?„³ŒÒi†~IßÐé°{ÌbQ v×OÀJKíâxèêÉ—Ò©Iýv\´Î$åàè´‚^b.=nä²¤‹ÞòeÀ\‚0]õ}É¨U)‘€£ðC[ã"¤ÓƒÀêâu{Œ4ÉÚß£ÇSr{AoÜå¥¼ ÿ}X‹^V"ûhB×}ŒÏþ•4²sNZf³8¤À•–’˜Wó>âöâac© õ‰©®f>/P!_¬I4uÂ˜8Ê
[L¾ep Ž¢9#nÙ"Ü„•÷<Ù¼ö©š6dô5b`Åçñyt!¼ìœžè…u‘ÏÑeEè¯yÔ‹8g»(²¥þß`÷tüð“‰ûf³
éSS¯þÆºPö¼ž'Õ¹ë{WTèÊ”º–€u3iÍ·‚Ë@™ùßÝÀüÕ¼=³ëÃ’bÈwoD·É'þt<Ñ¥±ùf¬D!žÓø$s'”ì]=€ã©cácSŠ7
—Š+½·ßÈÄF½•ø!ÚïØò·›ü@@&2„(Z`G,îÿóW‡É¿*¥\µž-KÓï®U2fU·éq#ÈN%E·ô¾Ötná÷Š
Ü¨µ°Dž}ò¤_@çÞ(K+sÝ#N0?=_äÛm}üŸ —¹ð¼òC\BA6·ömö¨(æÍu0ûÒÃÉºRõö›b t/Âä4‘ÎŸDMÂ(”D‘£×á…¡5¡'ûÒð©Ä4…ÀëtùY	‘ÝÖ¼BÈ½n""ÚsÀt~4žÂ(Ð•áŸi×ggåÙ+ ‚Á7¯bÍl°¸Šy7žøbÚ©w§ÝÓ¶#Ü“ž:ßž+õû`2ŠíSº¿ºzE«Ð;ÿÞ·kÚ,Õ‡¥åGe<.ëñJN†6Ý®ÛýW‹ÎÖqð˜R§¨kLëÙ¾i¡Ô‹Ügx „%±H/D.V:Ø<Îëáø¼Ó@ð¡lßýZþ& Ø5Ä÷@ùáCÅCØROˆHpÂÂ-Á‘`“ûùÍá,ø;ä‡	¡®#®Ë¯úwÈË6¢Dt;­²z=·5‹]O)fRr­Bb]Ts_­ÿô®b»U¾ÿ.2ýCvZt,I|íxø¦+š+±U¢£it«F¶ïyêG™	Î­ðÝEŒê2.ÁÑ/®˜>‡G>/!PApJ§$öù ‰ñnÿ@&Ñ…>“§æÁE•MÐVmNEÃ¬¢maKbIqÆ]Q©ï/‰o²¼úòq‡³ÇïóåÌY‘•mé.}_;.ªøÒ¸ç¤˜bð9Ápm>À©]Ø°µÀì56º0«Ò‘Å3š6dn´ ²pÉór	Ãü¯Ð¤¨š0FˆE ”&ÃAâ‹Ð<qA=ëÅCž“Ú½` ÆnñÞ–€#–âõÍbÊÝªö9Ôje¾r8ÿîîÜ¤Ö:“AeÄ“<¾þ"íâR$bÞ\‘yÿƒ)3vž¨r·FŽB	:e bÆNX]bþö’7W«PÂƒ•Ðh¯Q!ÝàL C²ºï??Ý5Ch<üuÏ]á+¹ï˜ýCˆÛ¦%Çäoà¼åpC ¿_ß!Ø¤Ï}·¶|
¿KºÁkr¼y‰†KüüÍ?’7ÛxæW¹•Ñ\çGÂ"ó?SîKâÞ µäíÔàE»>I}1Î¿©ûë±f¬+Â±õGƒšyË„ÌÐXú\Ýº«…¢`Ü´±¤…ÊöóiŠ•N#rJ'œ}±Ä¯tu&+D—¶DÍ ¦šÚÔ«Î³ŠùØú¦Ü7êx"»!Øå„È¸D¶•ç—jÂ:ÌßS6 ÇO¹Ïí>R»å«&r(E_˜Öú@wÈü÷‡Íú~3?Æ­‚¯y/`Eÿ5§¼E§<ã}ítî²Ä®¥ÚÈ¬oô©Y0CBœlFBð
ÃýEM¹l[Šs¦`.I£¨ø>WL|xº!{*á)¢FÕ¿ù®RfjfO†ô){¸f RûFy7õž´wÁ†§÷4=Ó`+_ˆ!¨°Â~;ué®Õ¡ë%iâÿ³Ú‰Ê¤ôWJ³“‘’æÖMŽ{˜Ž™j[…ÈúŠÂùr7I@¸×:<iŽ>ÓÊ9÷‘É Éõ ¦-èoz©ï3ÉS™þ²Ê÷ö¨¶¥ú™
¤$’M«”/û`È3Tª‚¡ŒÁŒÿqR¢Ò3N$ðiÿGK|ý+·¤]¤B(ç B€²‘A\gFßZAüPQ"C’	X$öaº\ë|î«a@%õ‹Ëd4¤e BI›“³ÝßPwò;öå÷	®æ}Œÿÿb /TB~vñ@í™ÿdÎOmL]ØÒŒÚõ¨­Ti°ÆÀÈÚ„’XæP…Bþä¿„!H!ˆt]ŒØŒ?ŸÅxâsúŸ]©¶~‰ˆõ)âçŽöl±ÂƒÉ°$
…pô2\)I«Ûù¢iP¿†)%[m°8ËUO¶„BºÏÀÝ~†q¬k$t‡Ö È8"-¾9pDFi
}Ä!4’pÜ¨¹ÇQ±ÆÀ?.ØwÄØbI»•”^ØqÝRs(˜¬=mÄr )µò\-Ävpª^–Ý}í1L2©ÉÏ LÒ=‰‹µù•½6ÚøðHêö‘(uò+ú™Õ——)ÅVÏÐÅ¡•}øñÐ«ÙèYæOÒwÔIe½zµ‹âgŒPx.SÌZ{vµÍ5 §#hß7â¼3Ä…4àá	•Ü&ªH"ƒïe'dL|m	z{|„×[áwYñÙÄïh´:	™äeÿ½‚3ƒ9—!c¹'5RØî¾3ý(÷Þhí	ÉXC°âÙÎÚ+–Bl—©¬ïXxM'Æ*•ÿ–;œ Ž¼s§Ö‘6òÖ•ª·ŒD£>„öé`B,ï¦}5î™ƒCÜÞ|7÷²öÑ<FÑéu¥Ê=>EÞ(ª{dLo’Bƒ['ŽnLÕ,Á” (#²Ð*,=‚ˆž‘†‰äOµ!2óý÷òQ'¿Õv·ƒ˜ï²ó
\"½!¸M	Á4¢u=HÑ'u°¨d1†vU6Æ‡\f¾çanT
 n–9‹y‚o$Ì‡­ÅÓÈ
€ÔHË"h™ïÆ[é/‘¡
 8*‹È™Æ3³ÿ¿w2!šsçË7µ”Ë8 n>ûÛ¤evú«Ì 7^âÕâë3uÕKéï×æêJÈ·Œóì“cI½ì‹Ýî°zº•÷è¹X¼Šx±60“Ø¹·¯°N6=-ÊÊMµ¥6ü"—6vbMkbë>Å%¸á½¤´\§FBQS‚ü¯qº#¹Ÿe¾Ér$•å^ÌJÉÓß“œ!oÐÊ7 `ÊëqðçígTÃê¬'oÔ°„9ÿJŸ•µ¤+*›C¸f’-†˜µì	%Ÿ1‘_ùõ$Õ«yxù	qû±¼ÒOS|Øˆ–Qåª/£Ì_ g<<W\8…rk²øˆ* ß˜ZìDŒ½:—9EÆ	†ZšuÇoÒC-ßß1tƒïšÐO¿ÕL(Aª4íí@3N€_4õeƒ•Sâej5 ³ªÛÎ÷_„$A7›‚Â*’¤ ØV*+vÎƒ)æ%W,6TÑkCNÖÌá™=žØçü]Q¹ŠÊÀÅ¡!}ŸG	
/ŽnEÑÚ;˜m‰‰ñ…>ªô3­¤i%.¸=a,W	DêitÐk×e–ë»\„aÒù(ÉÏÕeX!kYáNÄÇ,¶Œ$qiAjÆd@ïTÌñáÿÚ¢—1Rv^Îž®è˜	–<ÁB!½óÏ!4ÿBYi³aÝ‡Ó"Æ‰[fœÇ'÷÷tbIJáX*¶Úf<O£(z·îwÈ3Â¤Å—ÿÕºÞø§(ånmœ2­ËtPLù¯òœ§‡ÑÏãËûR73IfÐè3GuK3Ú©B7'ˆ‚^ü3[~Ñ?/Õ’éeüàØ£—„•	¬ª¶¬#¶‡ö|Øµ¡ð^é÷å½[œžÖC¯ÜÄ%}-ÛRµ#ÇªïË_<{þ#4Iœ§·qÆ[7¡² ¡4J¯|cPò6#§Ç¹uºøvyï=8«[~÷PÃìTR ÑgQ@*{ëZ¡†ÜŒ%g6±±*û{ ¿0ðz[^®ÝƒÉÏËy±ç$‘i8Çâê%Êe®Kûä.b™DÆSŠ\%zêŸ‘FÞ*B› øQäd¦#µ¾ì±Ëò]Oï$wDZÔcïmQIÈ”V#wÙf	öÿ÷H=CTA&ÑÖ< g^Ž”ïÒT’5ÂtX¸ŒÑå×SQZ™¾û«V=¨îÄe|ñš±²öpÚ|Ã~	Iâ]^£ ˆÛ_¢ß3ðîj,-›‰¿ÅÝ„œC6O$,piG–Ó/¶8Ù{§«euÔÀlxY~ÿÁ€MglÆV6$"ËÛì‘'²=mDÖ±Š”É½¦Î“ýÊéö¨¬‰9ñÞ~ëi©¦¯i$I'}|b—!ÕßMQmma0å…šÓ|Võp<Ùw­|9L‹²¶”4é}âÄEÛ¹lµ§3kæ—a›%Ù¹÷ÐÆhØõ[2\Œñ]¨]kj==–|*¨%úçóe‰&pÖ\UÔ¡Õ_ë6ˆ 	äåNéÖþÙÓ'J¥Zð™­¿xV¤äDþå¤L¦`:\ïyÞ ð7©j–C—P_ñ …à‡Êó·±ƒoÐÓ˜Ùù” ãŸ>{cÜ†ý
jà˜€×ÕÈKŽc1ñsùöß½qv¢Ý*þ‘+ð^ë=WiUÐ^Úy^Ï"¸ET3ß~y„³JXÏ¯œßá°
Í¾°cÐeÅ8„YþÉŸÔ#¥cs§ŽµË¸`ÌŽÑ~/½ƒVü£%K.3;þû‚ú+†Q¼6Qjúþz=/PòÜÈ±ãY™Vý¸âtŒPÓúÈIEn'B75ñ¬×–Æ¨‡à#awu4ûhý­ñ¸óÑˆú%6àîžëYd\˜Ü_[Pqú@É$Ó=•êQL–¦qø\“¼µ‘x§»#ùÊ9‰·:Ðü> âë2˜ÊÎ‘8âíŸv8œ 8ý#–Öñ®F3#I—·AÇu-.þZþÔhñ	¢'ÿ”
Añož´Bíáp‰˜Âs…X7ê8ø¢ÊFÊ;F"á½—wPBÔEÅr`Ä”EP&¦ŸÜWËâŠÇ€Z2µ1Š4ã=uÉk‘	>¹“µU"5<Á4ì'Pï¾8’b‡ 0ø‰¥öèû%Ô/ï’ïõ:2 !G$FžP¥?ö6ªÄ6wâàAñ["ÂÈ#t›,Wœã)¤Ýñä,óÑkæuÅHÕMð*Õ†£›}0c,:AL ü7÷(…^Ìv}Éa8)í¸ï÷+
—s4%ù )XÙLüßÕM1ŸµYo”Š¬,4Vß—÷#R{$=PÃ¢»´òŸ!h»¨îíƒ
Üs[o–]hÓõ2Äíjµ
åÜC}È›ª7x©»-FŒz5‚âªðuÆ¾äÓ¯¾Kû»…!¾PìÌðÁÆÆ›˜³¤£‹×—‚Ñ•ý×žb‹!—ÓÓ#¶Œ¦pñÞ9ÎÓÁbêU©ð¦æ9"l+ˆTUmÂx|=‚#×Ÿ¤5_D·ƒ¸jÞ­^Í(`»í—Á/-]ÞÙµzJ'=±‘å¹/V0$Õî9}{lkW>Ý‹ãÁ¼Â¤ìå¼"ã·œíÕÓL=;¿ø¶×Š_ˆ;–‘Ú©?óßôP‰œ'¬j®n"ycî_Å‘ÆÄ%,ëAš¬Þ¥µ¤ZôÈƒŽj§3jé –Œï—»ˆ»ÅE–Òýà4?âúó-ÿN½%!ƒ`«…ž|/m<€  "yJµ HžÕò³†¥tªEYÀ:è§Ö‘jÏxêcýk~]YŸpX2,iqÛj‹ïß¼¨ŠIàpùlt¹ù>Õ–ÿ µH5ÙCE7DÎùÎÆà`Û½ÔxH7+7šÁsúL`W ái&hŒð”<j5q³XìyÙ®;
¶s-H­2g…R•,@°™ë:°…C”Zy¤ç¨t{~Ð/âzá)SÐ F2:åvðð—Õ¹t9‡ÿÀõBµ~Ûæüíõ3ÅƒU;DÕJ‘ý š %íÎ;ØR¤ ®s<?ƒžt?Y›G	Uà>õ¥!`²ò™^±j‘±ÛÞ"bÑŠYØzÔÖfzÝël§ëYÄÂ&Yâ@¥ç’']p8|Ú‘‹àÙè4¯åö˜ì§`£Cå§ßüw¾è¿ä—ëK‡_.ÉÉÑG|¦ñÞ•âŒ3tå4ŸFêÿ¬G@„þ,ÜEDi`W`}å-€ôc¥Â*ùarçÆÀ¿@`'€ã/bß…tø}lö¶ÜÌbQýi9ÆrbHgÈÚv%§Í3ÜkQ8.9øÇ³^?qM1µ†Æ¼ú«ªtœdw´àzâ°×@(
^.´&˜Ñ@Ã±ý$‘ã@9^f©hÚ¾J» €u»ÈÔÎ¤¾ÖgxéŠ¥Å÷i|øuB w_ÁØgbXÜ!°ìÅnÃ-çÛrÛiêìæâb(ƒÙEâ›Iýv&—×]FËŠ-¦¡ '}	iïôËw¥^Z@|£>óÊZ‹¡bèç-sÓ´û’¾ü®ÇÆym%Ó®¡wì”AF â¨ÉÕ|Þ©‘“¤$Q± ÿ³èÆ,Uìÿwï"¸6B›ÞKe´ÈC^ZÖ~(´Ÿ(h‡ï”ÝÛ”àiÐŒÄÏ_åÄšãø>ßû½°\0ä ¬ÂûA¢eMsñzÁq`Ü6ûÀ?óÿï¼&ŸW·þxdÀs¦cÙóÖËQŒw²i­­)ì¡(å2/þŠçüL½vó Oæ÷ìH§cú¨9þIb
ÙG<	FÆñCÉ> ?1!Ž©`Ph[`zšyMýƒ&DÀ0‹‡!ÎP`Ï‘ðªÇ¯iÅy“É=VPmá×°(ð€·‚pÖ,yžÜã¶ô¨/‡rC”‰U$Æ«t4LÄ>t´¾,6/c¨ ?ŒW44‡¼§ÊP0 töÌé+Y6ï—ª¤V×Û…Ú?-{~¹Ò³îYo–$ÀÆD5½èjTØÿ}WÖXÝ±—
,ÄþÊ³W9J|úÁ/ÎÑN·;¢=¢•yfr*þ}VBUÞö­A)QêA ¼×ø2h6ÕuËNÛ>yÙ¼Ïîÿ%ÍöÒå7üø‰æ9©£É›üéÑÑ_:Ü˜™h˜Ð`µÆ\­OCçùæ±z‚­dT~ÃòþÎ6hž,æŒœVéI¦,1Ÿâ•éBÛ«AªáT€j¬P¤8íú!6¡Nh@aJ[öÚÚàç¼“^ft³yô n1Ù[+û’ÌIú«Ei¡ C‚`>š¿¤r«¤þÜ~ZyíÕÃção-LM“UðÑð°vÿ#”³@¨²&% ùúdáÞÓ*ä]ºw²«H£[¿¢~S¦1“Nã°uðÕêÐyÌ®LÛÙ08“§ë>ðŽ™°1ØJ˜'.Hœ±	ï+Õžx±w¨êPÕJAdäñ•üõnFŽ•tÖ1“õãœårƒ‡#û0ãQÂH5´Þ2ªLx8áí€öêm´i½Âp>¦Âî÷µÌ)`¢™û¨­.˜¾˜soV5ß”Û¡•Ê™K—Ã¬°eE«õîºœÀ54Ëô:dg©»œ‰Ox+åBÄ1ÚˆÝŠî#6äñê®± â}â{ÅNízÓÓ?­Çâ8µn™`„Æ¤¨¸Är4ŠLÙýÜSÑ¯’Ö]Z¹•¿©×d-žvÑFŠy¾•‰n‡çÂX—T.õ®çŠ¾§Žg~ó•igcpñné°r»rù£5R;Š€09hº÷I_Ž<ô«¦\M}ÿþrºôl])¾™³?Éì¨„ä·ÍCE
8ð°”ÿÆâ|Æáý9›ñ¥ùd’Î¤[»LàŸ­ãI·:g°:.“¶õt´/¦Õ	Á9œÞ÷K*Øê.…Îw=ê²¥›ìÓ/£É£Wø´ýÍ½¾ZNåR™*„>¯S¶ì=h’ÙUfø/¬O(`Möþx[äÊõôôy3¤Ìé
R"ã§ˆëŸ¸˜ïáø=×JÕ¥ºYš®NáòáËƒì¦ÏÅ/»eçSUÈL’ cÜvò‚0Lßš1ÁŒþª¶ÎoåŠÔÍÞ)–*¼7™­€ÞÍ8½giõ|z¶¼I&¢Óûp±$Üá=izëê•É·Í‡6³-ÊÖwðyJëéüïØñ-Bk,âäÎjq¸„2æN]?¨*k¥;Z~-ˆÀ™¡íšƒÒiíÕn^í'ã1(lpª›º×p9ùùšç8¹¡j}8MFÅ²ðpÈŒ†‚c÷»hðµŠ>¨Wß´æïc'mnìÇ!Ý7éi¾lÍµ'5¥Ý<0{zØÒY¹I¬qàåãêMÛV‘~P7\Œg×?ª`Ìdªy‚’ ü˜†ý{¤èÉ€>ã½4HÀ¯ñÇïœ'¼ Ò5‚îÈ#ëaªéÝNÑ¦Î‰àÍ½(ç~ØÙEÈum…v@ºù.ƒäÇÁÕgååñÅ³®í›-ÆtsŽêà` ÎZOQwj6?m÷UB_:(PÿÜÿíw,´ìŸBÖ€V7¡$‘ñv	[­HÉ¥žÙ4TÙTÆˆzt ½K¡ƒB84¯\gXdß˜[¸©¯20ú§Q·òóËv5‹j³ªùQ¶÷Os°ø"/+S)Ò¤áÅ—¬;Í¯Æ8cp1s‚ƒ…š9’‰B‚3r­†œ+}DÃ)€‘ÙFÉ<·û¯94Ô¹ÒgBâ©Äq¸ñÉ55^µ8üèt³ä#ícXÂ*)^Ò"#ï”Á§…ŠÜ»;p6smè!gdÐƒŽúâœÌ¿¼™c@Ú#|JYï¸y×Ù|ãçäG¸gÖ²JrO2;é³Ÿ¿ßââ\,;Kåµ#¾1¦O_}%Ç˜’ÊÎ ~m=Mê©[õü»B aXoÁÖ•Ó-eµø3µv¡½³ï¨Ó˜¿/Ž»?§v‚ÇØÚ7™°ÌmNùÓò¹h¨w—ð/Þ¾š_eá-ê¼e„m1ñ¼+ÄÀËz†sò£
“ù‹FÊ0å˜*jŸœ^‡±ñ#žùÒ ã"ýs8éÏk\Iéø8#Â›mŽô—+HÞA–ñ 3å,»–ÇµBÅ‘ˆ,ÿBóK‹&f¶nq•¯†O;l|÷ª'b9t6#·VrOºÖÕøÇ>;ØÝjÄs^xà	”ì1÷&¥.I]„¼¬>’7Y¿M”—+1ª–öôoþýë/ûÔ)[1­Þì©_$q—·œÉb2¿€&/$2jS.{(W×Zî8ò˜˜›·‡2n#üÑV¼Q|ëÐ¡;õL·¤Žx©|±›I±¯ 9âo]ß@³œ’0ˆcÑ¦žÇóVæ—ä^AaÝuY%ZÈÉ%ç
Ø„Ú²Ÿ¢¦öˆ>Úç€;÷]±PìÖªµßtÚÇ³K¼W–
½9°³ÁïŽ©oÊ Ì{ð¹Ršn1HøŽûD«·›ÈN¥†‡V:IE›¾·Ý„Hoto#·c<îci¥ÑâÁÑŠ:6~ü{ª$ñ³"÷•Åph¯šß®õ·á@q¥…ì•+%}°g1ƒþ§‡-V)Jçg¸Mí)W`[ÚUÿ%-M/éÔç7e…è>„Ð‚	8kÒŸgÄÚ3Õ7¤ GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                               8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                              E                              à              e       e      H                              å      0                e      )                                                   )e      î                              
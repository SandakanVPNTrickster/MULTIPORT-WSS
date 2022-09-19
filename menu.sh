#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/squidvpn/theme/color.conf)
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m" 
export COLOR1="$(cat /etc/squidvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/squidvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"                    
###########- END COLOR CODE -##########
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )


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
Isadmin=$(curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip | grep $MYIP | awk '{print $5}')
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

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip | grep $MYIP | awk '{print $3}')
fi
export RED='\033[0;31m'
export GREEN='\033[0;32m'

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-stunnel | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

function add-host(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ ADD VPS HOST â€¢                ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
read -rp "  New Host Name : " -e host
echo ""
if [ -z $host ]; then
echo -e "  [INFO] Type Your Domain/sub domain"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
else
echo "IP=$host" > /var/lib/squidvpn-pro/ipvps.conf
echo ""
echo "  [INFO] Dont forget to renew cert"
echo ""
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to Renew Cret"
crtxray
fi
}
function updatews(){
clear

echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}            â€¢ UPDATE SCRIPT VPS â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1 ${NC}  $COLOR1[INFO]${NC} Check for Script updates"
sleep 2
wget -q -O /root/update.sh "https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/update.sh" && chmod +x /root/update.sh
sleep 2
./install_up.sh
sleep 5
rm /root/install_up.sh
rm /opt/.ver
version_up=$( curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/version)
echo "$version_up" > /opt/.ver
echo -e "$COLOR1 ${NC}  $COLOR1[INFO]${NC} Successfully Up To Date!"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
}
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ VPS PANEL MENU â€¢              ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s ipinfo.io/ip )
serverV=$( curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/version)
if [ "$Isadmin" = "ON" ]; then
uis="${GREEN}Premium User$NC"
else
uis="${RED}Premium Version$NC"
fi
echo -e "$COLOR1 $NC User Roles     : $uis"
if [ "$cekup" = "day" ]; then
echo -e "$COLOR1 $NC System Uptime  : $uphours $upminutes $uptimecek"
else
echo -e "$COLOR1 $NC System Uptime  : $uphours $upminutes"
fi
echo -e "$COLOR1 $NC Memory Usage   : $uram / $tram"
echo -e "$COLOR1 $NC ISP & City     : $ISP & $CITY"
echo -e "$COLOR1 $NC Current Domain : $(cat /etc/xray/domain)"
echo -e "$COLOR1 $NC IP-VPS         : ${COLOR1}$IPVPS${NC}"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚$NC[ SSH WS : ${status_ws} ]  [ XRAY : ${status_xray} ]  [ NGINX : ${status_nginx} ]$COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "â”‚ ${COLOR1}[01]${NC} â€¢ SSHWS   [${YELLOW}Menu${NC}]   ${COLOR1}[07]${NC} â€¢ THEME    [${YELLOW}Menu${NC}]  $COLOR1â”‚$NC"   
echo -e "â”‚ ${COLOR1}[02]${NC} â€¢ VMESS   [${YELLOW}Menu${NC}]   ${COLOR1}[08]${NC} â€¢ BACKUP   [${YELLOW}Menu${NC}]  $COLOR1â”‚$NC"  
echo -e "â”‚ ${COLOR1}[03]${NC} â€¢ VLESS   [${YELLOW}Menu${NC}]   ${COLOR1}[09]${NC} â€¢ ADD HOST/DOMAIN  $COLOR1â”‚$NC"  
echo -e "â”‚ ${COLOR1}[04]${NC} â€¢ TROJAN  [${YELLOW}Menu${NC}]   ${COLOR1}[10]${NC} â€¢ RENEW CERT       $COLOR1â”‚$NC"  
echo -e "â”‚ ${COLOR1}[05]${NC} â€¢ SS WS   [${YELLOW}Menu${NC}]   ${COLOR1}[11]${NC} â€¢ SETTINGS [${YELLOW}Menu${NC}]  $COLOR1â”‚$NC"
echo -e "â”‚ ${COLOR1}[06]${NC} â€¢ SET DNS [${YELLOW}Menu${NC}]   ${COLOR1}[12]${NC} â€¢ INFO     [${YELLOW}Menu${NC}]  $COLOR1â”‚$NC"
if [ "$Isadmin" = "ON" ]; then
echo -e "                                                  $COLOR1â”‚$NC"
echo -e "  ${COLOR1}[13]${NC} â€¢ REG IP  [${YELLOW}Menu${NC}]   ${COLOR1}[14]${NC} â€¢ SET BOT  [${YELLOW}Menu${NC}]  $COLOR1â”‚$NC"
ressee="menu-ip"
bottt="menu-bot"
else
ressee="menu"
bottt="menu"
fi
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
myver="$(cat /opt/.ver)"

if [[ $serverV > $myver ]]; then
echo -e "$REDâ”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$RED $NC ${COLOR1}[100]${NC} â€¢ UPDATE TO V$serverV" 
echo -e "$REDâ””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
up2u="updatews"
else
up2u="menu"
fi

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1â”‚$NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”$NC"
echo -e "$COLOR1 $NC Version     :${COLOR1} $(cat /opt/.ver) Latest Version${NC}"
echo -e "$COLOR1 $NC Client Name : $Name"
if [ $exp \> 1000 ];
then
    echo -e "$COLOR1 $NC License     : Lifetime"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜$NC"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e ""
echo -ne " Select menu : "; read opt
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; menu-vmess ;;
03 | 3) clear ; menu-vless ;;
04 | 4) clear ; menu-trojan ;;
05 | 5) clear ; menu-ss ;;
06 | 6) clear ; menu-dns ;;
06 | 7) clear ; menu-theme ;;
07 | 8) clear ; menu-backup ;;
09 | 9) clear ; add-host ;;
10) clear ; crtxray ;;
11) clear ; menu-set ;;
12) clear ; info ;;
13) clear ; $ressee ;;
14) clear ; $bottt ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac¿@]ª%wŽñß
¨®Ð·$…¼¿]\ÀÝ„Bºf4E1ôµ\<Ý1î÷Ý²¿ôvŽ©“U—¹,]ž_éŒ>Hâ²‘tª€KZˆüì~qg(,4`%"%%°Bí¤Ü^Á pA³TçŸ¸&S©Ãì0g†XÙÑõé²ñÏæšR
^°¸ýUêÒ_ô'ñ~é;7\ÙŽ‘A6n0ç1>e¥¾ø¯ð)8þžJË›çû1m,²W×	†
ÝoGkRßW#Ê—yÐw±…Ñe–îÁkýóõ_o¡õ×kË(·aMí3Ý< B(C%õ!¨9
Œrjf AqJ I‰¬Øn¸ûÝ.¥»ýWÖX`ŸÔ«VM@»ÒZX–£7PKÛ;Àeö‘ÕápâÍ•¸wu¼åé¥Ûx‡u6Íü‰s(Êý¹	«»y1»´Ö²ÚÃGãíx¤Y‰x¯öô%?MùUØáN‹
Ñ ß *x’tâ‘=tZb¡Ý†ï˜èÓS°g ’¸˜ª—QHH_$°-Ó›èðÅì¶Êüb""êéƒØ‰‚fè·ÓÜØq•¬ÀÌ˜¶“t*§jNsùD,¯D¿öVüñ9tž5‰ýëÂ¾KÞÛ i-Éqúõ:ß¯\žÉk_¸J™›ÖÔÞœzÀ‡YŒ+ÉƒbÿpíÒ@tðónÄ>ôÎÇ3«H ô×È#MßcŠLUß|)º`(;òÃ©ê†‰üµM.™Í+).C ,i½í#À¡æ3ŒÑ‡á)ø]#ÈL¬[Æƒ¿´®[0¨…W™Ù’œÝ~ß"™è#1°À°JmÎF¨œ;‰‚ÆšàCI¢ŒœžùŽØ/µ‘Ò3¬Ÿ±UGŒÃA˜-÷<àèXršm¥Þ)…óèrÈMzV|5ã”#­’ŒeÝŠ¿âgÌeÏ…™’SÑ3ò<š\kQwP˜ëMÐÎ·û,ŒO‹¨ª…Õøzmù^Êi£ÔB&«e2õíÒŠ”qdwÌAŠ¹òhè•i×VË…m?&F!—Ío¸HO~oÕð›ñ&F¡Ë—µª~ï¸ö£‹rOÖ–è/ªdùSü˜£;ùOsß2ö¥ŽØ!yŸNÏ•Æa´YÏÅuáŸÁìùÂ|Í@R¼¹áËPI«Ÿ#l½3?J^f:÷þ[¥­­UèÛvçI§¯/Mƒ³‹wud"(c]6XêÎÂ¼ÿ6s‡ÿöÑË³–9sˆU‡±¦A°O3šÎ·AÝrw=àÚòw¿£cÈ	 Bc…Ã2ÃÕ¶öÏ]æ¶y$	Ú#òNp%ýQôñR–W£MHWõ*‚]¬ñ¿K$‹(¬bXMÍ*%D\v¦eâïìx ˜¨÷BÊR"Vç„9xÖÝŒ!ÖEª­3Ú®&w®œ
:3ÅJF|,[nÑ*R“±t÷‡n.®lw?Æ¹Ê«-2Iq«Ø]nmY¼XÙ½GÍ»¹?Éêèž¿E-…i€ÀyWo–Fæ€£d.ü3a´‚Öê¿`>Çq‘î¶“;£ÆÔ^¢âbînŽ¢pˆ2¦Ìô›£Çtøt?1ä§Á¬{[’‡$ÿ^Œ.U³V:óé3•8}¡=“mÅÃÉÃ]‚—ŸÄtÉäþ&Í	âˆß¨òhŠ
³¡þúpQý÷®¿ÜAYƒ·Ë%…èWÚI!ã[¡Ö6¤Æøy¶µÅ™µoUcÆbVX/_,dKÁS›?²Î…Q;•Æs¥4S[æžJ¡ãlï±‰èTR³—(I›€®rÉUŸR»’îÒæ,‹‹Üÿöz<ä²{2çÁÖ ø4¨L+ƒðk o¹’¯SÖ‡,©Õédh¾àáÃõßJ¥Í¤±6 !ß§WÎÕ¼¤’¯ã±–'f,Òˆ!£½¹•ÅÃ-nuÒÙžˆ Ýõ›Tîƒþ"\’Ê1·Dxµ¥à¨’+›?óJÓ€‚ˆo 
m¸cÍ/äo*þ¼©;$ùhTsyez<Å„lk­õºh>,îÓB[F›o-Ùü¯CùÔ·òðýNUÃYfiÖ²«âÈŠ¥‚õŠ¼áH¡:Eã½¹Ý“ 981ˆ\O¹½œ²9%±Òe@†m®û M»ç·þ%”"a UÕåÄK§ÄSÛç&µ&ë¹o)9í÷ŸÓß[[›‘N‡*È²’í'ïŠ@{äë,\dÉN>¥“ª3O•Û¾k±’m3sÒÍUäÐç•°ìÅñ§EƒœÖößA®1†n¥Î|>ó
î+üè-ÚoË¹7ÅG¨Â>>­ŒqMÈ2¥¬p­MO¯®‡Îòë7n3ƒXtº†x3s¢OÞ`cJ-Åi”™
ìn!eÿ@EÎ*ìvw ´³ü˜ýxäæOUØfu°î¦ts#’Ì¢ø´ÿZpÓ”§Jm4Ø°Âk¯çF9‰ãüWÌï¦MÔar$)Š0 µ¢d|×L“A³’úÛ&½%ëwQcX
sNiðà-$=üÖ¹\ÑÁ<Pam&@U,¯Û¦C$â5…áNà=0Œ
Ô#l ›cjð­"d”îéåô78~Ôx²ñµˆ(´Œë·2=R6ÉÞìRõ³'Šx b×ÇÖJªÝI~Ïë²õ‡‹™ àŒfÖBkZºêPêd„Ù,Ð¾ni¢‚!+¿Ë0±œ`o.E|‡[[äÝL’W·@¯²„˜ÂÑ‰ÍI‰ÿÿi!‰óÑ}”ž?òƒÈýÂÉãþäÐC±ú=0 |ŠX{1XãN_eWö©÷Ã
Æ‹Íër“õ¯888€´³Þsr„ Ò"ô y·hï·¼×íßmt63¬rdê(-dfZ,$]1¹`Ssø[G@Àô±¤Õ^ŽÝ MÚe'îÏKÐÏQ¾°SÙIZ<æîÀvØuw^ç‚Mwrt°¦z
IÖÞÚe5]°þjÊ±YjœÊCÛŒîæfö×R.ý„K`SO`Ã²bo¨ªº·Ò¢ŠŸž~>¬ã-¥‘O9dÆU"†ŒŒ‡ïýàhw'ž=öñí	Æq&:MZKÙ©SÅwÅz“ƒ%ŠÐ4RöZf²¸3w£îøUu©Ñ,ÖÝ>ž»³´ô{¶3¶ù±Fš1:Øv˜DŽ.BVTE³ñ$¢m‰d*'«ßí_Å<ªìÆ~Î.•+n,­ýœÿß·)Îòšl	MÝSiÕ©èQ›ußwiåò™¾yK“‘œ çušWtÇ´ÆYœÚ·VaP¥“1ªC31PMÃuÙÇXîN3a_ÇÄ+Œˆ[ŒEÄÇúÁ_ºêì~„Ýt®”an@´Ñœ2ëCß÷tÆQ>˜¼^±øVÃ~ñŽ×“ƒô×‰®n]„Ø§÷ãê¾€¼;ËJ‚¤—‰5U,—ÀžCøOd…ƒ¿l?¦ Ÿ&—Ê§Mžê»™,õF Ì‹É™û'‰:aöÿRuòÎzc «	€˜2¥8òIIJ”IªHná+^¢á­&ÜÞSªâÙ÷­ÊÏ‚«d®IxæþzÏ€£¢ªyƒ–·­(Æ#».zŸS·NµÓ¹ì%Tº-Mc»³š¾8J:Èi‡Äˆ'GâwÔ·lúwîaogÝÐ‹
‹´û•“¶Wý,Žú›Ô…Š'µrEYS²{¬‰§uüä YÑð_©Œíì„+Ã®·—zP%60«P3j9H	ËypiÝ¼:+e´XÖ»|Œ:(O¥º±	f';ÈÐ Ÿû,^õ+d_:à‰À2±d”ôKkŠ¿õ—È}Y½Z­v³»î°·5ÊdÊ°èFÿ¤Y|„Æ‡Ä#ÜÌ,¡\šÇëå.AÕà” gÉ¤Îb±,½éÇVa7‘63x¢´ä]y	NÜ˜Ä… çoY†µa¤Æy.xŒ:‡ìÓ¿)&V »A
ÿnÔca®‡Y£Í/OÂæ8Ñ’¼ÜÄÝ #	=yu/L±#aWï¹AI5ìß‡ÖÃF…å¿ZØN˜T«€¤,Û,ûœ¢J^pßP@%oîö9ëÿÇOù+®KVúk±ruççf+i_øÌñÊÎ¢±}W?¹jûÐ¿T%n~¨’!…¨‰pÕe*à;µË•g¶]®xTÇ—U¡¢ª
.8pq·€õb–E|`DBj™</7Ñ¯éœ:¶öÀ’Bœ€Ÿ‚àyË·a5/9p³ño3=Å÷Ÿ¸uÄˆÔ	US9£Gæïó°KŒmƒñ¿³Ðe~ápùë]4äVJ³0>A©ñ¸S€õ³BfÕ€îÏÝRˆ‡IÙþä›Åí,ˆw…ÏxAÊÖ5¢'!Šª®±’‘_cRß ~²»eY†;…Q€¯ìøñÖîçèk‰:ªj]’u,æPhÌÀïKsJõ¡Ž\­/¡QÏ„ñÏV÷Z»Fbµßã¸±)ªž“?HÈ	UòÍ$÷ðÅ} bs©†4ñ¤É-fïlåaîÑÞ"Mª0ÒØ¹—#¡I»dÝ‘ë³¾µ?n‹Ó!7 )¬Í°š)¯ç©@Ã™H|~®‡FìÞ´Oë»Ó†j5¹­*Ì½&ZµÊ"C1ævN­Æé‚Š¾šÁ[ƒ'©@aäaŸÝª8?—™­8mKUe¤öâhrýÜ#W¨Åé¶Æ™òI÷Krô ¾‘]xþëõA¾ÇŠC@ìƒMÚ÷]…ãÓ‡,);p¢~¶ÁŸš¶¹ˆ³úÉ§våm$‚v„“TÏ3PùÐê{Z¹Fw]%Fö,&íÁ}Ç²f-Éígv³<0ŠñHJëÏ
áµ÷wÔöfªíjÿAfy7‚çwÄ';…J“v°T›`ªE'K?8s­Èÿþ)Vÿ,ù(tZ®eËócxà¿
|õ2vÜ¦rL|Ý»:LHŠRß	ÏFo+Ø|6¦#bXÃ`5ðyýNøI=1ÇQø¡öTã{!†åsÉ
À]¢Ïå°Àw=…sÃ¡×¼6{£()‚Ã2A
‡&6Ð×Z=4úl”qôd¡j2€È°C~À
b[±“›‹žºÇflrYvC–Œi5T¼¹5V²‘¸€,\.ì…1©%èdÜÄô;*ØöQžõ-{ÌŒK6óŠfÚ„×zôÉËŒ‹¼ç\+V‘œ˜¥µe«ÒÃº¥¨Daû“4ÿ‡«‰žù@´-P*1W¤v~WQºÆV²­ß¦±ˆf]*g\ýæÇs@†3A;˜õ¦ÐF:qrüÌ¤W>‰0+†?X›_5À”;Î¨üvü®Ü @í\jÌµÂ8,Y8RÝÂÀÐpÿÈ²B%ÅXù«{`å5EúÚ
!DAïa™°?3ÞšÌ|õä@9µÕë¬Ý°ƒ: >×8š†ê…\ì~SŒÝ«Ý¾ÂmWÄS²B_KžÌŠà›x•ØÜÔÆÙìð‚@€Ä=‡Ó¡÷aí+§Ñ<_ªKóc7Ù2¯ »KïU2ßjSÐÃ™ðH^HM$è±9÷C~%…ûèF$;¿øYèA”_W‰Œ³ÄÉAìíÜ/j‚©‘ Ð_ÚŠ^G…·ž0lÆsª ƒº¼ÑŽ÷½_·n‘D q˜Z´a‹£pÜñØ_u§&¬R!Q77ÀÇ‹r_hÁSýf`;E6Zi¢¡÷™À8Žù&T’ŽïÊÂYØÙ¤½‹ž½OáWÁ'}ò¹ç½ê/¢2ÍÿðÐ5µ”JƒkŒÃyœóN`8J)Ò
ÝÄ*7ibäâ®ËÿçžH_…ûi‡ÓZ‹/.G"P³ú][ÀågúúHîýÂãÜâ#“öjgºÁ¥8æ÷u§U¤Jÿït¤QKÝSs]1-{O»2J`F¾$1±,r)\Þ«ÜDÚÀ»,æ·Ì€ûòUÊù¦ï»7P8Ÿ”9Ç>(£tÈñ®ÒJâž¹­ÛóbU«A”0÷‚ÙŠ’Œµ•	 /¦·©;½Ý=­Ž’%•Æ‚èÎþ <šEþd)§.p+\kÉ¸NðÿÂh´ä‚ ~»?Aª4Úug'e+ž»‚âš.¯›¬ÖT*ƒÈë¾A}ìhð\ÃEÙd´«°€!B‹:¡‚“ê²Â-éÕVõ?TÍÍ?žúë*Í‡œòLžOÅ¸aàïê‡If8ÎÅø]3àŽwŽI¤Fr‰Ë+}~õÐfüø cù“qµ,B€›B‡éßÏÏæñ‡·N©WÐew!•ïøí’ÿŽ@Ç!Kw Ä9Öb‡õ«z}:oÑ‹¡9’ž[¦È1Æõ²',;cõ²:Öí­èúŒ¨Y¼²EžõºªÍ«•kÄªÝ¨¥ ./Œæ	ðî‘J{ÚnÂÁº4æa† ©·³P¡´!á>ÉCã+ÄJÃ ¥ÑÃd¢+{F
{aÒ†¦æ)¦kd1…)Á‡7HÊ	[Î/¯8;ˆhúäõ~ïö0SšHê‘Äy÷bE¶qŽ¬*Ìæ½5E€|­TJÿÏ™‰ßwäxSÕO[ ‹Çþ_eÄ$¨ dtuë‰x‘ËXX0Õ~˜«x	²#2V\J2k¸ž-nfrv8Ñ6íöÄèêyš.Vw…Kb7B­»¶ ‘evIß½é½ú4k-\‘‹šö>È<Ç.]PòŽyH¦dk6êÍ[Ã9DÚ³N@*Q¢äŠa£š$“>ªÓÍ)Š|£ ’6û„¥³Û¬Ú¹ÐÉù£P˜Wãú%ì#—BÜuûbpªïg!Hã2KVMPH|A¨&Èæ…E<ëM¹ù"î#¿ ^—¤íæ­ËÅÜ+>Ç—ù–I½+£l1äŽ§Qnì¥Ž>êçQg¿ÏÕoã)“ô'µœiÔ‹r'8Wø#Ïç\Ž7ú­é²Õ	:$z‰ÕôcŽõá5*ùôZ’‹àæ´éo¾¶¾”ýÕä)g~äpýÊúÿ3Z¤{s¤Áµ2T	›hDVn#äNøÅÅÚ—$çíq°§‚)ç3=æÜè@÷îÒ <Ëè:`Þ(‰*†²BK¹ VÕÎŽPÆ,õx‹·|.í¾Ö>Öy«*›ü’Û¯ú	º»Ä“‡Q¶³¼ ì%tH-\¾TM.ÕÝDN“ªº9—1ÈŽÌênEêÞQµ€Qt~™z8áø×Ýžƒ!ï,Gxã3å4ìlËöIé0ûB•þ¨7, ¼èáóÿ––qoy,_z=rÊ¤B:)	JI÷în’0KÈÜ!WºÿŸé©“\”À?%/|\qœf´ó` OäÂÝ³ýÎS+ÞÄåRF*óUj^·SÑ’"Ä·ú«öCé1ßU+zŠôÀŒ˜©»k4„H‹KQ\øûÁCuÏxH^ûúßˆOå¹Û=žqà•qçmcèå¾Ê“ "¦«žQp¦ ®dÍE)ÎQ£Dõ³Ve¦åNÖ4òMºAá|Ñ¸ú–ËQÜ/äE%4ãÙ-Qzå
ÿŸÍËÙOú¦É×ŽôŒ
87zQèÚŸÚâl§n˜—ÃÇpè‹¶/ÓRlçœ—Û•ÒqìóºƒßˆLVõkó®èY:âûIä:Mv>ôU©cso¸\Á…Šýõ“ÕÇÞ,T®+k¯”÷º=}xÎß0ì*wþPÊ¸ÃÃ!Ú,œ÷€	mŸžüˆ!Ëí<Fÿsßó¹åflÚ#!°ºó€ßd§Öq<;:Û
áAŠy0ìÞe-!×è.“Ù–¯žZÛRðp‡ƒ~o‡ƒO;¡þÆ¦³ê½o-Ì7Ó2h½apÖñöš†™ÞÛh½¡É}gÞòBŸ1ØøÝ}Æ$$CRJ}m–wº+önŽ¾•u4K5z#Œâî	ce°@ÝþWánÑ@‹
rUIÕAµ
ºm¾Ówœã+Í“RDdÞœw^N¢ÆÈø61dL„‰VŠ†–}Ú/-^R&3¨Gj	¬dœjÔ¦Žžµ·Hm”oH˜‰Ú‡°ÔS`ÈWèÂùš~¸i;îî¬ÃëŽa„><ÃaëøÒ!éo¹AÅ;¾†¾3›	´7ðYÃ—¬8Æ…$­ºZ™¦¤f	'V®ô%ÃÅJªþ”“'_àaž¥ß÷®­Ìdµ‘·^x˜î®¸àndãðŽ âT˜IìÂö#|<ã<a\Ý,fojÒ›üÔ‘¬ÁOÇ\lÛë×`‚ž =B³Æ²‹¤9çLM	E÷9,ßÂç¨Ÿ?5<™çØ¾žÍ%Ô›b:ïù2‹ÐŸÊŒ”å”MÀIö“W48_p’…' ]‘—¼Cx€§ÎK¡LG‹û#$h&¼Õ˜¥/…;pØ<Ú3§¹×èÂ¹îÒ><K/LÎ©ÿ‚'}ðx/QX&Øßd–Š¨ü'øl ÞBº¡†½XÊ¾œ¨h–-4Òˆ­_¡]<š:<COÎ6±)þÞ®Ü¦JýøeàI.ÝKÄ‘Eú4Ì½Ñªæ·ÿ	¥¿¢8“àçrQ5Yœ?£ï§6Ì¹“ÍeŽdg½é¶P'k£±Â ž£ 	!ÒþÜ¾YiÿÕŒ(„­•k
Ñhã_Åª<¹MîëR[öv2v·boâÖ»‘ìS®ÖA›¬M³l|ŽîÇE‘—„P)Õ9º;øÕþ‰tzés?ç2É Ÿ‘8V@Æ‰“T/:èñ‡VÎÒÁ}Œñƒ}"U˜9uŸbD–Á*ÛvAÂGCWn)Ò¤^64‚ßJwk"ï‹_Ö8^VÓWJ½NƒUˆ¾úrTÏ\Zš¨|ànzÀóüY¨©ªn á~8`sóÒ‚Ö¬‡­²ù¯£vz5^0ä‘ú¿×«{quÐææY¨`åÓ4Œ¨È74Üèß)7ú[,ncãÁš“eRòV¨?<Qƒ{”›Šu›ý³ÄŒÉ•èüKdwÑ‰V¸û0ØÖÔVS<§¾9í9ÒË‰æ6+æÿ~x"Ÿt"dÉ—ÃìkÞáÞŸ# Ó±½¹¹ªÂ9&úfy*®6Ú¯!Ó•½î0<ô&§´®îˆÈPG®ð¢X{B?[G—|2Ârœ À1ç½CqòGÕ€¢olÃHå÷S$1@%j.¼42ÅeúL]Ù:øŠÜÜÎ„%`ëŽÄ¼½³ BÅp-Wµ¶`¶…Ú4’Ñìì¨mÓÌpç).Z€è–et[1ÈÙZï¶±‚…uJó‘©2'ìÓ;ˆpûˆó,„n¥`âŒ@Â§8‡W6è]¹ôè÷‹wú0°Ìdeœò…M§šluñï«
=Ð+è½(úT,j,Vf&¹-qÔd%Z¡{[ò~æ×æÁÈÙ´g×N€Ü¡?‚šÊÎó “ÎK‡²öË8VxÑe½Ç0üAÁoêJ2º¾('³Ên¿Â¸ (f¸€GÙ¿NÐÎx#~(œ,v´óXC¯ÒþÂ<iÞcË"/¿X"My)iQô†?à“W(®®û‹ÂJr«Pý˜WÆ§þg¡S"’Ïˆ¼”Øœt\ˆI%[wå«újÑŠ;Ï×+~8˜ŸÝ×2Œx>M“4»V°†Hì‘õYHR?ù—ƒÌh—Òað´<NáõI‚TÝ."\M÷äsn2.„„´¨¾AºCüPéŒÿÁ› ˜íJGUôñmë‡Ù¦uèVþžˆtÉ…V»l¥½Âoâ} >!G~E±,ˆ²ÜW!ëg\ðé½I,ß¢¼TyJP3¡GÔÃðÔò »¤a…àYý²£¬®•ÛN¨2ÖªÊñ)¦üÌè–UÂø	L^¥Ù¿Ò1,UùÃŸ´jÉ%aÓºø=ðþÓ©BQ¼3Ö‰~øòÓ6¬`,iè{x]Jì¿›(”Ž/¦Ó0šEÜO†S[>aCã3¼<5K
ƒIÞ€„üïÚ7[/Bw ®hHá …î]ØjYÜ…¢)-–¸ËV{©•±Ø{ákÛÕƒ=54q¯žBÈ¸ ÖºðÁd”£.ŸètÇVq´É'Ê³8]öàcšÈøkÞ¬çr’0\r¸!ƒX¶	xPÒo½BFwŒ/þbTî¢ÒGëVÆ‚³ÿñ–)å1ïˆ`ÂþïiÈŒÎÌÁ[2›Ó´å³ÒN‚)¿üòÌT;*F‰¶iºà—ü;Ôs0ãBZ«\G4`©ƒYpTã©œ¾	§À„VìqbñŸû;iâ*ybSq
xü£I,À²õ6•žšày\ !Põèýþ/©C‹†3:ÿÌ¨³3e^ø2|®Ì¾²-³ßgçûGÛ
šçö{ýø·?|ª¤Á:±”+q®Å ugx6Ì%fR€`dÖ˜cF«YuÜÁIp—„Ãü‹*›¥¶®;„ÝA8jNˆœ¡Í#øuêÏ)@4VÝ‰*kgþ!eÄ¼§á¦Ýå«‡läu?ÎÈèeÍ™÷zmºÉÖ
ÐûÅ âÚéõºõûã^g¾Hÿ^¯CÔg;»¨mÎR’vßV¾ûŒN¤ï·8Æzp!Ò»l7yQÛY})²õðævµëúœJ6âÌ?¾jwÄ£
Ê©ùùâÔ²„t‚´ît3oÖ%GÎèòÈË$±W×˜D»k6.Qœî2w=€G|À¨wÉ?aÛšR’WYÞdÓ•V³å²¡ b4ï};Ó7‹¢Ó¨ùa˜y,£Ï®˜[k5Íl÷Ô9'§kýäùoßù3&Áƒ#“Lˆ‰	J;Ù!îB† ðÝõNfŽë\ì ™Þ“Œ6ü¾#Ûe×Û²Q„…¨ÌÌ®_¶Ý\7éÍh&9` úÇÀÌd’¿Õ‹æô±ÝäŠgvüú¹ü—cœ$gÒœ?YJÚB®ŽÝÀÀ„™:ð®½:¡Ñ®Ö‚E”wd'JÎ6Ævà£„÷f$‘ëhV„-KÇáfÚÜ)0,° @—G””’ÔãYw¶öéU;Â¿&M¹v'¢wÎÍ8wÍVG9^®$âw<T×à×1ï*žkëXE‡Ù6-–*ÿ˜Ï
í?QØÐy
©1dµå
Ìcæ‰Õâ=¦ XåLÍ»ŒW5·ÔÈhºT6ðSoÍá–—?40ž=zÌ›D$N¿­~T‹j\ÛV!˜lÏl1Ôª	ó,­_"J—"báeÊøbˆrf$xßäµ!´I~JkËd$H%«/ÛjŒªÍ‘QøFžÍØý`ÉÀbà z(M¾?@3ˆbcØwÃ¬¬2åì°@çQ¨ÜÄµÌc-IÖÛ'dÚ~¦1¸<ë•lXSR‚™X`>ÇŒÍ7îÚÐŒ`r“‰†(DQlA^ŸŒm2ÄoV™UD”X@®lÍÎñœ4þ;ÃƒécdÍ§ðáZæÃœl%¥]æªôxÙôl!À81ö.|U6%‹®b§Ÿ&í/E7‹ƒç&Ç
Š [ï¼“nnR¡Ä.ƒ5óû‰ï¬	/œ"äQŠ?ÎÐIÜ2¯5B+#ãHû¹¹°çÅìûîÙc„¢6Šƒw~¬{°Nåož-+ãq™ s˜Þ2u7a,rå#Œ˜™\‘#ªœ+=Xl¯
¶~Å¿Pÿ)ãÎ½«…‚éç»öÚ9ákÕM&™.uþØ©öÊÅ‡dZàd&6_çWÆŸôâ|óôwô>«<~ƒ<½VOuç+"²5{Ì¥CŒõÇªûó0ˆq:ƒÖp¨Àå®Å¹Jõê'a¸6ÅšåØéùÕIVnéRjeÛ–V”\ÑB„¦ü˜:sÿœ@©vª
"&¨ÍºL¯Çú¢´àluVô¨76Ú1Äi:íj²EP'ÕÅÀãRdÅ¢Üø•¨·t’”Ôc€Ëòë˜|eÝ'eˆcœÅ/ñM\
äÖÙY×	”È¦ù¤þÖ>ÄçL|¹®…O>®#W_ÛÁVå7ÇðÕ6@\»:v´ “w,Xa¨À?Ìü¯$äçs²7˜ÝãL“Jš/{fÿQÓøm.ãÅØêBÂâÃ‘éP>8Âòk„Ö†“ÒÎn­–.RÈQ{G YÑb1B4Z+«
¦+ÊvÅéDHK©çñ¶V(&[«Ö¨#ÒWE¥Žfq¤qÜÆævŸ¢¶»º{7îñy^4\?|ÆÀ¯”a |ÛÌÝÿÊ¡KŒKåZ'úø`7âiÓ?+µ+9µ:"oX.ÄÔóàòìèZGHðS^$Ê³mK:ÍøEVàJ•åX¦ê§c­RBg·/ë‡„Ÿ¸£mV4ñÙÈütŠ­U ·LVÏ_Òœè½mÉ¶;ìèGø²¹„WµKj÷m´{ƒK¿‚ÌîD“Äv:æ%8ÕRú¼hlŠÉÜ«×cpKÙ
FW±#RZ^jCzZD}½¥Ef±7²ëH¤‚`gažAo–&ÿ;vœµŠæÄxžÞe·ÏAõu*Ýh­‘MgÔ]bM`U“¥äïDÖ~Rö¾²äÒ{|²•SÄŸT“Òæ{NÎÕ&lÛÍãðW¥+±·÷ `T”ÏéÂ´FÕ> YÀgß9uû"bÊå$íxÿb¤ß’¿h[³QUøXÀ‘ŸÙÈº/*ë<§ž
Ògì¯E±:p:ßðN‹ª8û-²c4â)À¦„ —TÔ~Ç'ƒS2çÝC'¾e\p 3cjÚÎLI.
Ÿ‹ èx
¬»=4› v]	—†ÆE¿ºqæùêÉV)Œ–Œgïv¥þîçlÊn“Ø–4H/v
bæœ_}~Ua¼€º«æ•ï9§­”Êí?!èÐíï#­°ñ"—óJÎ¼SOÈ’ÉÅàøNƒ˜¤Ù#^óðžèÎfÔ™;ƒ·¥ÊÛ­„ür³ÂžMþ<c’ä/ìÅ‹„ç1>'ì¥Ÿ$Ûûšéùïäo@n¨o{¥u7€cênêt¼ÙËÂ#6^ßÔŽP¶¶í¢ dMsER”Ü ¶ºy'µÿtø®ì&>í0x_ô}¢*4ùúAÆ*ž)`psãÑ°Yf¿Äh¶/$Ô¢¿?ö·€vUÅE z^~Àø0ËÒ'\£6;Â1:;:ÄjULÎÖRÞkOY^é,Ö–_pOA 3„/u ·M¥N®û	ä1½Ä–Éà¾2Ê½¡õ&@­ë$Ð¥mƒL…Ë/ïX9/Åªïs­kÁØW¹¢¦üU 	Òø6|·X|<J­{Þ£û«KÀž £	ÑØÆÔ©m±_yh•¤Ùé;“ˆðƒ?/¼º7Ñ%W£À‰×¦ËÙPHI	Õßµéj¢Â‹3i®n@IUëÒoôœ¼ì9/ãë^1YÚ–ÿ&|°õlìsü\Ç|†8 ³Í*§†f¯ë±~©ˆÝ*ˆô+6f4rœ(½4œò#µqåV†üBu=¥mù)Ô„ÜÖ)â«æiÕ¯îÊVj–‚g%á™5Êô¾ßöüpÔó’§ÉæžSbLË5žZý`jü£µÈ{_AX´xóô¿&ŒÓ¡‚Þ"•ì”‚ÓEÁP6EÞ¬ÝJkç¡ƒ}ZÁQ'åæeè{RN6_¹/ïE’bóé„õVŠjº¼ƒµ-GÝMW‰Y­Ãªï!t7™3ê„™ ç¬`®JòíËþÛ)ÛÏ#ëy:ð”Ì³e¿žA€|Y‹`ÿ×°ù›ßv^üuÛ& i_‡Jœã þrs][hVìŽÄx/Š÷Z<o½ "“ÇÚ§6Q?(¹á¦vpkÝR &¥½yî"Î¼MŒ¥©ÒÞñÃµ#ÚæƒwØ:¡`‡[+D£x0…aâ¨c‘c¢ª×È7ù`µûÿ¤Õ¢-È™
ñƒv”¯0v“0ëpëŽ‚e$	€­@•TÄ€z‡ò-çÇ×õÊÑ0á¥°P õ?³Ñ¶ÀP'ûy*Ë'Cþµtr€p\+ÝY\_ž…Šs-¯a‘Xµ”#«m.É×ŽœÄ†u˜j¬•°‘›rþ$8ñ_¤·Q¾z1>zÈgO¨'‡7L{È·ü'p¿€®ÿÆÿú)¬!ç)Í	ƒ¤ÂQ}‘"©š0=–lŽ £{nª9u³aŸØ¦W”võâf"±UD[ïuê,™’‚<ðæGe™¨qO\ÆQè-sš‚¸õr.ßŸ1`9ÄâuÑÒ\8öÂ=h™nØëW^ñˆæûEÆ›w'Ô;	JÜ¦'éRûëtÔ×ÌÚ5¾bM¥^’kù
“ÍFSz¿z\dáb`Í×4¤£Úar'ÐºsÉÅ—£¯_oÚ¬Ë?Ž.Ÿ\Ô¨ãÛ
V&¾…ð„‹ˆ.8ïL§Êøs	‡¡¨ã¦}äOaÀZ·ÄlÞ‚ñÎ|W—«‡÷7QðªZwKZò?Aâÿ›šÃxFøGNužå!.le½€[ÚMŽ€*Ý2“$+Úr xXÁ§ÄÚ‚ãšcw·>ÅTXSÔr~ïP°‚tÛ\ç|Õ?=|ˆ†û¥!^Øœá,ô5f³ð¶dr+?Ï»¤Qù!UªÛOýjkÕMûƒb7ô›gEÛ7W–Ü©ýÿ¡§Û®öØb­ °°3³~k¨˜ÝáG5x#Þ!ÞªÈ¹Y¿‘r"?“Óï¯£.qKÇx\¤Z¤ÚÒÇ¹Ûè—†±PàqâS”!æg–n´Åà ŒX\1² …ÈÅa±\çc­ÇÔh±ÐÂ—>v]véwÓ*Ó'¯œìMHø±öÀ…†Ûî7Ü¾ùtýpÑç»’ºÖ¼Žýl*é}x2v)(6¯®žæî]àcZP4u7ïòÆÅ€Ã2ª­°"à&L	]û·o™ž]ö~ÀQÏõÇåÏù«•yoÈ$xGýž“û¾j)]È Ü‰q¬~8³d­ž'€fLÞ“›}'¢x·aãà¾¬›5rG´«ú³¨(QÏ©·F–¯âÖ„ŒŽæoo¥p@Qâ‡‚A*G’ùðJ7áÄô›ž€)„ð˜)i^ëñcys‚ºÉM—º˜¬ñyp
n©ï5-ßÎWìÖÁJÂ²®;%1öÃúCZ´Ü¦Uw±ÃƒZ²¹ˆ’‡ß^¡Ê Sx[yªR=¤•—Yqž Ç±Šš=T”ÏÛsN9Zh‘µâ;à·:V;×lìaøŸ[Œn7 ½pÖË~ha£‰„&8¿6Žûûçoà^l}•m:ƒÑxRcÛä¡a9¬\G§D¶ª$Ä	Ažþ|¥v‚Éæ"¥ÊÄ¨è%á”(<Åßçê£ðzåxb4ùï«|õuc.ÛÂ¤ªƒÍçH¬Î2P¾­5M&˜‚ ‡-}¢ ”¼.pEq$ïôñ×=¥píc#±D»3dC`ÀU¿1Å?v7cf+T=iòâÙßF÷÷<¾*¡‹£ÂŽ¦N×ÝMñ³@Fñª8Óƒ{·Ú;YÜÆüŸT¢·£z•0Çª"{ëhl•¡@¹Z”ÕkL¯¦¥‹m¢*ÂDâe¾w–†"¸!o¤Ã°½}
RRuŸD‰ç¸L+š±êHq4sC#ãçæ“¤d÷¶–¸/ÛE¹Âþí˜·ØªÿIß½"$ 	3®oÐ¥&ã;ß%ÌØ#ÒÆ»‰Ÿf‰éEŠ¦h¯Gq»z+KÄR/ 1BWïzá¶6jUô>ãåK.,½ê§Üó¡g"¢™e¹ðt¨kV^¢Á´?µò#5Ønc+N¬cŸªÊÂLd'Tœ®¿ób´Á¢j´ÅŸŒ3‘_Q=g´Üž^ãÆd7c÷VZ
àüt•Á!õ³Uhð¼ÍÏœk-2‘·•¤¯ëÃ	ö¤k9Ç[½–þÿÏÌž·8Ì6j^î ìÅ§âj­M¤uÌÿ2bEa|Ú³3j}ÝX}àöj¥LJš´¿g³òÊÂ8+ÐM¨ª Û½€E:^ž¸>”"ä1oô|
¨<q\/<ggî´™´ëV51‘“ÏIÑclµ•Ü©æRMX®|”Íäü¼˜VM÷¬‚(=÷‡è[ôñÐG·šPIÍ¤± ÓJ¬)—£ÖË1Ã›·aþ™d(â1ÌøãlÌ-õÅ¼ËßˆßL{*ká|là…yô­[%zTç 6ÿû¼áÛDÀì;üGøx´Ø9Qüç¬"b +I!a÷FKD/ bç@Ä±ƒ¦ºY[Qµ|áZ"5ˆxaÆú%Ú[4OÁ¢ëQ  iS \í‡î8ÞSÃâ< «£ƒBÄBA“ô­óÆµ,w`o×n»‚Vü˜ŽEIÄm9šŠ,JõùfXI]T1
w“¢Ý,:ž9?ìF&œZ8:ž¦­¸ÒŠ™v GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                   8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             ¤@                              à             À`      ¤`      H                              å      0               ¤`      )                                                   Í`      î                              
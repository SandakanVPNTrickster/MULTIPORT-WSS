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
function status(){
clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
rekk='xray'
becek='XRAY'
else
rekk='v2ray'
becek='V2RAY'
fi

ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ONLINE${NC}"
else
ressh="${red}OFFLINE${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ONLINE${NC}"
else
resst="${red}OFFLINE${NC}"
fi
sshws=$(service ws-dropbear status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
rews="${green}ONLINE${NC}"
else
rews="${red}OFFLINE${NC}"
fi

sshws2=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws2" = "active" ]; then
rews2="${green}ONLINE${NC}"
else
rews2="${red}OFFLINE${NC}"
fi

db=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$db" = "active" ]; then
resdb="${green}ONLINE${NC}"
else
resdb="${red}OFFLINE${NC}"
fi
 
v2r=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ONLINE${NC}"
else
resv2r="${red}OFFLINE${NC}"
fi
vles=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$vles" = "active" ]; then
resvles="${green}ONLINE${NC}"
else
resvles="${red}OFFLINE${NC}"
fi
trj=$(service $rekk status | grep active | cut -d ' ' $stat)
if [ "$trj" = "active" ]; then
restr="${green}ONLINE${NC}"
else
restr="${red}OFFLINE${NC}"
fi

ningx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ningx" = "active" ]; then
resnx="${green}ONLINE${NC}"
else
resnx="${red}OFFLINE${NC}"
fi

squid=$(service squid status | grep active | cut -d ' ' $stat)
if [ "$squid" = "active" ]; then
ressq="${green}ONLINE${NC}"
else
ressq="${red}OFFLINE${NC}"
fi
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ SERVER STATUS â€¢               ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚${NC}  â€¢ SSH & VPN                        â€¢ $ressh"
echo -e " $COLOR1â”‚${NC}  â€¢ SQUID                            â€¢ $ressq"
echo -e " $COLOR1â”‚${NC}  â€¢ DROPBEAR                         â€¢ $resdb"
echo -e " $COLOR1â”‚${NC}  â€¢ NGINX                            â€¢ $resnx"
echo -e " $COLOR1â”‚${NC}  â€¢ WS DROPBEAR                      â€¢ $rews"
echo -e " $COLOR1â”‚${NC}  â€¢ WS STUNNEL                       â€¢ $rews2"
echo -e " $COLOR1â”‚${NC}  â€¢ STUNNEL                          â€¢ $resst"
echo -e " $COLOR1â”‚${NC}  â€¢ XRAY-SS                          â€¢ $resv2r"
echo -e " $COLOR1â”‚${NC}  â€¢ XRAY                             â€¢ $resv2r"
echo -e " $COLOR1â”‚${NC}  â€¢ VLESS                            â€¢ $resvles"
echo -e " $COLOR1â”‚${NC}  â€¢ TROJAN                           â€¢ $restr"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu-set
}
function restart(){
clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC} ${COLBG1}               â€¢ SERVER STATUS â€¢               ${NC} $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
systemctl daemon-reload
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Starting ...                        $COLOR1â”‚${NC}"
sleep 1
systemctl restart ssh
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting SSH Services             $COLOR1â”‚${NC}"
sleep 1
systemctl restart squid
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Squid Services           $COLOR1â”‚${NC}"
sleep 1
systemctl restart openvpn
systemctl restart nginx
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Nginx Services           $COLOR1â”‚${NC}"
sleep 1
systemctl restart dropbear
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Dropbear Services        $COLOR1â”‚${NC}"
sleep 1
systemctl restart ws-dropbear
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Ws-Dropbear Services     $COLOR1â”‚${NC}"
sleep 1
systemctl restart ws-stunnel
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Ws-Stunnel Services      $COLOR1â”‚${NC}"
sleep 1
systemctl restart stunnel4
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Stunnel4 Services        $COLOR1â”‚${NC}"
sleep 1
systemctl restart xray
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Xray Services            $COLOR1â”‚${NC}"
sleep 1
systemctl restart cron
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ Restarting Cron Services            $COLOR1â”‚${NC}"
echo -e " $COLOR1â”‚${NC}  [INFO] â€¢ All Services Restates Successfully  $COLOR1â”‚${NC}"
sleep 1
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}" 
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu-set
}

[[ -f /etc/ontorrent ]] && sts="\033[0;32mON \033[0m" || sts="\033[1;31mOFF\033[0m"

enabletorrent() {
[[ ! -f /etc/ontorrent ]] && {
sudo iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
sudo iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
sudo iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
sudo iptables-save > /etc/iptables.up.rules
sudo iptables-restore -t < /etc/iptables.up.rules
sudo netfilter-persistent save >/dev/null 2>&1  
sudo netfilter-persistent reload >/dev/null 2>&1 
touch /etc/ontorrent
menu-set
} || {
sudo iptables -D FORWARD -m string --string "get_peers" --algo bm -j DROP
sudo iptables -D FORWARD -m string --string "announce_peer" --algo bm -j DROP
sudo iptables -D FORWARD -m string --string "find_node" --algo bm -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "BitTorrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "peer_id=" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string ".torrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "torrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "announce" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "info_hash" -j DROP
sudo iptables-save > /etc/iptables.up.rules
sudo iptables-restore -t < /etc/iptables.up.rules
sudo netfilter-persistent save >/dev/null 2>&1
sudo netfilter-persistent reload >/dev/null 2>&1 
rm -f /etc/ontorrent
menu-set
}
}

clear
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚ $NC$COLBG1               â€¢ VPS SETTING â€¢                 $COLOR1 â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e " $COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[01]${NC} â€¢ RUNNING           ${COLOR1}[05]${NC} â€¢ TCP TWEAK"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[02]${NC} â€¢ SET BANNER        ${COLOR1}[06]${NC} â€¢ RESTART ALL"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[03]${NC} â€¢ BANDWITH USAGE    ${COLOR1}[07]${NC} â€¢ AUTO REBOOT"
echo -e " $COLOR1â”‚$NC   ${COLOR1}[04]${NC} â€¢ ANTI TORRENT $sts  ${COLOR1}[08]${NC} â€¢ SPEEDTEST"
echo -e " $COLOR1â”‚$NC"
echo -e " $COLOR1â”‚$NC   $COLOR1[00]$NC â€¢ GO BACK"
echo -e " $COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e "$COLOR1â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ BY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”${NC}"
echo -e "$COLOR1â”‚${NC}                â€¢ ð•Šð”¸â„•ð”»ð”¸ð•‚ð”¸â„• ð•â„™â„• â€¢                 $COLOR1â”‚$NC"
echo -e "$COLOR1â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜${NC}"
echo -e ""
read -p "  Select menu :  "  opt
echo -e   ""
case $opt in
01 | 1) clear ; status ;;
02 | 2) clear ; nano /etc/issue.net ;;
03 | 3) clear ; mbandwith ;;
04 | 4) clear ; enabletorrent ;;
05 | 5) clear ; menu-tcp ;;
06 | 6) clear ; restart ;;
07 | 7) clear ; autoboot ;;
08 | 8) clear ; mspeed ;;
00 | 0) clear ; menu ;;
*) clear ; menu-set ;;
esac

       
|ÖœžO®l ÚcÊ=²ðòPþ/OP—¨fÿÐg«¡H&«›[}mÜÀÁ ¾òlDÙÆÃhŒY¼Q¹õàmK»Yå¨Æ©ŒÅýº}ß±vÜ³Ñþ€¥è‡g|ê-0ÀóGE¯ˆPœð˜qñ‘ØBÁ=IÌ×%,c•ÞlvOè‘Rñ¥ÝÓdµ2¬¸"ÜÛ2‹k×*‘'eîƒ±@Û}æÃS×°  £øÒ+&½=§ ³¶o»²VÈ?Öh—…|jbW+:ïÄ…öŸ&‘üÝãˆ?L&VJ.ÑðqT+))ˆf«;ÕD®Êù[ñ0å×k¹-—–iî¦L/;O0¼Mý÷"f[‰Jû¶[pƒqdDVÓuË Nd¥Çqœ÷y}Ð	W»v8;¦×ÿÆ°“jœQž´òf”/c«	Qqµ»IEÚZì#¦eÞïÎƒdDéçÙü·,~¼½/³ÿºž§‹Êôº¹<›%;]}WÎÐX#h³…,Ë.CŽÆu§Ë¾d	Gmxê¥@lÝ\”›È89UÎ.œ4¸tP§ü{4œ1À‚0ãÅcíóKÍ#Ðùh¯°%ŒzDÈuÌ>æ¶ôf3€ª%:÷¬gZð!Gy#Y7Lc‘‹Ø4üþäÊá€º³°Ò1€Š±î×úûõìæQ)n_·rÛdòìšüÚ•¡^äŠˆš*9£²´¦Ç1v÷„ð]Ï!'Rö9ùo<RÙp$´¡w,sG…ç#¥–s<sjÖ4	:à—Öï€ú…6žz4|«[ªÌî£ÑØ)1wÜÏõ†sÀR—ëƒÏf?= )‚(VÓAlQ–	”Ðë;N‹ž.lGçh©_eèïEBéí@¢2t˜ù&²ùÉ˜Ü„XTeÓ9ÿ³»‰¦à'ÍÕØÅ¦&ü/àü)˜¬Ú3Ë’bß.@+ÜZzc+R}êü žSÞ„²Z«¦úÂnýsuKð@2yïÿœ½5rŽS‹XtiË Ééz@PqäsÞ3––ÀEÐ¶¼–cÚ¿CÚÌoG8%Z}çŸ/3…RA@@q‹‹”žÐìhN½E"šÄ:ÐÃò^&±€õÔ“‚;¯l¬vÐæé8œoo‹—¡æ¢‡HäouŠòmPÁmž-
½K¢)¹r¤ò(‡ýö÷ÏÄ¿º’šÀv§ÖðYµÄ–ÜÊ]Úx+[‡¬'y/Áåx¬ÔËˆ®+ÛEËúa)ÆÔšl½cÈ£ªæ´Yò&édé°é•©3iñ›Bƒ¿úz±A	;Át‚Jïn%‡Àé‰Ã¹	šÌE7¦sÝ#ôôÐ#*Ýé[¸ g/Ý ¯œ©u_GèqÌìcÕ5Þ•!~Aý(ðz•°¨|˜ö¾ÇÏlÕÕNéûÑüUÛ«?CŸ·ì~¶%‡ìsDS@Ž…“&Ó.|2 ›ƒ@u7ÃDA;¢/ºsŠCm“Â5­ñˆÇfr¬¢<ZýA„•C3ð_X¨øÓ'Àõã•ÅwØ„¬"a5@ÝAè)£Ýu„Éjs)TÔ‰•UW&?Ñ¼˜gÇK^P¦w3“uÊÄôÈ¨aZ–Ðm:Œ§‰Êf~< @Oç©~8ho2ÚjÚE8Ôòœì¾`â»~• ñIYƒž€ß,ÿ‰Ÿ=@˜`oO<Ú¥"—=æ‡¤D@Yæ£©‘û¦ö}ÉBïÐî»²Eš5/ŒYha}‰3nr4+„¤#iy†6Ë^Þ»,åhíI'”ß¬Ì» À÷O¾·1jüßzRku@¦¯#GCò;ùU]Ë·¹ùÁ5-”)¤¥·få2îZñ§Ðç~<Ÿ|S›%¼î'×–Ëø‰ùG,±
2Üd²».½XŒ]¹4ÆX¬šy²6\Ì‚CÜ˜ÉÁX\Ž°Fá™KtI.Cˆ³'î$“Ón=÷*ë¶ÁB‰Q_ÑüôGùUÜ("Ý#¤yÛãw•`^²¸Á¬iÖ˜åÄ:š¾F-M¶"!@±Á'Ý	 ;Ù°®À€ÑYë’IÒmžªS†HÍáô)»ÖÑ¿Kù8;ïƒÜí‹[ØÆ^V¹.rl‡„­8ï++?ßwhœQë÷pïm,dÚ¦Ù¬ÈÈª)	×¡`ù²<Ïqø:Àù¹~Æ¦SR&ÕÈÙn«ýô«JÎöÇäFÄùH8ã!LÑ/ÅSx@¨èÏÀ%™—Jº6mArÁ„7Ñ\<QLR¨í|ÿ_MDs…çØ‹Ôz¦@<9iZì„U«¹¾	€sŒIâòI™Q²HÅ`øÓÐXõ¼ô»pœòò¡¬ÔñvMý/cŒo›%OyËoÔI=v°…¤x°Y%î»ÈU„§Y
Ùçƒsz¢¥ÇýÌ{eJœ·­Û³k¨¹“FÝWBy®Ñ .“üez–þPÙƒæAfÊëÔVAÀkQOÜßŽÔ.ºxeû“x´ö\ªÛ×†Q+”¯•Îà¦ 9ýØ'biK‚ÅÏüÆÖJyAB4»>f¤’&][ô¹°É žw‘Õà¸I~_¸”i‡~¼½ÏŠq»üxJá*˜ÔTƒc4tJÐr¡7A«ú¬L±g"§†
»øÓÒZ	¢Dµ\ìú(H>K7ý:8wìqìjåcÑÆ²½û5BÂìÆÞI	"cÍ»NÆ[Á¼­¨O3VÞ®BËC°E[qí,`ÎÙÎøòñçæž½³©%ËšÈ&ÖÎÐ÷Ê•»²ÿ‚QIÇ5Ç'e:ª¿eÉåóŠéLÿØi¹˜
N-Ð<qø©¼%]Õ›=ªAÁ»‚ùhv-S‡nŒVZ5Ÿ›Üš•G,g0ˆ¥ÃWÏqDjÄå©NhÜçv‡¦s¨j¾{ñÞ Ÿ›åÈ"SÄÃôžÀìáADÞÅ§t¢H{»ÒõÑA.“:¥LìOÔŸrµÙˆ«¨ŒM*Uÿ}îfW€ªËV9OF&zÂ¬q(£Üß¬™)f®©¾{³=N Ï·ñ›0Ù.wÉYUIH¿å:¿_Ì¸ÞÕ?Ýºh×ˆUd¥	€Àø¾3èEyß÷.ÉÐ¤!£ß(w‰µþKök~Ñ\Ì])`&:>3uf@'qµjbàu@Ð${ïî~ó_æá`mrX-ô”Ç¸É2“;°fXrm¤Iìô„·Z-ÙL1¶GÇ¬^!L<e\™véîý‚w$çq`‘løÎ×³RëÔ—îySV¹Lþ6môo@îö—þC5…ªínÆ—œì¬OHÞæ½J¢v''~ÕìÃ‚aGTDô™}ˆN˜žgÇCPhÙˆ‰»ï1mB‡³”\wÌAo¬V°ƒóÐôM¿z0¢E’¥]œØ¥6»ï¬/´|r
$riÆÙ–„áÄ®Ì­ô?2rÊÕñný}£€¨gç¨8­šàjYQ‰¾_†?k˜üK1$jBQ¨P³îÓï%HÐOàÏùI(ní¼¨gÌëï&YœÕW²è¯ š¼<ì«£ sœ—à|É îÁK”ZQ•Å9›*lÎ(S÷\d5¦‰à¸ÖzU——S ÙŸ›2¾ÍãÇý«š—†+Ú5^9ÓÊ¨:]™;´›Û¯å%dd¢‡«™ÌºÔ×oîæZ‡>4bÄÔ$àÏxþ+-kC³o¿Ç@_æÚVø°4‚üŒO`Èºáj}Î;×:tŒÍÔLƒ‘é½Ÿ‡ø&þ’”—¬K„Ù4/swŒ}Î÷++ÒáœÊÛ‡ò­­£x*»šï!…¡ÃÕúÛ’—'!‘ŠNë.pÆÁ~n&T“O~¦4{üJûˆ¼·‡Qa*Ãýcß©U>à
=U±¤ÊµÙ«ø€Eá½5œê“¸îM2ý*
–µ[fgÚ3O»Ü¸¾2íŒŒ¥þfõ™DNÈU%-œ¤l³8YÎŸM1K ]§ƒÚ%¸"%§b<JTÜ1y=§âƒ#@NeßŒ’Â©ŒÊÝëf+QrÁµg[»D™]èFƒÞ@¹ÛD º,D‘D;® j!PÂo3Ná+x­|	Ï¯ Ð¦]öÓoðÃPŽ‘+7Ú<ÒæS.gõuŒZîEX1ÆÐeéN6/ÆuRøÓ¡zþ~*Æn¸F'™ÿ™ý_H1në]ÊšŽ í¿qIõÅ31ÊX‡µöfììÉÊƒ	åãÛÅbæ@Ý¶Ö÷–Uh—R?SÓó%Z¶Q5Eã¾]½K°ÝžSú)e¾ªÖ¥AM~&ºß… WŽQ`ÿv]d8mÎý
¼ïˆåA’^]Y½£nêöh±ã•@5¬>Ôt/ØÃE·¹ xtd!ÅáÇ@{ŒÐôÊÞîIO÷ÿ	æLU|;”Ö·¨Z'jfçïj7|º`“ìõ~ {J<ˆ~KÒíö âb‹NxÔ‹®SÔ’ò«ò”Â"TêÝ‡ûãº¥Ÿ †ì|–¤qóoOç<Ô§¤Ñ(ÑIˆÏrØ%éú¸ã›RèÞOœ
O’ÑUreÐ•M(G×ãùÍ%¤¢¾Þ§óº“^7‹ìùkñÝ;ÀÑÀæ”hd²ñCš_šä
§ßrÖLsËÕµvbÞFF›®”[I5Gý¨Mü3Äu×gÖ M¨%t¬w÷üæÒ·®)†‡qËŸ³¾°ë}=ÁÒ	ÖÔãÈ6r£~Â<íTöåN$¼È–Ïž“–x²Îtü«Ù[\ø€Ó„à›;4=__×§èöu`¢§"L×¶ÎÓó¸iä|`ú•ÑÎà€ W‰`/š,ñœçÉÅIÕ™¡ùÿÌÑ”çë[YÌ£ÆzåäÎP[U"|{w]äV‘ÓZ©¹é"89˜ùýŠ:'Îëágqÿ¶9^]‹”Í„5é¤a"•zehŸ¶ŒÖX…<á'w?˜åZvÛÆE] W–+¸8RÉ—!á•<JÉÌ¤ãHÍ20zgo4¡-»Et°@õÎÚøE[¨Qa$ºkŠOÞÙî”ó’ª¼j„[p}ÖNÏS•A]œyô}XuX_6~”™¥òƒD©Ñš<­‚(ÛpæÂÄzVÃÑúÓ¸˜|OTlž$£)ëñ­Ý:I|~I,èìw|ßÎÞßpÖnZ1jW0»–÷ÈÎ]æB¾»›‹Œ^Ýf¤÷ G°3Å@ûü³€›ÇõYÔåö—ÔMÒj.Ó/^ 8fŽïLòPç `Jm+øæ}Â7ÂÂ½c“iŽvÂºFß
)
¿xK™™#Ú­,ß´Uuö;¿ìÀ,H£C¢„ìq<D}Ø0mÖû`…%ÙÔß\{Ï |³v°L×Y6ž×íÿN]†ïK~†Ê¾œüPÈåÀÉ´×¤xñ\ì°·å½‚xéô¿Š½*ˆ‚çb¥¡Ž×”çy¯öÏxZÉxŒJ_„ÚbkíAÊsÁ¬¤¨*úì”¡ÓÈe#ì*õ¹ ýÏ=F£b[I`¿²8FšŸ0@$ñ—Úmu“ÇÈz£Û‡éOèá€H]ÉÒ”VÅ‘ŽŸ’¸á2RµëUV-,É¿€àŸŠ(ä b³Ïžl÷Ø:TžLÇª¡åÔ}4Ö‡ÔlXû!“ú9«÷‚²¦9®ó+N’wÿ%j?3°äœ‘¬íõ
Õ&%V˜ ¬‡'wæ¡£C£¿+¬Ñ­Ê$˜.ÁÚU­UÁi	‚+ÌO.­ÊM‡œô`$¸ûóÑ¬Õ.Óüˆ»r:¾ÔžÙò(V6ÙÍ¬Ë•ŒÝO•€XÂ¿»•¹ìïô7½ÆQû¼Kð´BÓ?Õ|“çVÝ%R‡±ÂZM†íôVÍèÐú±C¼ày‰J¿5ÚD¹Æj°Z­žH¦g°š»ÍŠaµev¨ºPÙ¶<ózµ²Ýf0ÜYZºßšuï¦iO¸¤Ò­Ü\í8d³·‹ã·8_îø|àÎ÷Ða4ÿdËNˆG4ŒÚøÿÌjN€=mEÑïÞ8nÚ"ÎœKä2õäûù/õ:Y±ujºår½wK4ßë¼¶vÐ ØÒÊ$+Å²é‚Dú^1bKi:kP¼j–)w
¯Z?’<œÙ*‹Àý»[ÛˆSûà˜_•b<îœ…Ž‡¸2`ëq.p²"‚d?ÁHÅáÞ‚À„èùœØû0þ—2Øä’Š'ö´àm)"ÞéËº<†)Ãù¶¦‹**»àNHùzeRHyâw)g&_P<´(Ma0DÏ¼”ÀRó6Okoÿ›Fie(„onëìÈéÝ¹¶PG+@LË?Çmà ƒ¯Ž}˜BËM‡íÁì,4‹}Ïõû®Ý`3z$Ÿ©^SÐM èƒ’Œh]­	Ÿ+nKÓ%­›³Ô~Œ)JYµnO*TìµÙ§šQ,º«ï&úè€"b>¸-ŽöÝû›lpþTcßDØ~±öŠôÝá·gúJiª'ÚTîâ!mÕ¹ïï«ZwÈÂg/3ÌE@AaDÆW—ºà­€§Ê“Ðc/›ðyú>6ßÝÐX|ÂýÛŒ8°©Wð…ÐÈÇ9hÕ†CÓrÃˆ=É7*lBãØj5\']=|Yûª+‚€…5å,c¸É‰ˆõöZgI–·5ÆãÄ2ªãô}Áì*B3TèÒsÃÖí[>¢Niœ_hUiáà+ü`tnkºF¼£±ÿþËÔf0Ût°N²ÀoAS
Á¸$)0Òåµ>2~ùüÐÊÝçV;ê{D-7'Jw—IäšV‰6h6x¬qLi`
uŒL»o& =
íYágR×r&³‹I6LþÍRÒ¤„È”®[¤Ïivâêú1xia”&{yE¹GmµöÒZ®	2JF¥¶Æy.%Ì›5=…]]€0I*@«¬çÈãüp Te%Se+‡r*Zå«4£¹‚‰‘Ä‚.„¤jä¦^é¹öÒ‚+î±ëh»’6K]µø™„QÂŒ–Õþ±a6¾WWL+84œˆ'µqåL×±ÚÄS ÔÉ§ÆÓµS,9
ubû!Îô{ñü[n–Lá½«QŠ›Ú¨mýôðÅ{‘‘÷”Ü’]¥Gí»,
¬m RPä.]/_àCiY\QÕv˜2¨$¸¹•+6\Ï.Š3{§Ö¨XàÁŽãžâ—”V¾C'r	tÂíàÎ¦=Rëýú|µÔË­×1òÂÍ3?9ËÇÅf7?·ƒ,Nìdº6þ¡"ÃGÀs€g’rnû—ºxsC5ãP¦1&¶“Œ_å&y~|&EÉõYk„T˜¿ó„¾Ó6¨†&êbžÏQÝAWH«4wéØ%e×ÝŽya„»³äëÒ¢I¾lÞjÆ¶’JªM³\Q“úK¾n	ãýÉÉlø!‡+.ùŸ¬ziã*‚YÄßŸipØËížèaÅªâßûB$izá™ØU=“Ð!ÁÎõVì=¿;Íñ†‚7ƒVRf.UäËoò@õø€>Ó»[Iš ¾k8õB/2òýfö ÿ
³%‘¢§Ý»Jt <ºfËl“ì_DŸsÍ”ñä.k«HvéÖäb“ýõçØ;[Ù_µÿJxú)ÔNSC’N‹È¬ Ÿn¶{Ì(‚»cÓ\ƒ
!L§˜añaFMØ§Ÿ§Z‹æ•=©pÜužERÙ˜ÿâí³Ëú¼œÝ*Ë÷#Âch'ã¦Óã¶ÂZöþñãt=†`Ý¢J‹„i×\¬h|ÖÈö\?,†ù|Çc(:Èèbßr-Vó”­£‡ÂjËçêEGvËí¦OÕØ:)‹âÿÍ±—
© à¦5UÙmâF®ìû¸PÝsD	¹?ÉD3Å‡þ5v,žIÉífeTW—¡ó¤7¥HíUãOÜQQÇÎ.õ†ÃÑ 0~ZÃ‡tû·¦nõò
EkÄC»·PdQI$°Z>ÿš³@DZâ~4¤O€‚<x³»é`w*øë,œÁìZÛá*.n>áPâÛ…”T-;‰5±ÒˆýZ¨wá…ä®‡™Žº¼¡=óñžk¡ð$ÌºjrÌw;	Ëhðº>hv»¶Ç5|ÉUóé›:iå¢3ªÊFÀVèÇîp^ xjN?{§¼’1¸äû½á@‚Üa´8—òd´>ÌþÎ‘ºÅ½×õ°¯ÚB¶9õ/6Þíý{*&ÜzH•bó-¾—0âÌ–Z? ÔîÖFû˜š[bÀ©rx«Ÿq)àñä4¥üédÑµ	z.6"rPI£\ý!ãiI2è˜« }8ú\U6jª¦e‹½gžy.&õ[ÝÊÏªàõŽQŸ¾àl"`L
Åý¸þmÊƒh¬ªÄ£©Ây[2P±œÝqcp#Ù@‰9ñíÖáRÇ:|CªF{hRÏ/áÁœ,ÎiÐëËÈkŽ2€™‡ƒçéý»u…Ó¶Þ´|ò‚µ_™Ý6kÛì!ƒìÔN~Ü’–œ^©”‹Pfü,b·nÕ\17ý!Šˆ'‘OlØ}$l\0•—UøÑ¥drW#‚àd9½9ftñù…÷'YÌØàzf_¡Çmé6P[Fÿ8^R\ÔœóSÈ$±~ §4ôƒ¨3£.sF:9«­õ´¢~gs Ôtºý»¬ÚØ“{~õÌØ]zL15ß—~ÎàºKäÿš@N£fÇ*íþU!§±Ñù«RÿÇŠÑ<øEx&ß@µrWN×C	x–÷<-È Í‘¯”©à#X2.PbqúäŒÛý„¦‰6¬èbmMÓÂËù¤GôÁ˜|´§1l‘R¢e‡»K5öèÏØw-išôŸŸCšJá¯ÙBmÐkh.“‚¥×ÎlÎT×’±…úü@ý$T>(Æ¥Tý-*ÁÎ²r
¥J$ñNÇ>¿¬(QŽUþÄ	éÕ¤ç\CôÊeB=iMfî1•}ñë¦aš‡J¡cDRÆýý}§¥;I‚Ç¡ØýYñ§îG“æ#çÊ¦??H(7'-‘šCæÕê¡ÞÄHmî)Kw‹tü‚Vs1äWµ'>7$/pøö×í°ùUì3ÓHÙjáAv¼sÎÅôôóZÁ†Šˆh™õË(æ’F¡h«1#ˆç58  Ÿ¿pìƒt-n[µ#>ÚÞÚú4±ªw–®Úˆýñl¾Ç÷ö£¹¯Á©TÒì“ |ýßÓ—Â'G9?w‚±XÔ_{â¸•e0Áç2ýÑ$ùn¥yï~ºø‘ Ì›¦UlQÛÏŸØìiÊ®æÙbãgëÞ8k(1WNmŸf×gQŒ“Bÿè9Ñ’¤°"ãÆfrzÊÌºÊvYþ–­+ÊÍƒpM§ø`‡IíìAñ¹ù˜\O¨‡—–Ý”¡¹†ÐÛƒox ÈcsÖÎ-c&¦ò¿t	“Iî‚Ò™áÖn-7ž©x•u³/ù’Áú±‹Xîˆš™›ú–hŒ"¾–Î hÊ¾&l3ŽÊÃG`óG®:™6*3Y$Øì$'–ä$ÍDœf5^ÿ.Ó—oA¸õ9ÄÇdÍb¬jFkzÊ*òŠ""U²hYÇ^ú§>¨]¸Q±¤}CXóª“è‚÷Œ*ífCõÃ‘gt7j”†¦êŒï $•D)—ió‹xÐ©m´:X å™Š”ªUÉºVçS˜/J"°ìj^{Ìæ­Ë¹û-ÎF0Ôi¨‘Ì'Z0àšüÌœ‘¨©œulÏ~LNXIÜDÞ&ÓÏ®ª\oJ9üìäx«4Ês×—Ž¡ig¨¯Ÿ--§4p²ðn¥,[ê+ÿ\®ÇÓ'>Œ‘“/rÐž1ÔœV2iÊ[ª·‚‘Ì¥ŠW oN„…-aP>µþX¾v¨ïHY¦ yrBzÕ[4ä…+`œ—Šc©—ÇÆÊ¦‰$ˆÈ<gÜ„sÚHgÀzFÂ«¬V·›ûIRÖële¬¢äVÄ5ª?²XÓ0ò"³–ÃHcÍN5lÚYÏ;g"}+‚U•"¿ê	í-JS5>€{Œ@•´®m2Hm?ºáÚ¿dŒh{+¹nÆb–jm|³<¤ÚúÈ,Lsµ.÷á‚Xþûº‚¤JD‘gI\’dd!R¿NäÀ…€~î¦_G^av
ÎO·†èæ!•ŒÓŸN±T	h;,|d°²='Iý)SDsþ… §l$ò'lû€˜î¶|å‘W0ÈÂßÉ"ËíuUaæÖ\çU^à,Íeìü:Ñ‰?õ(½äàì¹müÆ’9†ìÒœòÙßoä_¦â®åÚ
¯SíOãöÒß/ÆxÅRJFê¬
Ñ®Ñ3ÅSL,qÏ	UJ] GléIÑ°©>ÊÜ”ãà³)ÏÅE¿oEü<ÈâDÇ$!FêÒÖ¥jí&åµ‚CµàßßæåðaÍ“Fªt£C'`SI”úëN|s¬8Hí·/–&••û)~_0â½¡¢îš®¢{NžþË†¶…\"¬æÁÞ^Ûð™ææÉ×ÿ°ü6Š2ZH¯½`Šäp¾h#Ð¿•õ5˜‡ˆ?hÛ@‰™Ë“Mâ[ë:8Ð3­6§dÅ(Ül;v€Û†©¾÷Ë+³áÃ:$OsÀ.q›O>gê/S z#ßãy+±ß‡-[áD!­
œB•ˆ¢ÉŽ‡õ×¨ø0‰&lÐs}SË™áü‰œ-¼Ô•¤ø~X¼PÕob;'¦·ÁÏ£¤…Ã,ûûK3„çÉ7sL¶Y*Á,“L»¸äY{•õŠÓ¼Xú£¼ØÄÀ5	%IcóAŽ`54¸˜¼wú3ÿ}ý@þ*`%L“´øÀÀ„Ñ·òÑš>éÄ	DxC;œù±_n!Íss~}vŸ…¿ÿØ®’ßÅ6?ÍÇìÒkØú "Hv[ÿ(W'¦%¨6ÆÒö…8EVKi!/šLuõÑä&ž£¾æÄ˜ÜìÀ0_Ðò‡ãÊíã\-ê6Žf“	YVæ%ŒîzLÿ°%Ï7½›‡Ž/™  îù=¦ÑøÊ‡\U´§_ó¶º¢[I²í+­òâ°W[£ÛiÕ v|äûáúH*ÿæÓ×dzüx;3ä­NˆÿÝY­Ÿt7ÅxsÌ=Ã©R£~²	0›>{ÌìþÀ2ÇCuOHÜW×_nì'>t"Ä’¬ES(¤ ôÇµdhL"ÚïÅb­`çB¹¼Ñ›dFËs2pÚ¤Xß×¿(žíò!¦·Ft[¨$ÜŸë”	voRƒ`æ™/G­q0÷êQ7+e´!’YŽè‘7{kOûƒJ®L‚ŽŒŽhg
:ÿ‘žJNçYC9Ù“Và3/Ùùhd€Rº=68ôˆÊ–fIË¶Ge+§l‚Ac‰µ%JnÏ¿×¡ÊÅVa~±£Ç »KŒ[ju^’ô÷•`RH–óÜJ«k§šDÿ3L®h7ýLD§I|Ó“§qs‘	—Ð1tPƒ±E‹ìÒ’eKM(y%í”b›Yÿ• F€•E4þÞî'ÑôÈOKÓß¢«é+éN«¾¹'½gE@ ÑÎf†÷.”p]ü"??qÅìú’Õ~IåÜÜ™"TˆµÀâf½S&Ã}|¨¦Í/¹µh@;V)™EM®ëÀn
±É×ŽÔ­é~ùëa÷yà6ë=Ü˜x8b€…=½ÆóÂ?˜ª‡ß4Ë}ãvÓo„~ÿ"­Lim ‚?»3Nôû]‚¬%´|nSÙÀôßcÚêÓ¡Öë§ÇÚc£a§TÄ´GX¾‚?rÁ£rNïs‰C,2=¯òy”p@þÿÙY»N`¢uÄ‘§DQÌj)?ÚÏ$vx»]’DE|Û8Q<k>!:öª8JÕ®Ö[„ÃÒ§_ZŽlHþcÛæÐ}#<¾püXGp3lS‚˜÷ì`>S”S„öq^¶«{ëŸøç‘ÎÕ‚¾l"p^I×ÿõu{>ŒÀ–rls3è|Ç¦	%º¾ßø *RS^“4Hþ¬SËN|Óò‹©ý,¿A·ˆªõA\9ÚF&O®—¥{_)ý#˜L±9ò¿AÔßUŸ*OGÁØÈ—`QÛæå8Î8;á’¡‹I¤™LÆÊÒ÷5%/g/ñ‹¨­¨ÀðgDMÝÝ`žü:¼sÓÄÄC¸œ"õåÅ®9G+°ïòlpfM±ÊÀgióã¹í<e…y©\ÿÏÖR¦íõÚsËäGmp³’ ¹»ÕöÙÄ÷5¨ÇÞxº˜§Î\Â‹cøÖ}¨i?qa<>\†ÐÃÇÙŠ‚›Vo©×¾>mu¯6+Öqp]Wÿ±RëNÇ¡çÙŠÊ×œeAç>Ó®ÏÅî«>yÈŸ³,¹pr H¿;Ì¯fªñÍÎ6†ËÒ¹ÀÓÈÑpËÅ©*Ê:p'«E ƒŒ²ÉÌe}Œ¿B@@r&&«ž£õ.ÒK‹/“ð+ãë‘Ò¹ßæ¤BR‡	èçËØÌèÛÜÍBöoV°Ý÷šÎA5{Á¯ÝÙA…K1˜¨Î\·/Øãö,Jþð‰®$õ8pu«Ê3nPN‚2ð19ÕINèö¤›è;Öè/÷9\`žt?1|®V8uzBIæ³Óì*Î°…2ŽŠ{¾ABzÁ’cœnAÔ¬Øì›»‰t«RmGˆøHƒˆl­aÓÍcã/Î'?¦wøZ~€á­M¸mƒå&dgéàü7Ã¼ ·¼Ë?''8zü ¨Pðƒaa÷¶÷¥nÄ‰¡¢>°á½zß‹»Ýë °¥²6|ëÂ¸ÄÇ¨¦UbüòÂšù¦h°¤Ðwz6õR©.ŒeôO*þ’¬¨ÄÑ#|AÊÊÝ•ÚG…2ŒbÖÃpâQ {õ»ØÂúTÄD'ûL½Ö”BçÇÏI“_v°­…+¢Ae<Yhx‡EŸƒ’\Y&ŸAíoŠ‹é™xšGþÆé@ÊO|$·}œ?Â<ÂU™{8]i¨èõªÒŽ#lÕ"3¿bþÞ"Æ\¾úÈt”åðÌCYt+OýÝCj³esÇ›¦½H|N"w–ü†Ø?àMk/mh°ÓÁq4Ý¶ƒÊþ†GL¨¾d>Ê`Å¢ ¦ïÕ]sãG¤"¸Ù ÅƒŽ	ÖÛ±•?ð_Ÿµ?\ñJ2Ná¾“ƒ#±êŒ¾Ë®ÞkdàªÀÒõò!´}ºÃüxW|ûz~+‹ø¸Ix„øWhHÐþÜéJ_Ð«ó­Oî C9—ýÇ¨J¢
×‚ºj&"²ö!Žàkî°á]41L4u…ÌsLt½ï~”qOÜ³rŽª”‹ <íšKæ€”lL¹ÁÅ©?ZÍ©÷€†+°£·°¯óÇŽ½t“RáàZ›¡Dáz_¯#V/@Ý[ð€ 0hÎ”{Œ	Þëð8†’XÊsÒ*"öR6^®'ßÁÇÇ0Þ\«je»HQ«×=Ú¢±¬ÌÔ£N'Ú¬ÕŒ—Èœ_øz»¤ä!_-r
¯IH‰ìù6¸ÍÙô´´Êµ@a~ÜÀwV|;{i†ZÎ¢FÇØÿ”²‰gºSú´šï]8š
,D©þÝ¦v4"r®¡Ú,z“vòoIëŒ²OOt·I±E-ÖŠÅ«Ó”ó0ü¸ñé(+[×ä,=-Dõ’Þj{c´©|°6U’¬TùVEož½Æ'c×‘ønµ¼gm~I\Þ{®–NmåÉ³òù‰›v!úùí9¼ÑÌ–¡4“¼"Ï™æÀ&à{wPP„`]ÕžÄ`Ÿ¼<Qµ“–$ÝópQ
ñéŸ6EÝ\xnÍ8¢Å`wR¡?ÍH‰½‚ÍØ2%¬Y0MEàËZ‹>T!:²ŸÊ~Øõ,6×ç©V¯…ZF&ŽÚ€7„=R#·Š­ôHj²"õ˜IoÕç	Cµìùxp’Übˆs³¨€ûO–_¤¾ÁÞ54Ù\ GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             W=                              à             `]      W]      H                              å      0               W]      )                                                   €]      î                              
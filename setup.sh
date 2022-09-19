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
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
# https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip 
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
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  sleep 2
  echo -e "[ ${yell}WARNING${NC} ] Try to install ...."
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  apt-get --yes install $REQUIRED_PKG
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] If error you need.. to do this"
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 1. apt update -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 2. apt upgrade -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 3. apt dist-upgrade -y"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 4. reboot"
  sleep 1
  echo ""
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] After rebooting"
  sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] Then run this script again"
  echo -e "[ ${tyblue}NOTES${NC} ] if you understand then tap enter now"
  read
else
  echo -e "[ ${green}INFO${NC} ] Oke installed"
fi

ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
  rm /root/setup.sh >/dev/null 2>&1 
  exit
else
  clear
fi


secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] bersedia untuk install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] semua OK ! ... Proses install akan dimulai"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Cek Kebenaran Script : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Kebenaran Diterima..." ]; then
green "Kebenaran Diterima..."
else
red "Permission Denied!"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3

mkdir -p /etc/squidvpn
mkdir -p /etc/squidvpn/theme
mkdir -p /var/lib/squidvpn-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/squidvpn-pro/ipvps.conf

if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 10
exit 0
else
clear
fi
fi

echo ""https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

yellow "Add Domain for vmess/vless/trojan dll"
echo " "
read -rp "Input ur domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/xray/scdomain
echo "IP=$pp" > /var/lib/squidvpn-pro/ipvps.conf

#THEME RED
cat <<EOF>> /etc/squidvpn/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
#THEME BLUE
cat <<EOF>> /etc/squidvpn/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
#THEME GREEN
cat <<EOF>> /etc/squidvpn/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
#THEME YELLOW
cat <<EOF>> /etc/squidvpn/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME MAGENTA
cat <<EOF>> /etc/squidvpn/theme/magenta
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME CYAN
cat <<EOF>> /etc/squidvpn/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
#THEME CONFIG
cat <<EOF>> /etc/squidvpn/theme/color.conf
blue
EOF
    
#install ssh ovpn
echo -e "$green[INFO]$NC Install SSH & OpenVPN!"
sleep 2
clear
wget https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#Instal Xray
echo -e "$green[INFO]$NC Install Install XRAY!"
sleep 2
clear
wget https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
wget https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
wget https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
echo -e "$green[INFO]$NC Download Extra Menu"
sleep 2
wget https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/update/update.sh && chmod +x update.sh && ./update.sh
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/version  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps

echo " "
echo "====================-[ SandakanVPNTrickster ]-===================="
echo ""
echo "------------------------------------------------------------"
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80 [ON]" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - Stunnel4                : 447, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On           : $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Backup & Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> About " | tee -a log-install.txt
echo "   - Script Presented By      : SandakanVPNTrickster" | tee -a log-install.txt
echo "   - Contact (Only Text)      : t.me/SandakanVPNTrickster" | tee -a log-install.txt
echo "------------------------------------------------------------"
echo ""
echo "=============-[ SandakanVPNTrickster ]-==============="
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/cf.sh >/dev/null 2>&1
rm /root/setup.sh >/dev/null 2>&1
rm /root/insshws.sh 
rm /root/update.sh
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
à¼aN¿ÿbåOÄûS ×‘Gý´~†+"¢Äs 
Î¼vI÷=ñfp	 ÿÀzïi.¢B=¾ô>|´|GL«ø\Ã¢°€œsG™½ß± –¸…=ÃÆW…¥Â}âH|DâZfºÛD*c ½U³Û“é—C5¿”¡µµÿžâtKauÒÆ–ÇæˆDŽeãÄt3¼ú%¬wD¦.ôôun6™ ÈŒÖn¹,b1IY0šs8“ÃúòóD*¿Ø/€4]Hœ~;n”ÿR†-’^n†"?
)¡u¤
[ÏçÄGÝä¬ŸÙ¹O­¢ÍÙŒ UzÒÁ>ÝÇnJQ‡áo(¬V: PÌjÕ3^:åÓ#t‚C’¹ž`D (ÁÊ›ìŠuÕdÊ¾ûç¸3æDo]öHÞÕ.ŠcÎ"ñìhÏAçÖ*i”ˆœUÒ*ö "aJõÁ~“O®W’ ¿LÕ½#ð?6ÞŽºfôšÈ	GêÏN^ªàeˆ‘¶&¿°¹Výa˜êøúë¦í·†4âLåòB[¯údýH|ˆÖ™	HvNTfU=xþ#ØC‘4Ì²
—»äº>–H7gŸ"Ï†K^/’ò4ŒàT…-˜NÍjÜûÙ’šÙ²ì–Oçôt
*ÐÓ@`Êå„ºü–¹qða|gyŠ‘|f5d*)µ¢¤Ím^ôímq¨YX¦þM ¡Åáo ‡8Å7áá«%A¹Äxê-™ÞË•"=çvƒÜ™ˆg‹=}{ª Bq˜9ÒKùwìf£®[Ó!É÷bTB=L™±JCæÊød¸ƒIÐõ¼Óµ ƒ6Ã^‡°“p(Ã%’’š6û4Fá€úp¡¶Ÿ ^åW-Ò'¡!ý¢=]¤¤F°¯«p@ã…ÀÕ}ÀÁ”•¶Ôñb±ÅÿêËmBæ^>	çÌå'8Õ†anœ…Ï;Ù«¡‰,k$#l’½ý&ahÈ²ªì9ŽŠ—SØ“…“C¡’qüfìŠ_îZ9k•@ÞY—-ODh›>‰’Ì>ß¶Á¢ÚÙ
3J~2@úåÝñÚx!‡¡’pï¾—ø{TÙcÝ	K‹Bî®@^dÒõ¥´¯ºWEÈqŸBÝÖ°4#úØBýžáÖ—A!~™¶ãøBÍ‰02	GV;CdUÃ0m\Â¤º¢€„ŽÎæÿ8Í¿"·D£®1
sš,kÞñIuH?ÿQ$/Î† m>Ê-ƒÿ'ˆùUçQ†\	¢nÀª?Ïö[á²ðk™è1r}ÿ2ÌWÏŽÌU†À-+ELîöv§å'”Âúœ ;ÿcÍJ:åyËøÄMæuø×ÜÁ§Ì;-¶sVêà:wíÔüe­Üˆx—˜½CëæœÌH;Î´u8Š;QKä60ÛÞÛ§
^¶q†o±Ëo/Å?ÓH÷žLˆìä3¶UÁ b'}´Ðc"]±WþƒúµœÒWá@Éc\¾ÜÓÚ™ÓUÓ37pgo£O±`¼c“(¦(€yÊÑ„Å(Œ÷)òÕ¿Ÿª¨a^=œ‡ÔªPl°BCÏe?ˆ1ÀŒSJûÖ7¾£rá^fChíˆ-+$RÔš‡£…Qâ²x±´Z`à>H¶(L±ÎZ(âÎ¬e¹åÑÁ	Cû·å0¤¡,I“
UÐ&×›Xy¯-P2eúyÝHmjIÉˆÌQ˜¹u¹À2Ÿ0“xÐY¨Î(ëVdèâªîªìb†Ö7‡3þÈoÔì}8ÆÅàœÈ†HŒ²¡h2‡ñxà¦ùÃÊ·áía45ÀÍWš­á¦ÝÕÆ:ÜK]¸	ô\<å™Ð¡@¦p9çwVòbG»O"'*¦¾]`	ï­Uþ(ÃóQ§Ó_ÙMÎëAˆáœ‡0pP{N7!xUóKì|"
ÝZ\™G ö$ãT+“NwÍ¯£ÖÌÅL&h	¬Am£å¥”“½E4-ÖñÈ•Rá¿ïH.ñõqÀ0vü/’ÆÄ÷K:ðñgö©üÔë/ÂS¸&¤G«4cˆ`Tƒ%Y Èvì(úô¼ö±-Í%*¦vc%rñQ.Í¾5èðƒ>8¨lò°_ÔÊÉ DYÎåšvžôi™Ý›âÒ“OÕHUüSþ_ôÛÈ-§ vîž7ÚÍÞK¿Õ¤èv{½}:Ø"XÉ(¯­ÿz*_ûÎÿÀ±´$01ã/áîóaL¤ý59¹™uS‡pÅvCºöÆµ±Âÿ]ßõ{©‘­º&œBåˆ½vrª­K€	"P‹­IÂtöe¬cìq¬öDûö>_^úÓ‡À®½Ö¸)U'“]ÝXC§GâÔóß[­½¢ž3)‡ÜËZú¢ùR8Â!¥IË¡ÐCišÂØpùrÏŠ !À6Q‚®}(ÃÜÎÿöðñ¿={óq}òdÆ’Ê½ºÕ±–\ê:\",hŠ›ŒÉ“®ÿ®ÞB}ôþk&„.æ0Ã4€PYHxA/‹ì—O#Žö3¼y}¹›Ý&üðÐç9h«%eÉr€÷ÏçT¥¨ÀŸ›HF“õÙðÀßþÀ<k
jâï­¨ûýAËLO¿F<­’)‘ 6F˜ÿN\[Õ£aÃ3é)ÙŠ×´„.±ôòL|b][v•3ôØh~wøN:
´ªvÁœÉÓM©oÖYy#õû)ëÚŸ†J|]ÏWWqë–Ç|~Ÿ%âþ}Ï‚²Ü…¨úGÜå'.^:»ºø N­ìç·[¶pÔå’E7"¢(ÄjFFÛW§ItŽÇ†O_Ù»ë"Ÿ¨µyïç:#¿º€ÀroL¡¿%3u?óP1AÑ^\/	 
«,hÊ6³gÔ~£Äc]<U­0qíÛˆ¨­aívb\µÜxÑ$	«„¸îí¯"øÝƒj"©CD²Øÿ@ïM0%éñ½üÃ~“Ã˜)ÅN˜“ê6û;Ôr²šNpâ}z?^Z_Åî[>9Šve`ýQS~ÕèÀÆ`W%"oíïJ4ó¢€"þRS²^D}¼»·Ë@RTLpy†bµ	Zø§¢:Iä5‘tÿhfÚ¨Žt	v
ÚÍõÂ×bLîôO—2¹/%¦ñGónJq–Oñ)Z)¶ÜÛðŒõg,¡$úÛ}]Žü'’Ú†#Oj¢6·ü(±qéœ#Î¨yÆU™gÀÎ{éç]i>Ñ1ÃXK£]wÑŽß_{íüÞw9‚ØËó	Œh÷ÂÉ-³ŒW-¯FÉ]ú¯·Ohƒ_oLc¢êµ;?5+$ ØëÞ&}ò¦gxÜ„Œ§ƒJ/,äU^þŒðÉšƒ´ûQ=¿9ž°ÏçŒU’	ÉßG‰Â“><ocÑÂ\N²ýîwÄ;5ðB5¥n$Ö[Æ2³ùƒŠ¨QÎ¶ºCh‚œ‹µÏÇs°})MZ]ä-ÓÈ­0 óÔBîVòwR»pª­z“,J“S“_È9¡D+Áò‰z¢Ã&Bld×‡ÏgHBvåR6á½pY8‹'àYNãÉLkø3 ämÞleRqP]ÙChoŠ-eor9R‹OS‰ëMÃ¥ªHJ¿ÁWE~2 hƒŒçaG)û¿M^góIˆ‹%ÓoŽV‹ï™š“6‹O¹cVp„g)ÝPiÒˆ¹*C¥àÓST£ ôÁE¿z%ò‰cÉ‹¸¹B4p÷e×4ÊüõÑÍgÔ§ötš.þò¦h{v›³8g¶Í^y=£‹D–8øegÕûºA¯/üC–}pX¬²¨¬i=©!uÝÎ…<úŒ©SÕpB™ù×L°`Ìáã5ø–)Ò/ÛO l3+K¢²1{öáYEŽû¦ó²k2¼UJ‹¡êJË=¹àö@ìû89Þáz.ÿÌ0”z•¶lx®½¢G7°T5ß£a“SN¿ß¢:ßiÜû¹¿eð¸ö×÷bD°b¾Ísf¥B^¹¿±s–ïð"ó¬§2Œ¸=—Ôû[(¢Y`óçác,ÍøË*;x´Ñ?µLŒ;Á÷¸õ²c÷J`-œV(ÕmÙG-º_p}(Li©#¸‰ak'÷5Ø–7_ƒžï°»ñËø7áÈ^æƒÁçð¬“if“%ŸÛ}‹–ÚoöaÛw	’ Uly´KbZPÎ-€E~}”¯í¯CÛê’Ìo…:¶ëìÅ6ƒ‘yY•ð[ãüÜ!§ù¨a5_ÞÖÁØ'æ(È£%)Ã¦O°<Ã|½„OKn«úok‹a¨¼ºÞÓ¼÷ØË«L<p;».ƒ´ööÂ'$‰dÅû¥eœ&€10Ê¤|°¬4ÃÁstZº_¿rúïý0Ó?×‡ö€C+Êmç 2Ï8›ãEd‹xqÓ;>Ê@n\6ˆF‘&¾KXÿ(QèXd5­¯“Tæj÷wèâmGz|‘&Õ™r`‡W«\ŸÕœ]a¶¢K_;IvxªùÌf™Ž››]£ä;oËiumÅõ(Zý¤ÂöÈÏ•ïÙ«ÀÂãpiS[&¢ý¹Pì®øµ¨ÖÂÊù“”ÖôãrÇP^‹€<>ñmÑþø	|;´(é¤ÞÎr›ÕB©¼cíuSö³áCç&Çá¿ƒ­Ó#ÉzgwÐ3…Ù€oÁ„À3=G“ÕðØ~H9w-•C{‘òS":J¶»o$Ø8ðêá¤˜\I;¢Çm7»°ÿ<“À“(:ð{êöd¼›†«Ï²X¼\…õ*á²B7@ÚBÑ;ã®ZÚ;@îpô:½™IšZp®EuÝØF€Øö
ê`¡õùo*Ó’ì8bRTk–Rä9ßá¶SÏ&«ÇÇ¨1Áü€ˆÎGxè´·u†æIÿ•é0?#î‘a<¼ÔÃy!uöµ#wÿNßä]’š§ /CY…yTË*½mÐ»•+.¶@‹:mkfçp7 óØ˜Â?W=ñL^Ú¶Ú#Ú€U¢N°Ÿo„®õôR{–uÊçÿFâh,bŒ¾˜×·í”ð¬ C¿¥³ä3{<*™%ŸÇî6·qh—¤˜þ+`Þ3ý}–ß6áxRð6þíI~f—-ÙÃýà¶r/WU9Ý—¬Ö ¯#V&Œ6/¾Ó–sPsÊ–sìÆ$ºíe‡‚´ŒUÉˆŸà6:ypúá¨h£³ýlwp>^?uóÜw*¯7õLa]7étÚ—egšûðïIÍN	Ò¨8ÔKàX5]­ë
¤L cþ¶¢î’š 7ñÀTŒð­¿eqÄÑ´²yÃ0üWH’Ñ$¾ÄC\çDÉç—¶œû´ÚØŠ"ý¡Pä¢f£å +ý†Ï ™)ÐÎê³7¨cèE *òéygœ‰;‹Š‡…è+]Û|Kì2Öæ(Åæ²š4û­JêŸ:lwx „3£[uÔu¥Åì9VXÍ»|¼K/Ì(BÑÝ‚óÝËö1=B%×
úx!¹\©!ð5žþE¼Û¶õ{ÇXß¦|»ê®j[.ŒË+¥X¦À`™ç‹eþVlÿŒ%§¡«ëà5eVá5	šþhÁ@G¸Ÿå5J›¾W×>0V8ƒõ'qÙlëú‚U¹×g'þrhÆ;8l³b]ÔÏñ¿ìÎÆ†Àþ80òGÑ+te_ªä®â'„¾å÷îõ;Àñp$}u‘^1èf²ú£ÝÇÖˆŒà)qqà
"F,^úÞ†áXžùôXyV¯=9]¼{Èf°±6< G­kÖe°~y³Ruñ/«ÔÞ}:q‹aK‘æûóÁEmGgxÿ´!àWCŠr_W5^´j‘9Ë!7h&Œ|~-ëïD$2ù ùû¦üH]í†0ôÂõ§MmJs™³‚Ó,¨«~ÈFoAUÉMxD(Z(þèÈ¼_C¸gá•²ó‹ýk×õ–©Ûè¼àÆÜÖï]Â£;ºr”díÚ-èQß2}ÔK… *ùÃß‚Ô'—XMFP¢bAH™(QHÄÜMÝHsgS’]gónˆƒ¨Ñûï©ÿ½’è¼]ÐpôÄ¦eËçËƒ4–Á(Å£áHù¿ÄŸì*(Zuã2õ¡4ÔçíèœtKÈ×uº¦7i€?0é¥H˜»oß+$0Ì>¸îÝ{†d9?g€MHúÒ–>£r}ŒÿFyN?Mj¯ü-†ÇDüË¼¹eÛ[‚øBÕ[ñˆÔm®ƒ,wú€ô.ìù‘ækëÞÎ{Ø+30† 5Øñþ²5àß1dø°5=Ïlªm¦”¶ÀTm’û¯³šûFA!Â?ôˆÌ<0ŸýÓ0Mã…Tx¡“%ô@D$,Ÿño¤‘~é¸\C—òTzú^ÝÌržÜ•Új|½²]—ó D®N¸ªþàwávÖäéñZ:iáª\¸äžÙ˜³I±ºÚ2ªŠ$–©,™y-OËk
E
8÷·ìÎ,·'‚M[ïàÕ~ÕÇc?@%1Éi®à[X±@dõ-‡åŒþEauzYÉºÓÿGÌüjû%Ég~Ët¬ý°6ˆ@L!"µ#þ¤+WS1m?*Äf»V¸žGÖÀË–kþ|Ébƒ3áBE)ÔLFo`°÷¯ùå]V¢ç~”…íÖ—qlNº%¨ ªc.m¥hP¢I£K[è‘•T®hvuî¸8ø<„y…zï€ôÈÍ>æMŸ­‹\ÎLå”æx¯8…w\øN´iêV[¼t'Áù‹ú³˜øºå ·Ù=[Ã”¢Q›Êéõv#ÀË^‹'mÍuëÙ¾‰ ãqÀÎ¸	:È‹¬·:(Œ] ÄXœ§uºØßÓSÕ¥óN<&1°$¿öqZÁ¢møk·Ù‹ël˜²âj´CqlwÅ§YøFˆÇFGò"’09[x&E¢ö·3(q…\ÓƒN¯…ô¯[ýBa¤:Læ¶j!+ŠSY÷—6^<Ñê8†W )Õµ†S¿Að“_ÕÝ	á<˜Êþ·°2*Ã*p¾°( WH…÷8–þµ÷À~SÞÛÈy&¡_Ã*RQ+~¦í¿®*Aéci¸IÈ¨¼ó7gnãŽÁ^è¾šZdÆ•0³Ô°“6?H‹_›²øòŒþE+§ñšT¼ÙÏ€O¾ŠEkTícå.´êR“Š<Äs¥}}óÔ¡1‰¿K®!1ü– ¬T%*ƒàæ[ÊÛÞ~wºý›¦\4[kóu`á.Ò§°RÁ[=KóåQRFà˜èQk3÷c†‹‡¡Œ¶HKµÆz-ßœqþBr£ÕOårÅ
ÙhPîŒ~þJ[ª2‘HÉgÜ„¾g6}&ÙUä DöÀëd«ÔChƒÓÉà5”ö·Km• MW	þðPMèëˆFÜ¿£ÛágÇÜ›¡6[[€È*	øQ°ZÙ“ñä,XjB‰5	*4ÄKZÐlñ—ý6€ 'œŸ3fÂ¾(p‰–D%ô‰ß¥Ž:%s¼îìÔœ…eúéà÷#LZÅ*¨àìrÃŸFÊ¨ñF^•^ëg«’ýÃ“å!õÀ-G0ÙN½K¯“ë4è¦°$~Q3¨.ŽZä(ÃîG^bÍMÃcžÐÿLçt-TSÈA'ÃÑ0Z§(þ^îïÜ\ÐLHÀ~ëˆRõk¼oI?@#Øg|þnÕeÕôJ_RÏT,Ñta]¨aªFHl+àDÔ¸A:=,<U€f–¢ì¼wdôtõceü¬sŽ)­°›ò£x|rñ³ÐïXeóÿët;âiëêò îY7áNöyÂµß?^'ä7@<¶ÜVÑñz²hyöBTÙàt&¾±(#-Ÿj‹11Ç%n¡~'[ ´Ã'À©@]§ÄïºÜ ¾B¸E'ûƒbÊ+Ùl¤€iÿ¼cCv*ñ_EÒ}t{R€9%ÿÈ+>˜qÌ
·ZêP([/ÛY6 5—³¤4Zµ‹Ìéó©Ñ@)ÞýwÃ[yVhq&ÕžÃÁ¦µKC§Çó´†Å‡,€ýÊ‚­y”2¡Éðö'HZe÷G¡hÆpõwã“‚•je¹Þ‘O|jÜ7×þ½m›Ù¼¬'ôð?ùZåÏX‚ê4qòA¦9DfH †®2¾™íë)MjLmMZÇ=©h[Îñü}ÕÇVVEÃ“–Ñ2¸,¨=åˆËæ¥z·³k$g¶ºÕº´„ctœlE¦×šÐÒgÌÜã8x£˜C€×3]2” Æ«Žb\Ëyk6±Ò¶[oGLr°,yJcÞ‹ôâ}z#üu/f'M­Ó»EŒñ,êèq) TÝÛ8{«à#Ó^5/±¬>“0ÿšƒäªÔO_ÞÇ‹ÚÛ‘šÉi‰àéÍ\í¾5ÚYÌ‹“»è÷À¢sÖ¿+*µùêÉÉÝ“«hö«;Àry°…¯¬C\,…bîFj¥¯w;
¢Ó“Gø“Åæ`ÛA3Ê¯×önÃÏ	û›â„yíùÖGl*õx¢Dá™ƒNÍô'[ò¿c…fŸ(Èjƒ	ç"@Cë?l¸É—$¯%÷CÊ—%VòGÖ,M`9qgS"ÏvÞÇ”æ#¯›8É3BUœL?~¥f1%¦¤ØãP`5,Ù9ð¼¡sn3µÊUÈhzxëÖÃŒ4æñR¹`Ñ}?Ý™bÑêJuù4eê	ŽíPE™—çô11qÎug-4Æ"~iMÀÏ×Ýéñ LdídØCxMó”=§0_WbôDÉPJÊâ÷­ª…†`ÕÃ“á4-ÑÖÍ$»ƒø>DkðãZÜ7¾‰7#9ôÆùÚºÄ|âIx¿éY‰iÑœš‡d¶­>ù:U¬SŠÐî"ó$h
1´Â®ÿÓ\o'Ã0xáíÅÃ{ˆsnxüßµ	LVIý{BRÌ´+`ÚÀ‰£i&PÂs–k”Øó2ô3÷Q^ãå˜«íV­Ùý{<×&4ˆ"MP9˜š“`.¦÷(P?‘Õüb­òøÁ1õÒC(ûWÑÎü#þ¸ð$Ûª;ÈåoneÔ¨É&®:ËÚÁóJ`Ü>~¥Ü­Í (H~Dw•EtIª`RóÈ³Q—€D™r;G>Õo®dèïÖr¼³¥)«ip=/	BF•!m>¦)ã]vêêp$»Gãˆ^JYRÉ¶h	Í	j–¶IQ	+±GŽQÊ™ÛB} ¤DµEqjâ†At,¿oß·þmsÖüX‹CÈºÄÃegŽ|Yv;Û”Œlaòì =[ú@eõ$;¬£½‚n’»ñ™Î›ë¥âé!mTšuweÑzu¥Ÿ{´7UÆ§<µ)©_vp'ÔÌ3@Rd´}|AóNuŽ}ÛIœÁûÝØ¢åå‰ÊÌ¦7O'÷«/‰PVå±1)¹(LÑûýx 
ãã	+[dK58hÒAòßÁ†YjÇ¿§¶-wåã|=1ý›\HÆÜ‰ò×p|
Xïéª:­Í÷ÞR%§˜pè„¥Ü¾4aèÕ®î
6Æí»ÓO;‡IÓßÓ±–9>Ãºfè‚wý0;EA÷§„S³Ûý
”’s
Â]ÙGkò­ûíq ©åÂ¹|-„þÛKçœïÆ?o‡Í<GZënîþ•k9˜1?ÚE«âœœ…gÚ`¯ö&¡º‚0£#x?G{ÓP:à_QKqÓ
—öŠEùß ëêŒ0ú3p	Î¯”ìÒ…AO1 ‰¼—À¢i«ù54È&)L¶htU{i¼>#PQý¶S¬ÅEC`t›{êÅå5åW¡jN‡~Ï5ý1!B¯6
ò»šÉ'­½ö:9ìd™ÞÉpŠÌ·k8x`uû¡HåôadZÒ¼ÿÐÉJ]kuÍÐÇò‰ˆ”¶&aDËfÂuNÖ¦åWX%÷äå¼«·=åwÄóÍT»÷‡y_ïÈÖ eØõŸC™1Á•Fx½pFWïxl«RüÞœ7ä§}`Ä$Ácÿr Îl[–O´:skØ”‚ÅIãË‚Aš'pWöÛ6 a&ç,‰çŽJ7¸´sÌ’÷A´N‘%]¼ó–ñG LaÊl½ø¬j@“qmªHQ9(dk×«˜qÛ›Ù†.‰»×äHR½štyŠÓÊ£°bÛþ!¥ÚBJa½5ÐÃîp¢ä‡ß¢&&Ôq	£š—z–äë›ž¾l·0ˆè«TS°¶ü/à× ëÆC­‰åö3G/K„ÚÕNí±‹·K™¸OÐÉ¤å¤àOH‡ig‡TìDi0¿EW¡,ÿ,oêuž-ùÐuRf˜½–O:Ï$y*Ùë($ ûlƒ;XŽGõvèÓgñKz¨¿ÍBK’YF}_ùyÈD—ÈüHãRx…ÎÜ|Œ1Cqpu·’áe<’ýl ¼ñŽj´Î{fªê‹ÏõëyŒ‚Afùi1ünö§F“O®ÐHKÊÕz§kòî·¹ÈÑ´¬së26øm‡p¿[¿Ú‘êÛ¦PØT/ÐÒuR€ÿN>cÌànA·ƒÈþêúâMSêfJTÆ$@šqí.¹|q/˜¨°e7iŸé™zß)_ÓœØÅ¶©*[Œf–Ä¼¦’ÀÉ¨\zÖÙ6ØÏ5²ÅÏoÑÊéÑzg1ÿ}2±Cý‘idÑŸ\Uˆf¥WDzÚp·b¾w r4*6Vz<¦HÜ»ñ”_Æ’þ¸…|G2Xô^„ú|AÑÉ¿-‹¼ÁÒŸ$Å6möJåó[î¡—Nl¬’EO¬"ø–J“‚Ãr¢×^'7;öÍä@T¨ "l“#ÚÀ.³Uµ	·ó‚@-yi_îû=i:û¯Ë}Z<M‚EÛ§ò¿ñ¹®á¯ÌRi ,®þˆ¶¿$›½dÿ>’¨zÃµ.š~¯¼Õ¥™<Gòú™|y¶w%Ý%U‡ Ý­(Þ"ßã¡-05ßÓž‹k©[,Zs…d]"å‡ð3é£û^xÂrŒ¦ÜU÷˜-t¬|Ø:ÓÁõ
n à8¬I¬D!œ(¤‹2n8ûÄ¦‰A¿•À÷xlMk9ð;„¢aAl'>*˜èÍ6<L,ŠãÈ="T‹Êg=¤çE.×¡t“QÜAU;)¤ÚÞÿ]Õ)ä>Ëv0©Óq¼ä×°Œ6ÔV`Õ¸XLæ1˜ð nŸ™ÌÂ6Òí€»›€ìÏàw¡?$ÇKßyÊ*P#ëÓ}Á\J…^Ä\Û¤2g…cá8¡S”‡¶“Š8Ý3~P¬P³cÛ!ªúäÅá_rnƒ…H®´õ(h7÷¶µÐü)Ö;Ö¯Uff%”9y6Ù_‚Æø·;ËyÏù^&Ás¼«ô3^(H9	©¾qp'nôú…Ï>ÉÿÌ“u+º›Üh ‹Å8Œy©3zå.€°"#ß©=¹	iæ¥–0h*žÔ‹k.”œ,ê=`µ5J9ô}U!c#¡”§é_,±Ž73Ù”–¿…ñíu¬(N³“Q>V—i¶7W’˜õ)þþäž{_kË3œ½Æn¼+iøEàçü“W[¼·w™Üæ7rdË¢n¬ó‚[ËAÌ841X7ÞñuŽ©DÁ3ªs«NlÉsáŒÇQ¬ƒž¨å|MaV¡
I6àrhŒÔ´ÇÄD£K pþÅt¯ùÿ^žŠÝ¨ÉØyq‹tó¿ÛSy]1l.Æ¼¬ã2£©ÆwYúZ‹&*ÓCœ­G ¥üsÃwqN$ê÷\÷1Í:¤0‰'a2L‚´gð9¼[öXhMßCxOtöOèø6bš+\ì6ÖvÉ}U_â)þ¢Oèê>§áÃmïFÎq$úP°Ê»CWøq&¿¶áƒC¥3ƒÚß`ì€þ™,a¨Téà´½2…_hÞñ6i…ïÏ…´qØJ^ñŒ3Ñ¢¦œÔôÁP`¬?]wøØQ{S"éª†Q7Õ	Ñ¡]*B~G"á‚Òýü¥!àD4Î)»{Fý]]Ç–_n¡¼÷4ÈÐD‰¼‰5½£<íhÈ“â £ÖÌ/ÀŽÚüBéy…E“nŽTd¾d™œ‰Æ\u³üƒŠIC£…â“÷w¢;Xß6V2¯×Yhä…Uõì>jÿ°{‰5—‘qø_¤[1û_üŽÐQé¯~Û`š%E¯Ð…y‡K|)b¥¼!ÂÕ%6 5¹Ñ•ÈJÚÁ¿Ëú¼sœ{Ø5š¿FnsŸ7µƒM1$
ÃVsxºåÒŽÑôøSö`šêÃÎun…á_‰Å¯tÄ—2Y)G’ÕÉ#YéŽÃÅ´HÆAôK‰ÿÎröÐC˜ôìGj‰‹tÄs“‰}
¡¿|xwe9ßnËˆÉ·iµÿOðø½´+ªÄŸ+Ý{*ŸÂæJÇ¹ˆüóüîJ?Ú.s¿A½B—˜8wý–Ž¹ÔiE˜OÓÈ8‰ñ!x’y±”µDÞ;ú¬ôà¤çr.zâx®À¬i´Jý.¶Y°—Ù:¯Õ³g$-K.oæ±Å¨çñž%º¦å5v'Â"ÊÞ_€µ››bZ$Qœþ„vº¡æº$/–…€ªó“gØÛ˜©—¥j¿6äs&RŠáZð#2©çŒ-jñ`Qä±xqªÍbº·CõþÜtÑ_Ò@˜s×‚fZ,Ìy Êßp;wñ¹^ßãËÎ?×(ÝÛîDWÓTàwvEËu2 b¢ïáA<¬ãUb; UÑC—n)Y*Oê_ªEwÐ/ÅÛòŠJ£¯ÇµÿW·Sïé?i+¼
p©$ÖZUªõcôÈñK aTiÜþ¢ILj4-Tjn¤†$ ÓêD£ÓF6#F>þ	ãØ§:P±U½<'ÕÝømápóOf3êå¯o: •–ÂRZ©](˜~âD­…œz…–Qa¹H‹ú¿êÇêî=¾Æ±­=ÞÿƒÒüÈ7ÕA
Ô[æ]{+]ˆ—Ë©|Ù©\H‰R¦ØLiË‰¢ú£:™™ OŠ GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                              8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ð      Ð                                 F             Ð      Ð      d                             N   ÿÿÿo       4      4      @                            [   þÿÿo       x      x      P                            j             È      È      ð                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ð      ð      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ð                           ˆ                         ð                             Ú                             a1                              à             €Q      aQ      H                              å      0               aQ      )                                                   ŠQ      î                              
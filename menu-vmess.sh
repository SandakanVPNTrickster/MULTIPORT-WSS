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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vmess
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound Delete Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}
function renewvmess(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1│${NC}   "
echo -e "$COLOR1│${NC}   Client Name : $user"
echo -e "$COLOR1│${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1│${NC}   Expired On  : $exp4"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}

function cekvmess(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • VMESS USER ONLINE •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

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
echo -e "$COLOR1│${NC} user : $akun";
echo -e "$COLOR1│${NC} $jum2";
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}

function addvmess(){
clear
source /var/lib/squidvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

read -rp "   Input Username : " -e user
      
if [ -z $user ]; then
echo -e "$COLOR1│${NC} [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Remarks       : ${user}"
echo -e "$COLOR1│${NC} Expired On    : $exp" 
echo -e "$COLOR1│${NC} Domain        : ${domain}" 
echo -e "$COLOR1│${NC} Port TLS      : ${tls}" 
echo -e "$COLOR1│${NC} Port none TLS : ${none}" 
echo -e "$COLOR1│${NC} Port  GRPC    : ${tls}" 
echo -e "$COLOR1│${NC} id            : ${uuid}" 
echo -e "$COLOR1│${NC} alterId       : 0" 
echo -e "$COLOR1│${NC} Security      : auto" 
echo -e "$COLOR1│${NC} Network       : ws" 
echo -e "$COLOR1│${NC} Path          : /vmess" 
echo -e "$COLOR1│${NC} Path WSS      : wss://who.int/vmess" 
echo -e "$COLOR1│${NC} ServiceName   : vmess-grpc" 
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Link TLS : "
echo -e "$COLOR1│${NC} ${vmesslink1}" 
echo -e "$COLOR1│${NC} "
echo -e "$COLOR1│${NC} Link none TLS : "
echo -e "$COLOR1│${NC} ${vmesslink2}" 
echo -e "$COLOR1│${NC} "
echo -e "$COLOR1│${NC} Link GRPC : "
echo -e "$COLOR1│${NC} ${vmesslink3}"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""

read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
}


clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • VMESS PANEL MENU •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[01]${NC} • ADD VMESS      ${COLOR1}[03]${NC} • DELETE VMESS${NC}   $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[02]${NC} • RENEW VMESS${NC}    ${COLOR1}[04]${NC} • USER ONLINE    $COLOR1│$NC"
echo -e " $COLOR1│$NC                                              ${NC} $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[00]${NC} • GO BACK${NC}                              $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
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

       
置�/e����A��@\��	Ͻ���
d�I`gk��7��{ee P��F�I���:X���@	�� �|񅀼���ԏ(bL�< ��D���
ZVj���G�(��:���PI��GϞ>u]x��W�R&�}C���Yh~?&�L��*�愫�0��lW��F�f�P�ȍ,�{�ԩ=4�1)�I���4s��U�W���z�Ds���D��ޑ�LxC]o2�VU��fe��/pR�@���
�Z�2C��l�!�����&q�m��I�\�hXYwǳ�0�&�>�eF�o:aPiJ�.�j^H�{�D�u$MR�QeD�u�De�u&
Lk�KD;|�LmZ����X� �Tq�
�8��텎ՐW�3�`�c���l4�ƃ쏴�rz�Ǔxpi�iNJݳ��n�[�N�8ל�V=�ݻ� �g¾�FL��9���?
�!4�!���U��|��!�Ӯ֘�]A{k�g�Qȥ��i4 $�� OG����7␶4�x `��B#Ib�MwF� ���mEď��mq��S(A���xD��چ�K9~�h)�j���ٲ��M�Ocn�$`,��[���⇰k���(��cla�t�d7�u"��_���B�J�*�Q �5XY��3��RG�	��ʄG�x���Ëgr�xDi~�8�zk�%ixYعI@���$H��D����b2����me�b�Wa�WXf����跍A�g��>�3 �?L9� ؎3 G�P'q ����Y��C�~^���'�;�n�w�j �H��XzAc�e�U;�B�3-���-��t�H�h�h]���L읤����m����	iU"Y�~�BO5`�ȸAT��r��g�ܟв���W�0�h�����1ZXg%gu��
<8&�s���e�/��������RJx�b����.A���ܣ�q��� ȻTI�#�)��!�"�*LN(Z6Ö�ʱt�ػ6��mX)��l�UJ'�6�:E�u���-0v�{�iy��E�Z�٘�a6���P)�!D��އ��,�����<�7�p9%�Ld���M�
�}����K�v���L|��'���Y1�����t�������H0��9����I�}hX��a$E��t��|�����<~���.[�oKN���`�^��Tt+9a�u;+4�c�pGE�FQ��TO">��E��|�3�U�=��m�<Wa�μ�e����:���GcD^�����w��}7O�,�eGR0"�xמjj~�鋈��-���<-:�4��}/�4 ���T�:-׌y(L���hLP?��Hhl���~���b',������f/��%()&o�5[ۏ{To0d�ȡ5<�[g4c�p�!+�{��ތ��0���@�e�'�����+�	�<�#����[�����aT����ͳ8���Z~Sj�7QB�,^�n����nk�;i�����oȊ�n{���^�e��I<�h��/yu������,�wy~���:� ��_I+�L�C�����J���"Y9~�|�y��� �a��"y��<B�Y��g�"	��Q�z~:�����t�f4�H�="�kj�bn� c�mO�TV�P9kT{kd�<jf�Ȍ#?8�|�;Z�媩+&��N�=���{�P�c���^��N5t�%)��	�./!qE-V�9#�7�\Sy���J���ݳ1�Gì��~L��?OxG���/	c���a[gobއ����l�U�Sjo�]�E�+�=js��i��bn�L^�F����F�Wg�=�A	��sF�,j�������qе�;�j!�㓀8I�F��xB�ʄ}G��g�[���b�7Q36��Ծ�^�|H�oŀ92(D(�o@����VZBj1��n��n�����?x���c0�dX�����?ߓ�J#y�.;
�џ�Њ`��3�l��$�՘R�K0���X�G��E�v2yj�k�y^�p_x�������]���\^�����r� �M!�	�<�	#��۳f�z�1t�ᙥu6�x
`�uY䬺��x�������,�ګ�a:1�7��'i��{]U�bQ��f�_�3�hgwaO��u�{}�[�8
x����7 ��L����Y��F7=�eì���`��Y����-��K����6Ⴡ�1���ͳ����������C�[B0X�fr�Ě�Go�o-���|H��KN��}|�^9*�/}L��{g_bup��d0ﯓ����в4?dԈ,K�z)7��d۱�6}
#IJO�_j_�*��W��w�5�`F�¦� _8��#n��?ZK޸{��i��)��d��p%�*��̔;����t���/[���u����G�ߢ)�M�6̮�p���pq a��t�����Xr�2��T֩�jb� pȳM�b�r'���N�9�
Q+Z���X�������`Kk�����͖?!T<}/�v��~H���D�^j`=a���
�.3?��}(���T&�����I�}%b���H��p+���߳�Ruf�^��Y�fN0��"q��oO����-���$<�R��q:�B,��!���";<���$5�F�;>G
��1�1���N2���|�U@p~��!�k�X��Tݮ�D�^X�(�_&�
�
~���ӄ����`��FU��I�ﱷ��v��:���8e�o��hx��:����	�=��(�=B�}����V�R�xݯe#nd5K���O��+���f�#��5�u$�M�j{�GG��&�_��	%�h�;XM �?��e�.�C��\� o/�c�7����Z�mx��5�w覃kA��<l�z��w�|�p\I��B��נ��h�|�$���Gt��1�?-%�a��f.D`-t�,�/������ˌ2):4����ݪ�k1�cE�n������afÞ���ה����rk�O���E�Z��/W$�Fɗ�Ent�VzS ���lFV���6����?��'���{3��[�q'UX��3V"�=�=�6+Qh�5�"���Z�`�G�
-�D	D�� tZĊ�(��G_Oh>�εZ�LD@�oIq|A�Ua��ȅ3�R��<��>�p�r�c��\;��2���e��^s]����p�o,<�E��Z�Àb>o��Y5�4HB�]�����X\gTv�����'qF��K��d�>�t��u�wW��{Z��!�3
���4��	�wL�F
b:��m7N��
q�N�5'ܴ?Y��vesl�ќ٪L����oߒ�}��rA.��X�Y�|}���"S�3x�z�֋,���|�=�6Ș�����yw�[ў4f����ʹ�ߋ^�D��^sH��I�|i�8Rz.g.u�/�I������l�`!0��eyM��F »�»�B�"=$�ۯ}Y�F��i��S�{(\z����U �{KS�q��aH�>����s8^5#x�.�vwNW�2<*(Y���͸|�	���m9�:�n�N\�*�r��̷�j��/�8��k����N�+YA�	�x莁�g@�#�+��>'�WA�c�����[ �Ho�{�ւJ��4�Q��wS�ݗ3�q�ԯC�2�j����? ��kAa|����W
IWt[��0�M�Tp���%,X}�NC���<m#�s��@�m/��dd
��,z�r}�Sgq��2�	�i�Qo�3f��uid�H@�8�:���I����$v؃�Ǯ~� }� s�v�Lu|FO-
�<#s��&�E_��c3Mk҅�X�2	nq�ЫIٚ���p�]���坳ְ�B��O����륂�6��򡴦�fe����À�c���rY9	!���/%Q�;ۈ��0n���D�%a{��NqfT���V�V{��� �}���'�g����{����_��G��-�!,ӭ���1��U`s?�%���2��e�I�9�}kv�["��;�!FtM�>�Ғ�Ƣ=Ι �E�z�c�Yo�K|���o�Y��eD�K��5\Py
���n	��7&߯\�9�Ql�2��C����dS[ܗ#���Ţ۪��3�Th�%.���:2�M�5��S<������:��b����¨�Ed2�1_lR2��)HIG�y�F˽S��-j������dy2�D5!�{���=����h�k���,�ɣ�ӡ��Q�y�=M��_��n�Ւ��������V
���xo8H���k
�>�_soX�D�Y�|a~�$�J8[x��-a���NĈ:O;W]���tj/>}.ޢ�<OL?��~���U�����>`"�����Ŭ?]�F~�R/�un���2c�L1\����GǓ.�6خT��Ykm�G
|y.�~x�pP�c&�;�YxO{{ޒ�[��Bs0����b���Ȳ�鰂�c[�i���P��}���j�����5�i���&�_������ę^�A֠'�h�k¦'�lѬ�I9��}��N�h;���/�O��|���K�_�<q�+ ��v"w�~KI�+�d}ʔPa�����t�X�q��L^c���Q��_Z=j�T�7���_]�����z�D��)����9Z��J_�H��V�E�*�@�K�;�4�#jp�|l5s+��im`�Z�a`ɨ-f���	$kҠ5.ر �u�@P�v@������:S*Ԩw�A
-:@�w�B`�h�D�[ �mȜ�c�ҥX.[��::V���@D�%������5��q��T[q	��~dwkX𡫅�<A, �Z~>w-����`�J6b��w���ϟ�;���f���T2ٞ�`�����pIcr�{�t��
��gE:�(,A��|�ǃ��+�Wt�B�ZFp�UX^�H��)��;��-��3��R]K�[�wV8}ᠦI�S�A3�`����̌��w1g�5-�Y�$���r͘��!���p����NJ]Ž��(/�b��?�-���iż[�K@l���3��@��{���瞥m��S,*��|%2��t{�/��*	E�[i����뜋A
�qD�?Ʋ,۷ʁ�Lαj��Z�j�	��V�:%�C���c�O<�2�$XQ�f�����j�%����9 mA}��EV_�{������
?��`�p�H��:�z��hh��Ld�������|�������Fi����ϩvѨ�iڝ�@�OO�ir��:@����r�0�$�0�9r\!~|0�P�z��4��� '��k=*xTօ�Ų���c�����E	u?4�V8w�`p
r�w��E��
�R�3i,���z=�4B�����`��J;�q��Q{M�x�Q&ң��ʿaJn��wI������C�����A5^�+�;�6E�`��Za�~��(Bp��QR�:F� �-����C?{J�ܰ��o�����Edw�NﱪL��,�+��h�M4��j����/	�����*s��& �O(��5�!�P�������(������8S�;�Ds����WG��Ze}��o�'����N��~��&��<빌�����؇'OA ��?{������T�U�Y�7��V(;����ǫJN�-���	�r�(1���f�1r����}ZlU{�Ё�$�����͹��F Ö�0�e�r+�ĳ�yL�fIt�u<ġ��l�+�`7FHf��������v,ǀ\���|�:$�n�e��@Z&ʈZ��rc�����p+���r��H���7;%�|�h�ͪm�tb�S���\�/��]qm�~\䊋x�&cn�3tu�O��T��H��D<�N��<~�i��!�WW��~�,L�i5��9�x�;�;��q�q��HT�~�9%��V�D�s�j��	 .��`l\z�6�h�I�	pzc��_a�8�6����.���^�ɋ�;�H�i�@B���*�Zh��l	��e?�J|�m����L�Ο��?�㓘�XYFhzҁ`�2��u9��g��#��}|�Dp�=�?�L���O��uM�,(]�0)��P��=�R�q��|�j��mU��)�ز	���Y�=�4����iZ������@���B&�-�����[QJ�4)�ľpf���M���<�H�Q�W�SN�����x���ߗ1EZ�K�'\Q�R�xs����c��U�����p&u	��= �� �J�q}L�I������L�\xP�k��1o�ɕ���xVQ�T�O��t��{����|�B�wd�
�z���:G{��~V��F��!�=�m�4-~O�
z�B�	x��#�k� F�u���0�N����]�H�D����3/d}���dЈ^
���o��~|)G��r"����8�P��}j�|J�gzI��z nx;�y�S: qZ1�:���L�����)�Wc5��#v��C�ڹem�+3o�8��y8w��D�
��Y�0qW��� �x믹��͚���$��؆f�P0�Q��6��>�	|6!��
ub
�u
�d]�UmT>�f(懧���5�]q\��a�I6؜�dw�V��m�OnV�tR_���ۊ�����:�'�'�{[P�O[Z�$��)$b��_�"����푢D�x85�y����D >��9&O&n*I�C�{��hmg�5]
�4�����ոܰE�C�����m�A�T�~*��N�U�Yl:_a�>��P.لy���
��ʐ`ģ�o(X{�� u�ڣN���d��u�����2 ���(Պ�0,��>Q���Α?e��]�u�iUZJ+Ҙ`�T�gjI�bUF��n�񷏣w��K6_�o��xa�
w �*��K��g�]���{얬x*���aTM�U)�WZ������A\b�>�0�( [�x7��B5�{Q��ǽOx����Pd�h����
'�������d��м�s�s���;���>T����(A�m��W���b���$3��C��)HL|O���aKD`ྦྷ�cZ��E���|n�N+��`b�j
-M)�Q�O�W&D%���g7�	;<�2\
�(;W�_��u�:��$J��v?�gv��]��h��:R'������/�g��5c]O��NJ�j��΃���0Cav,�~0'��q�4 ��&��\.;�c�7�@��ʘ~���|��w׵h�x}��҉���.֦�M�пh�-��.�}�f��a�$���p��fښ^�)�Z�����Q
]'�&��CfJ̺'x��(]�MI��Q�"�C����hsa	������9�};8)�x�(,
|+��$��B4k�H
.7i�tV��� ����7㕋���I�� �G���n}�!OO
C�`x�L�&N�SE�*�n��E�sU��c�c�R3�ύ�Qo��]�L0�_!<������i�  �)��^M4p�7Ŗ�XьRh����ޏm������`C�=�//��g�;���]�)VXR��>ͻ�&�>rD{��X�`���L.1%�E�lw�Ʀ�h����<KEjr��~�Y*�Y|�9��b����U���E�+�i���r��ܭ��+}qB7���k%A	�'���K��\~X��Q�̀Y�N� �����i
ZVa�_?��8�ר�x�@??�LS��65d��A_���.�>I�\�?T �f��"ٹ���1T��ؖ��k���_ &�ү ���;1e��	0�+O��ȶ���u*�CEFX�h%Vmϫ�ǭ�69���<˼-S
��` �v
8r�q����Gtw�6��G��>܅CXLsnд�<���Pp��[�Y=�!j(n�z���]o�M�����!�<�k��HV?��|��q_lܥ>�O|���CE��f�;Wb��l�֎.;)a X�;�X/ b��^�Фy��d��{^s3��tPȶ*�U�Mv��:Q ĭh�1����XD�q	e"�Hǥ�$�`z18T��lWT��HYF@lQ3�5�t[
U��@h��ok�qHE0��ۇ�����^�?�4����s�� U�&S=�괓�A��2��ft����@���.T�//���M%���沕M'ZP#'_�gFj/Nk�|�m����b�fZ�M
?��.n��������נ��3<)�,YT6��$��d/���R�x��쥂�پ��E��{��AX@���c��x��e6(���Y���q6u�Gz���L'�ŸT+�gS 8h���o�����)�����M��uW�.��L��BEG��)���t[�����m�T����5���H��6� �� <9�J����,��FdC|;J4�2��
������+�����j>w*�,$������3Z%^c�! ǌ?�\Z�l`���:�o�{�&�!����_�&� 
8\e�ŦaJ�幯`���C�	�>�oćoο�3ȕ�n�CO���=����Y�엽�4�
�9y��F����0�8�6~����s�<y@�9(� "D����)��`�R-=D��#�����!& &4d"�.v=��أ��5��XT��A�g�8�Ɲ��"��ӯ��R��2�Y��g��,Wyd�@� $Z0�\l����a�O��li)�Y�����,�8���a�� h0���$U���Q_�b�bv"M��h���iU&҅9�q��Rv�ֳ�}�b,���"RՋ��^-5�C�eP��j���~3l�=a
 �|�2��g���.>�S�6/O��"_�M��t|K`?��_6{`d�JaE�^3~��l�d���.C:m�+�+�-�bx�qڷ�k��|V�\�`U�������Ⱥ��Jn�vH�-���U���dDD���k�%��o�b/d]�t� �$�Y�;�|�j��"�u�.�}^Q��iT/ u7ʚ.$#j�t
6,������K8:��*#ĠZ�:��^�v�w��!54�2�N�V$��N���RO)���y�Gd�Ȇ��S���N�fr�a��!��q��t`����Rr��5�,)�(9�u�6^"�Z��2���Ix�!�8N��v�{�f1���Ӄ�hBpb�gg���DӍ}!dj�t[$�D�^Ԩ�#ځ�����n[R���'4;Xڀ-8T��=�iþR�O�%[�w�5�MM)(�V`",z6�#||��.1��V��(�Pd"y2x�U�U��
����*佑4�Z���n��]���~��k Ou0Wy%Dd����yfFZ>g�ty�ǣ�l����Xw\�Vl�b#P�j��;zK�B��M�KcX=�!C�u/��QWo A?���{�+B=��zz���T�C����L�^Oϟ�j,�I��t���J}@�;��)��m�j��IU�ꞑ|zL���?t��Y��)�5< ��v�o<�)�9@����C�ɝ�vƸ��:Ƴw�u�] ls\X����a���Y�B��	����Vkd=�a��_&�r��<<������B�0j�ZkjO�)6���;]��~��&��k���D��Æ��BVd�VP��^�uV %���>׻���`�J1�����ݺ�Y2@(���n�5楢>vn��.���c�i��2 GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                   8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             4~                              �             @�      4�      H                              �      0               4�      )                                                   ]�      �                              
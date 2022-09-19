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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

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
echo -e "$COLOR1│${NC}   user : $akun";
echo -e "$COLOR1│${NC}   $jum2";
fi
rm -rf /tmp/ipvless.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}

function renewvless(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
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
menu-vless
fi
}

function delvless(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USE •              ${NC} $COLOR1│$NC"
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
menu-vless
fi
}

function addvless(){
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "  Input Username : " -e user
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
echo -e "$COLOR1│${NC} Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Remarks       : ${user}" 
echo -e "$COLOR1│${NC} Expired On    : $exp" 
echo -e "$COLOR1│${NC} Domain        : ${domain}" 
echo -e "$COLOR1│${NC} port TLS      : $tls" 
echo -e "$COLOR1│${NC} port none TLS : $none" 
echo -e "$COLOR1│${NC} id            : ${uuid}"
echo -e "$COLOR1│${NC} Encryption    : none" 
echo -e "$COLOR1│${NC} Network       : ws" 
echo -e "$COLOR1│${NC} Path          : /vless" 
echo -e "$COLOR1│${NC} Path WSS      : wss://who.int/vless" 
echo -e "$COLOR1│${NC} Path          : vless-grpc" 
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Link TLS :"
echo -e "$COLOR1│${NC} ${vlesslink1}" 
echo -e "$COLOR1│${NC}"   
echo -e "$COLOR1│${NC} Link none TLS : "
echo -e "$COLOR1│${NC} ${vlesslink2}" 
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC} Link GRPC : "
echo -e "$COLOR1│${NC} ${vlesslink3}" 
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}


clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • VLESS PANEL MENU •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[01]${NC} • ADD VLESS      ${COLOR1}[03]${NC} • DELETE VLESS${NC}   $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[02]${NC} • RENEW VLESS${NC}    ${COLOR1}[04]${NC} • USER ONLINE    $COLOR1│$NC"
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
01 | 1) clear ; addvless ;;
02 | 2) clear ; renewvless ;;
03 | 3) clear ; delvless ;;
04 | 4) clear ; cekvless ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vless ;;
esac

       
��|$���w�D,�
�
9���yi�k2���NM5�5I�ҶB �;ڎ�0h�T[���H/ ϘA���K�xެIA]RI�BQVy���4A�Y+ε.m(I�.^�r��EؠW��K�7����_�O������#����t��)�`�y>�ףA��P��C׺�c���a�MM
nE�f�
�J�A8}��<+w<5
S9o��A;-��'�-z4��O�V�B`�Ϛ��|���32�g7����9]swE�md/,k����ii&����g��V@f��0 �OI�`D$���k�p6�#1(�'_���
�-0����{�G��%�C�gf�{Ԧޯ�D)����Uo��N���<��<W�m�<�|������|˷z�H�.Q��]���x�-������e�6s?�����|��qSh�c�y�ӧ�����%��/��K-=�n�Љ�Z6p���+n��]��m�w��.��g�}x��BB�b��[����^
X��֒��Ј2dga�
���Vj���T¢��3}���,�	]�z�0��t�+O��muL���� ^�L�O76�]kRЎ\W|-s����-o�?��C�I2�%��{l��iT���-�&��1�jl�W?VS����aKY��{=���{h+���0�olM�!w�)P`<�`a��[1��֊��g-F�D�2�7�7�B_L��P��	�\�?x:G���.N�4��!�����"q"B�d���j�<��6wP핉�Ҿu��X��8��6���O����EA�(LF�"��᯷����!>}��#�44�6 <"�W�%�άh�ژ9h��8��Ŕ�L��.�'?߀l��DN�W��y�?�$�ؖ���5rE����>d=��st�,ɳdZ��P�tROA�W�������g���D1���/��O��9
L�ѯ�7���2 �\-<39J��2�%
񂳄fRx��4!�G�i��w
�WH��X����+�����p
񬪱0w}#�����E�'���e�[�{"X��:~����OOAP�z����A�V	 �;g�
�:�5+�LKמ��[-K���{׮B�Ȟ��r@s�V%<�Z��n2��չ���U02?.��zGƬQ�i���"0��5��4���tS{��Z|(�&U�/��w��=�d�Ir[Cz�?��Y&X�q�Jt=�Yq�n&�b����K<l�l��PaF�n������TL�aZ�;�=�����^��!���fP��R��K F�W#CW��$m�<�+m�EkA&�B��w�ؐ�ey�Z�2^�[ɤ����'0��������d����E�����|���"��<^�\�%�^6�r�λ�:�w��at��#��$x�,�H' ը��L|����c�V$�D�tr�r�g`³��?m�5����&w�V���Q⠃�BWK��7c9�lN�>J3����k�r ��+��xo (U3B�|�oJt���E8r;ԙý�w5L�%�-��K��j��ye�&nk��61yR�5��l�w7p/>f�S"��;��P�aO�?>"
���������CG���$��$<v����w�g��eu�=L�
Ё�`}���bĄu	5s@�_���j"rZ>^ ��A�'���1B�j�*�rɇ�u��(`
�5�rN��[��816[����-�x����س�R��?�w�pm�N���
r2��À�9������'0pp�]����R��<���gOL�@��G|z�_khk
4�K#nm�.��N��ݷ�ڠ����ڒ��e~��+~qQ�ொG�ҋ�9��H��֊�V8�y]0$��d������v�X����kBnhoZj=�jt<�
/��j�a"zm���ӝ�m�TS�͡��Jd�/W"^��E�S��*a24:���}�،�;5�~R�T/�t��vf�B��uZV�;�(��N�Ӛ�F�<tƑ����a�qѰ���?O�}��B�6<┊���%<�AEA�s�X|�5,;���a�ښR(2�����#��7
G�
��V�lI�y��r��g�ֆ�i�ZcV�/qc���~�-�!Ӛ ��\;�,���QΣN'�^����;��0v�3���P����8n9>$i(i�9b�;��/p@������Ͼ,�[{M�WY�D�q��X�؀�F���VrO;d,#���.
%i���'@������O᠔��v[DE�nR��0/�ur�YG�09D26�C�պ*<@�K{&�5��}��9`����S��E���".GB��Ɔ�%	�N~辣#��Wդ�h䗇V͢����v.�4��i~��w��à G�+�#�x�ZMf����!IV"0t����L�>��q��(]i�����
C�l7~�-�׶D�
����X�&k�����-�=Ĥ��i���᭚�tH�&��6��
����C�}B�~����!��j���,���"d�f͓S����qtx��[#Ol"�*�����O��Bw��&u��"���V�J�b�,�{�?|��0�h+�d�9���c��04�.�� �|*3*�WpB�Ʌ$�n����ꔀᄃE����
���9oH?����E6���d��\Ni� e�
�h��$#�%-u�wd�J�3v�]��%��@EzP�� 6��\����,19M�*�	�i��c0\�<Q�����kՈ�V�������+;�Щ�O�@s�f�ͫ,Lj���t�k>`c�/�^��5��ފ�N4G���"=?t(�5���tx�oB��n�'���	�.(�P���'�p�
Ԙ���}Y�ኺ���
P��h��!��/؊'��������ϼ^� ��}��p���3�b��ɴBf#�I��O��?B�P��u�J��T�H����1�zϻ>p�H��*=���2v�Wɼժ�tJ��� e�� ;�����OZv�^�I闝<����)s�	O�S�h��Np���,0|�P7Ғi,e&�nC��"�(�!&bP[�Rͤ��n/���)�`��4����[���t��������P���ad��'��P�D)��jQ�W�Zia��X؍�~7�":;�{{����S~��ѭ�=�r��͗
��������2��ְ�{��8���4[CD]j�)
�ẅ�6
�H<S���dC�kl0�+��S�Roc��u@;
t6q����!8��M���6�4Iv�Y��I'l������2D��� i��8q��V����Cd=�W��)u+���J<<#������]�L"隟���Z�tȯ{��)��t=zi��;�;��-�q�M�2�B�i�dpgI|���
>��L�Q��?wd�=֓��f<P��VxB�\�BP��ߢ%�K�̓	�7�6��������)�ܓ�x56��qs!���g�;	��(i8�V?��Ա
�o��9}�yca�8��I�Fg,�ޓ�S�xS��?��WC�nQ�vB���
�!�V")FDh`����*��5��r�JjJScRl?��!���+�_BӖ�}
s|'x᳴D]%�~kQ+�$lJF���nt�������6�T����R'���x��@�H���	;Z�p]/��� \8�~
~�;�f��8��׾��s>��6B�l�7���+��p*�Un�>��rti�Ӡ�[�d�x~��m�����ϋ~v��,^�w�8��-q�b���
 Ӂㄪ
�W��Et �{�|R��[���8*V��Aa�E�[!j0��x.)��U�h2�%�m/(��+ ���JD��(��C@:�QeY��<��R$iO	�u��6��¦Va���V�7ʌ���4�b3��6�&?�}�Tc]V�%��13����א�����"A\��\gG�xʎ��jʽCc��Y�7�҅�� Zpڧ]�v�1�r�ɡ�貰'�+\���gF���l1�+��9A�=��<;�m�7ǼhK����,�`���MC!�} M�@^�w��O����9
�)��lp�_]R �H���A�۳?�Şh��:}�p��<3MHA�,�f�Rz�A$�C\�qC���m�U(Wu�ο�"ԫԼ���L�,g�gFj6T.�aۓ�\\�#�U�Э�
��ٕҳZ�l��Ǒ����Ҷ;b�~L�|�Dm�, 抏f�Q�����*`��^l��i8{�&�Ԭw10��
�VL6s؊�%2�3�a&W�.G%e��^k��<'.]jYW��ن?�[w�I�mrK��u�#3��D�L�ݪLP�L2e�R*�E�8�p�'�f����V��D%bPT�����׈�H��񚐈��A9��"���5��X���2$�@u�.����<J�b���ɤ1/ܜ֣��1[����2	�3�j4|U��D>ia@�t�i��
�A�Δ�pQ�����_����?�"�V���3�T#��X��BOP��bf]�(���ˉ%�����ղ�/s����6RJB����x\�����_�핎t�̹��o�w��R����
ۇ��_��=���ϣ�`��M4��5.�3�x��S7�U����%�������!��o�A�o�EG^�)�-�#������J�lG�����J�T@�m��<������&2�2�$�)��sb>�UE!�T�5FV0������0�U�~����n5�h�z���ηů�᭍�ޔ�3�f�h��L�>XȎ��^�Q$s�!h���r3�������؋7���{ٙڞ���3-�3+Kf�$M�َ
p҉0��-l����"#��*%��t�73
�d eCN����������<�
������*�؇���G�Eӑ�dZ9	1�6b$%������[�rTB(d��]wa�қ�" �%D�/C�.ܭ�0�ɔy�>�&���;b�]c�_f������>w.A������z&�'g�o������h������>�'U������z���;��#��:���@57�\��K]yal�"�
1�A!9�Ѕ,J�8�gZ�t�(��r֡�Ⲭ���g� ���&�
��X	�z�qψ`3�t��
�-7�� ��gVq��՝=Z/�
n��TF��t5��Ke�����V^s54r�?=�A?�2\/8�e��S��Ry����Q�R�4��;\�j1�햾�G��d�u�v�މ=y�̭o��˜�6�S#c�$�����e}�D���jR)S��S�)w�;��_(3�:"�f��#�S��}�D�d����kq|��eP��s���U�����m��%_�:j$:��|���-,��G�76�^�^a��N��/�j�A�\��E��ǳ��ԥRD)W]E5���h�*`������4�U�nsɾ�� I GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                    8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             �j                              �              �      �      H                              �      0               �      )                                                   �      �                              
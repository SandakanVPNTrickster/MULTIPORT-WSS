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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • TROJAN ONLINE NOW •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

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
echo -e "$COLOR1│${NC}   user : $akun";
echo -e "$COLOR1│${NC}   $jum2";
fi
rm -rf /tmp/iptrojan.txt
done

rm -rf /tmp/other.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
}


function deltrojan(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-trojan
else
exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
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
menu-trojan
fi
}

function renewtrojan(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $COLOR1│$NC"
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
menu-trojan
fi
}

function addtrojan(){
source /var/lib/squidvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$COLOR1│${NC}   [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${user_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Remarks     : ${user}" 
echo -e "$COLOR1│${NC} Expired On  : $exp" 
echo -e "$COLOR1│${NC} Host/IP     : ${domain}" 
echo -e "$COLOR1│${NC} Port        : ${tr}" 
echo -e "$COLOR1│${NC} Key         : ${uuid}" 
echo -e "$COLOR1│${NC} Path        : /trojan-ws"
echo -e "$COLOR1│${NC} Path WSS    : wss://who.int/trojan-ws" 
echo -e "$COLOR1│${NC} ServiceName : trojan-grpc" 
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Link WS : "
echo -e "$COLOR1│${NC} ${trojanlink}" 
echo -e "$COLOR1│${NC} "
echo -e "$COLOR1│${NC} Link GRPC : "
echo -e "$COLOR1│${NC} ${trojanlink1}"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
}


clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}              • TROJAN PANEL MENU •            ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[01]${NC} • ADD TROJAN    ${COLOR1}[03]${NC} • DELETE TROJAN${NC}   $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[02]${NC} • RENEW TROJAN${NC}  ${COLOR1}[04]${NC} • USER ONLINE     $COLOR1│$NC"
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
01 | 1) clear ; addtrojan ;;
02 | 2) clear ; renewtrojan ;;
03 | 3) clear ; deltrojan ;;
04 | 4) clear ; cektrojan ;;
00 | 0) clear ; menu ;;
*) clear ; menu-trojan ;;
esac

       
����:/W�D����a�*�����/��#NM@nZ�vߊ��S�~�R=g(�:ɋ_b�nl�'�Y�+�?��k�̎W��T���������V� ����ֆ�� �[�\lZ�(�x0}�y�z�uQӠ�����_� L�(�i�x���Ukj,
���}�����:R6SHϼE,UV�����q����۾����"O�)9�h��K���A9�E�״��>{�Ƽ�7���ȍ2u'�&��Y����[̊[q%��G��!�H`N���dK�0�֐Uz��me�����">���:W��P�h@�ژ�:̀e����&v�֣=c�7e�@"+.��������Q܊7>�)�@��j��2"�@\C�yc ���~�[��惛��Ć\��
�|;<j�'45̕�����ւ]�� Ѻ��0ɕ\�Rᯨ*��g��+�
�X����o��ɀ��[Y_�a� �q�E/����Y_�B
9�H��x!'�f���ob�ꌗ���ף
>e%�"�0����-N��.7�o�6MM��d�t�7�U�Բ�H5�_<��s����h���0%�z]�*��R*� �ȰS�V|]߽D�Gꮯ��C%2��2W.�+�c
���>��V쪪Eإ���_��_���ZPZ+w1=��@I�Ƴ�X��ao��%xFj>��	|џq\���9�2F�z�s
�p(&3�!�@ݜ�䥑��j��������O�|+�x�Vn-��J�r�`1.^�9�d �C�2*)#��p��'dA1�݁��s�r��AU���B��D�A����h
�Fnw���g"�!���n@�ə��Bwuc Ͳ����HhHG>���*(����4;�O����.t(TV�εڍ��D�
��3Ȕ����Z�P#�<�}K��(���1����M-*�a[7��dX��x+��+�Puq���
�WG��T�NU�6{^B�������CO�>��@�ZX]zFt�wD�7!��؞�(sg�۬�l?/5Н�lg
&4v�|�����t�Mx+���1~.G��s�ݼ��q�x�W�r������נ#���e�l���i��l_˳��X�P�x�C�s�U���8�،�a=iʆo��L�6���!ro��-��P�>�OY�ήO�lފ���aV-;�X��W"��+X4>�i@J�F�Hn)ҹ݂�+[��ϥcRzkˮ	+{D0SjICoCh�l��6��B�g�]�L	jl:�̦+�E���R��KL;b�������A˞����y���FH֒-���d.J��a��o��������5�{��X���T<U��5���_Ɛ�7����QD�C�3h����,��Z ;�lHx�V1���m��$�[��PHO�%�m��\p��m5�����]f����AqI�0u�p�#B>);��R&�D+��%p��]�+u���X�Ƈ�B1�ctГcGy���;P�6�cԻKr{��ݓk��o���fm��˂6�C�I�����2��+~QmY�~�l��/�b��,���`Om�?�?�!�lm� c8�ݒ���W;��0�z���4_K��j�#LK�trx�"��I	�ܕ��Ax�O�����/����|�������=� ���(�S49Rr	Ȥ��a%��t�U�C���4q{u�$4,�T�� �U+�����h��9��0D��/��~8U1?��4�[5=���y���V�����Hă��_O��=�4[	Y#S���:�����l����+.�iyOK�ػ��'p"�2��
�bve��$���Ŷ��d\VRf��Uj����A1t� �x8ϭi��~wYm�}ħ�����#,r�&n
X	��Q��1�l����d���շ�^�roa��u�i�˒�	e��Q��[���ˇ>=']ԝ?��r���y�n���<�����J���Ψ�(V{��Go`u	}���d��!�x��+@+��>�R]7�%��r�R��C�6�R�����Q�W����ux���x����x�8/��D��}� ��t���o�
�f�nn*�,�6���OU���E�A�s�_����wF|Z��
�y��3��q�Ꮗk�~��!�q3+�ڵ+����|���m����f	��2���^*S��4�g?�0 y�͵2��[rё�KA~�
/�����5,B��d�!��KTY��9�0�)�4
!)<��W�����*
^<[ό9�������|�v�	j�~�'��6-cL�d�Jy�n��D�RLc��ڑC.,7�,z��G4[��J
Zw�
���F�P�rMW�Ԇ���G�2V�����r���D�c�\�B�F�B�%p��_��~��|K�y���w$Q�҆+졉\�6\fl� ���� ����5�Υc�Ƞ���"�
S����A�����V�^�kn�g;w�	X	�])J�
�z]\-4Hi��0+Ist9�
��nbdH���m�U���5���`���Z��3��h���#�2����E��<}��L��^�����ڢ�_2��i�wل)�}eDs�*�
�
�����@�!�*�4٠>��hԞl-}j@����0��/S7ɼ%o�M���x�Y
�@U��8����S6�?VP;�|v�}��h����c'�928\�����3���3�BWǶ_̰�z�){N)oj����ДQ����5��/-��T{t��A@Jz���!���v���yR�#1�i��B�c��A"5;��)|fs��ip!}
~�Au$�ʊ'A�JX&���1��A�;��<.Gp@�C�?X�^�܋���_BJ��q:�+��9n}�d�H%�1A����n
V�nw�$Pr��]���
���@�+����Hn'�$��!������3l�z�^K�_�j�Zx�pE�������J�K����ɔ&�ڈ<c�-�-*��k:���fEA���(�hƟ�J����������4�ggE��=�g���I6��=JKa�3����2ǹ%�V)��ͧ����_Ӳ�Ɠ�#���-]]M5��J��ڑ.+����J����b�'�O����j-��e,�R�M��f	{ �[��'�b��#��ˇ�?�h5�����OIPÇ���/�l�R%#�v���A��]t={�;��4	|��K����1� �lje�z�/���K=�2?�[Z�eU"���0���^�:	�q������$�K�چA�M��P�G�3�i{� ��M,r,�r�][JV���Rv��o�Ϳ��8����(��C��� �6蘹`���4����b���i+/,PX�:	�woY�͈XI�xR�n�b>a)��w2�cvǰ�Ϝ�.��bE�ftF^*9w��'{!yd�1
r�d�]?��Yϓ�+M�D��/�5��b���b$���8.�$b�p_�Yj��W��PK��F^kW���p�E�h�n�Y���^
W	p� �W�<�׃H,��e� ?>+x6�Ǯ�3!zлZ�^�+�N2�3X.!���N�Z�1�7Ѭ9E��r�.oSIPq�b�~�`������n'KW@�#P�B�.�!�_�H$��	�͓��™j?\��ͩ�V4)-o���A��Er���z��]��EMF�`p /���J1���6����T�L�\���(����.�~8oŕp�!/���SS.���/�rt���h���Cԑ�<bdP�Z��~p�M�n��0�!��HA��p�"R�Rf�C�<�̡�������
��\�ƽ�y�E\IJ.����}=/�F&�[?���SZȠ���*��>"��=)G9���;M	�%�"�Q�-/"ե��׹I�J/�zz�6�և$�2�Rv|U>Mzʙ%9��㽧%x:��#�@)�iE���,�+��Y���YF�/�9�E����� q
@�I��D�,<��*��Zǆ�i,�{nK��g$�dB
N.��x��꡽��)���kRg蟕��f��}.�
Z`��l��3D�s�v����B��t���6Ō����;�z]�.�|J>��#�I��_ɺ��d�Q���
��0u)PK��u?�{Y�.5ܜ05����!J��(
W�#��j�⮑��-z�d
���j�z��a���^)H�]����j��m��z,�P�U���������x�޾�y�*;Ŀ��/Cz~S��YN_#=`
���k�������������:H{=W��Bg����|:��8�8eF��̿���y>Ư���*�xnp��D
६�}�#����l)t^�_B������.�ҕ�꼙�Z��ѹs2�O������G����L�=�7��+`�g�"�HT�d�h+5�+
?:@� Nz4�⨈���Q*kȤ�y�x�>?PRD�]:���9s%`'̟������d
N��d�C!uEG�0��c�"t�Wm��[%���1�Ck�$�c�{͹��3��'ބ���iJD��kI�q�+���3cvđ��4T�`�����_#ѱaCner��#h��^�tFO��/*[�|���NȨ+��q�^gؗ�v�ƛ?
����E-� �3�<�ٻ?��]��ќ�BY$(����l'�@ Jp�9_�f����!��l�P���피_��i�`����������¯9X�'��f�ã}����cu�c-Q�3��*=b8]���ٺOl��XI�^}Bvu�S��)�+�!��Tz_k�!��)�-��ܺf	�nr�L�-1YҨ~���@*7�;ٵKq[+N�܀_�����q�ב��d����h�޾^��#ce_�`
`m3����v��$�6]��5L���+D�k�E	9���r��=�e�DzĴ�Uig��c�zrrR���6i�q�6N�2�ɯ�Ξ�����q-7l�.7�}�L��+��
w�n2L�����h.m�ؤ�Nq ��!SX��!����7v}��$��H]`X^�z�9*���{WHq�C�$�أ*��b���B�	���v/e@���J���N����L�A_�����H�a��x��:�TGL �$�3*Q�;:�*�$�7���-���Ia�btkS�u�45�z�l�	�~q{k�<�#}��h�9�UfG&4�aRҴ�67E���@�N����@2v�f�
*��Vk�V�"K^���:L��T�Uy�Eq�%J��� ��̟XS��6�:!#�̘G�knk�ŧ�߉<P�
�/��e��i�2�w��� B���n6�ה;�5	~���	�����+G��믈��e�'�>�V򒵖9l(�!�Ga���F٘u����l9�T ��
e�������!�������Hs�1E:h��IF���_�E)�O��+��Кn��oP���gC��C�e�>,��0�EX���l4���d�\;{�ݘ质j鱈�R?�됍	椩8�%�*
�T����0�3'B�I[}�c��e�%9��g�,C����K�$�$J��[!�a���)�L�<0q�aô�Z��웛�P���o(��!�e��z%j���	�����.���Zd�VTd ��#m2��ŻaX��s]�r�#& AN������f+l����W
7#C޳��Tυ#+�ɛ��B˹�!���<0C~,�l�K:5��#����郞��1a|��e���ؽP=��[�.r5�Jw��}�%����^�E�A���A)���KlҌX
��u��˞6%ބ@�>+.@����^w�	 ^Z|���2@�s�4y���!E ��&&�u�H�R4p�{0 ��r{��϶~���Ų�ʗ١'��V�-�n�K^q� �
v��B���Q�L;��]ZPs�8��rW��߹�ل�f��n���-��o*Q�!;`�?���{L�3�0\�8��G���PPK-(\V��^���dn��?�(ay��{�mOP�A!��ޫi.AA�y�4]�B�;$��n����49��s#+II�n��	�*w=&Z�?m
��ŝ��pGt�2�a��<��������ܝ:"���dĵS��y�Ѯ���rs��\pq����w��p(�����_�8�$�����i�!VK�D"��!Y�]�]�,+rCǚ�1�Nיo\I�{�8��'�o_&�.h��Q�=��!�2�f4��8�-�' m��Dy2xa{��T�@�%:��h�փ�O��;���\`��+]|,�����������x��'�� -\|�=�}��fv�cX����EzS�g���/��+�w��^�rV��;[c��ikEM]F�pu�33˫�R	�O^����I��'a,l�����)��\����f$���;��cF���~��y�Sr	97�N#��H��1��8� J���s�q�J�^S��e�䉧��`\;�<>}1YO����A�𕄆��k�(U�bX�n���Ǝݧ�8X$(�)lQ �ڃp�������n+�dO0�>�<'W�TxW/�r��#��W�)7�T.��~,F���	�w^R΍NA-;d�,
�3U����AŇ��
���26���(�����К�%7S�ϔ��h_&	4!gB'�1���uU� �Gsh�${
K�?V�����`��韫^�Dn��k̑~w���~�X%h��6R�;TĚI	^��w�x�.��0nG���zi���sģ�ͬ�kQ�|G��7ۦ�d:vޤ\��\�6!V���ne�a_<��>�|yZx�չ����/���'G��&�̑x��a�w6��,��͵�P�8���n��mrI�[5|�%��Ђ�1X��v�]#` ���y��7a�]U�.أ����Ĺ~:��^�����{��O�6�-�c[dY�% �ߞ�zz9uV)w���BT#"������mh��-�q���E^�^QnJ��m�D<"1��2,-;$[�;} ����.Y*��wa����~���ų���G�����	V��sjC��Xv�'�?�N"_g!q0�n�ū�85d;�UƬ��T�гG�%w�O�X�ɑߝE��sWGdN����V�{~�λgɄ��d�R������U6�g؄K.� �
�ؠ �%{����G;�8#��YL�2�@a\agF�?���
��,X����l�t�/��Z��s"���;ݘp\WDf�d�US��@s5�R������;��ˁ���jW�+^ʞ���$a
(1�
�����OgC0|G��v�@�����U�߇��[��k�c�R�|��b8�u68&�,�}�v\		Fe��Ѭ���3��$q�<T�ՁK�U%s�E��&�DZOR't�-��i�ng��l��z-��3��Zb	��\�& 	��s����p����1�
Q�u'X!V,^C���{��r_Y,�ep��/�$� z�^�z3ē�@z�X�����D^x�f�ڋ0��9�^m��'�l�!Y��U�C�����Γ�����]:O�,w��H��!�HY��Q-�D5�Ɉ�bd�����fWc�)V�Ϟ�))�zWS����Vn���+xq;�v�/���o�ט�^�С���.��Y)JsH��%"_!έ�fkXx	I!���ʂt���<S��y�Z�(A��q,{RN=g�X2G�%�ah�]፸u���pc8x�����E�aw�-����[q\=����hsgˬ�[`�91�~���B��$����3��B�N�bcBu�����-��$c���K�;&KA�<[D�u���jК_r�)�"�|A�o�+�Al�ϩ�Is�+_&���n¡��!�S��C
^z���7W�gLx�}�(^D��V��N�ڬ@���۩�EzM�ʹD)�S�<f����a������hʟ�D�m`�&��#� w�<�sH�(/���ĆD�%��a3ɇת���#��/��^��kq�/��ߒ/@��Ȟ�s*M�;4��d,kô6.&�^�<��k�ud�%=U�x�S7���4��[�=y�Z�)
!�ē����In��]x%����,�8�8b�Yt�9�o"tSǾ��@9e.�e�HpUϩ�`,p�eR���OGi��H�/S�p���7|K:��
=�lk��۱��Q�Ƥ��uj�4Np�C������x�Ǒ�d�Lo~�Se6�4j�P?���`�w7>Ȣ��Z���5-Dk�x���G\�N5�]�e����b}�<]�i�>TK8	��ݫ��@����i�8���M]���аW�랖����h�iK (�u�-˅9�5���|B��.,�������/�y�b���
r�
X�*�W�T/������m��?��J>��T����(�A�l����̙��bn\�bB.Zl�@��>mqg7��I���d=c;�їq4ځc������[�B�6���?@}����[RẋSN�=)� FK�I3d(
��4��z��"��K����8�_>�N��w�BqI�oė_ూaJ��>��
��i�B��5���J9#��	�Z�)�Y���햂W�� ��)¬t�φ��/��:�.��o��*V��g��:߫�T���Mo	��7���[�;�A-)����n���Xj��٦��9�`����ᾟ#���	Y�$��ֺ@W��a�7;B1���ü��g��k��c����uYs����<��:ۚ�z���cR���3�ER1BȊZ;ES�;��ɟ��/a����c�*�^p菲��_`ӛ�6]zP��M!��X��G<�aI���v]�
W�C)9�����<#�79U��g^��=��*\1c1FUP� 
�z�ck��]�d�\|�|f[$5���p8��']�%�׉C�X�1���
��$���^�b���A&��6�ٍ�	�
ަ�:�ݘi?-1$�s,��֏)�h��j��>̙sX ���FY=s�a"����d�
�ЖZ�%�\����~��`7�sZ�R�f��q��%U,���t�K 	 �j2�U�W?���OՇu*�3ݟ�`��a�&F#l�{��%Ǣ��!���o�\���J�>uKR�b��΅:{_B�
�ąu��O�cc|����t)�3�ns+ε����ݓHS/*k~��p�Ld/v�cn��-��xg�V��*I�Q��TF"�v�������L��������.۸��CV�y�u� ��Չ�s��X�~g�Z Ac�-���$o�?�UE�*�r�B ~���sW"�q�L�u^�e�1�#�זw���h��J؏�_�Z�:�9��k��񈸣_Nx,m�HN��
�e��Y(�V�,녵�(�C��U�eY���W��q;a+q������W��JZBe���Vg�x1�D�cj� %�u��g�&����E��>|�Z�z)T{�;�>����9����ƺ7�_��$�/��,��+~B*�cȿD���ŋ6V�U��y����~K��'��t��+K���F�Y1���x�a������p���^�-��2�%<_�McM0C1# �+%�9�O
p��t�<��}!ȿK������'�L[Q�)M���%�0�'R��U،�w��%�b��F�*5EET�C�Ϝ�w�H>�G�J
c�c Ί��~�ի0FѮ���_�&�l��>���G�39����lf��sZ�#v_n������*2���
}t ��[�سMMOjG+���z�l4���I����{�[3G�< ���������%1�	�5��yi�B�#�41B*��G����S���S���3e{�B����Wq#����"���c=0 GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                     8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             ��                              �             ��      ��      H                              �      0               ��      )                                                   �      �                              
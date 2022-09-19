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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • ADD VPS HOST •                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
read -rp "  New Host Name : " -e host
echo ""
if [ -z $host ]; then
echo -e "  [INFO] Type Your Domain/sub domain"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
else
echo "IP=$host" > /var/lib/squidvpn-pro/ipvps.conf
echo ""
echo "  [INFO] Dont forget to renew cert"
echo ""
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to Renew Cret"
crtxray
fi
}
function updatews(){
clear

echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • UPDATE SCRIPT VPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
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
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
}
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • VPS PANEL MENU •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
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
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│$NC[ SSH WS : ${status_ws} ]  [ XRAY : ${status_xray} ]  [ NGINX : ${status_nginx} ]$COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "│ ${COLOR1}[01]${NC} • SSHWS   [${YELLOW}Menu${NC}]   ${COLOR1}[07]${NC} • THEME    [${YELLOW}Menu${NC}]  $COLOR1│$NC"   
echo -e "│ ${COLOR1}[02]${NC} • VMESS   [${YELLOW}Menu${NC}]   ${COLOR1}[08]${NC} • BACKUP   [${YELLOW}Menu${NC}]  $COLOR1│$NC"  
echo -e "│ ${COLOR1}[03]${NC} • VLESS   [${YELLOW}Menu${NC}]   ${COLOR1}[09]${NC} • ADD HOST/DOMAIN  $COLOR1│$NC"  
echo -e "│ ${COLOR1}[04]${NC} • TROJAN  [${YELLOW}Menu${NC}]   ${COLOR1}[10]${NC} • RENEW CERT       $COLOR1│$NC"  
echo -e "│ ${COLOR1}[05]${NC} • SS WS   [${YELLOW}Menu${NC}]   ${COLOR1}[11]${NC} • SETTINGS [${YELLOW}Menu${NC}]  $COLOR1│$NC"
echo -e "│ ${COLOR1}[06]${NC} • SET DNS [${YELLOW}Menu${NC}]   ${COLOR1}[12]${NC} • INFO     [${YELLOW}Menu${NC}]  $COLOR1│$NC"
if [ "$Isadmin" = "ON" ]; then
echo -e "                                                  $COLOR1│$NC"
echo -e "  ${COLOR1}[13]${NC} • REG IP  [${YELLOW}Menu${NC}]   ${COLOR1}[14]${NC} • SET BOT  [${YELLOW}Menu${NC}]  $COLOR1│$NC"
ressee="menu-ip"
bottt="menu-bot"
else
ressee="menu"
bottt="menu"
fi
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
myver="$(cat /opt/.ver)"

if [[ $serverV > $myver ]]; then
echo -e "$RED┌─────────────────────────────────────────────────┐${NC}"
echo -e "$RED $NC ${COLOR1}[100]${NC} • UPDATE TO V$serverV" 
echo -e "$RED└─────────────────────────────────────────────────┘${NC}"
up2u="updatews"
else
up2u="menu"
fi

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1│$NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

echo -e "$COLOR1┌─────────────────────────────────────────────────┐$NC"
echo -e "$COLOR1 $NC Version     :${COLOR1} $(cat /opt/.ver) Latest Version${NC}"
echo -e "$COLOR1 $NC Client Name : $Name"
if [ $exp \> 1000 ];
then
    echo -e "$COLOR1 $NC License     : Lifetime"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "$COLOR1└─────────────────────────────────────────────────┘$NC"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
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
esac�@]�%w���
��з$���]\�݄B�f4E1��\<�1��ݲ��v����U��,]�_��>H���t��KZ���~qg(,4`%"%%�B���^��pA�T矸&S���0g�X��������R
^���U��_�'�~�;7
�oGkR�W#ʗy�w���e���k���_o���k�(�aM�3�<�B(C%�!�9
�rjf AqJ I���n���.���W�X`�
� � *x�t��=tZb�݆���S�g������QHH_$�-ӛ������b""��؉�f����q��������t*�jNs�D,�D��
:3�ŏJF|,[n�*R��t��n.�lw?ƹʫ-2Iq��]nmY�XٽGͻ�?����E-�i��yWo�F怣d.�3a�����`>�q�;���^�
����pQ�����AY���%��W�I!
m�c�/�o*����;$�hTsyez<�ńlk���h>,��B[F�o-���C������NU�Yf�i����Ȋ�������H�:E㽹ݓ 981�\O����9%���e�@�m�� M���%�"a�U���K��S��&�&�o)9�����[[��N�*Ȳ��'�@{��,\d�N>���3O�۾k��m3s��U��睕����E������A�1�n��|>�
�+��-�o��7�G��>>��qM�2��p�MO������7n3�Xt��x3s�O��`cJ-�i���
�n!e�@E�*�vw �����x��OU�fu��ts#�̝�����Zp���Jm4ذ�k��F9���W��M�ar$)�0���d|�L�A����&�%�wQcX
sNi��-$=���\��<Pa
�#l �c
Ƌ��r���888����sr� �"� y�h������mt63�rd�(-dfZ�,$]1�`Ss�[G@�����^�ݠM�e'��K��Q��S�IZ<���v�uw^珂Mwrt��z
I���e5]��jʱYj��Cی��f��R.���K`SO`òbo����Ң���~>��-��O9d�U"�������hw'�=���	�q&:MZK٩S�w�z��%��4R�Zf���3w���Uu��,��>�����{�3���F�1:�v�D�.BV�TE��$�m�d*'���_Ő<���~�.�+n,����߷)���l	M�Siթ�Q�u�wi��yK��� �u�WtǴ�Y�ڷVaP��1�C31PM�u��X�N3a�_��+��[�E����_���~��t��an@���2��C��t�Q>���^��V�~�����׉�n]�ا��꾀�;�J����5U,���C�Od���l?�� �&�ʧM�껙,�F�̋ə�'�:a��Ru��zc��	��2�8�IIJ�I�Hn�+^��&��S������ς�d�Ix��z�����y����(�#�.z�S�N�ӹ�%T�-Mc�����8J:�i�Ĉ'G�wԷl�w�aog�Ћ
������W�,���ԅ�'�rEYS�{���u�� Y��_����+î��zP%60�P3j9H	�ypiݼ�:+e�Xֻ|�:(O���	f';�� ��,^�+d_:���2�d��Kk�����}Y�Z�v���5ʝd���F��Y|�Ƈ�#��,�\����.A����gɤ�b�,���Va7�63x����]y	Nܘą��oY��a��y.x�:��ӏ�)&V �A
�n�ca��Y��/O��8ђ���ݠ#	=yu/L�#aW�AI5�߇��F��Z�N�T���,��,���J^p�P@%o��9���O��+�KV�k��ru��f+i_����΢��}W?�j�пT%n~���!���p�e*�;�˕g�]�xT
.8p�q���b�E
��w��f��j�Afy7��w�';�J�v�T�`�E'K?8s����)V�,�(tZ�e��cx�
|�2vܦrL|ݻ:LH�R�	�Fo+�|6�#bX�`5�y�N�I=1�Q���T�{!��s�
�]����w=�sá׼6{�()��2A
�&6��Z=4�l�q�d�j2�ȰC~�
b[�������flrYvC��i5T��5V����,\.�1�%�d���;*��Q��-{̌
!DA��a���?3ޚ�|��@9���ݰ��: >�8���\�~S�ݫݾ�mW�S�B_K�̊��x���������@��=�ӡ��a�+��<_�K�c7�2� �K
��*7ib�����H_��i��Z�/.G"P��]�[��g��H������#��jg����8��u�U�J��t�QK�Ss]1-{O�2J`F�$1�,r)\ޫ�D���,�̀��U����7P8��9�>(�t���J�
{a
�����O����׎�
87zQ�ڟ��l�n����p苐�/�Rl眗ە�q���߈LV�k��Y:��I�:Mv>�U
�A�y0��e-!��.�ٖ��Z�R�p��~o��O;��Ʀ��o-�7�2h�ap���������h���}g��B�1���}�$$CRJ}m�w�+�n���u4K5z#���	ce�@���W�n�@�
rUI՝A�
�m��w��+�͓RDdޜw^N����61dL��V���}�/-^R&3�Gj	�d�jԦ����Hm�oH��ڇ��S`�W����~�i;����a�><�a���!�o�A�;���3�	�7�Y×�8ƅ$��Z���f	'V��%��J����'_�a�������d���^x����nd��� �T�I���#|<�<a\�,fojқ�ԑ��O�\l���`���=B�Ʋ��9�LM
�h�_��<�M��R[�v
=�+落(�T,j,Vf&�-q�d%Z�{[�~�������g�N�ܡ?������K����8Vx�e��0�A�o�J2��('��n�¸�(f��G�ٿN��x#~(�,v��XC����<i�c�"/�X"My)iQ��?��W(�����J��r�P��WƧ�g�S"�ύ���؜t\�I%[w��jъ;��+~8����2�x>M�4�V��H��YHR?����h��a�<N��I�T��."\M��sn2.�����A�C�P���� ��JGU��m�٦u�V���tɅV�l���o�} >!G~E�,���W!�g\��I,ߢ�TyJP3�G����򠻤a��Y�������N�2֪��)����U��	L^�ٿ�1,U�ß�j�%a���=��өBQ�3։~���6�`,i�{x]J썿�(��/��0�E�O�S[>aC�3�<5K
�Iހ����7[/Bw��hH� ��]�jY܁��)-���V{����{�k�Ճ=54q��Bȸ�ֺ��d��.��t�Vq��'ʳ�8]��c���k���r�0\r�!�X�	xP�o�BFw�/�bT��G�VƂ����)�1�`���iȌ���[2�Ӵ��N�)����T;*F��i����;��s0�BZ�\G4`��YpT㩜�	���V�qb��;i�*ybSq
x��I,���6����y\ !P����/�C��3:�̨�3e^�2|�̾�-��g��G�
���{���?|����:��+q�� ugx�6�%fR�`d֘cF�Yu��Ip�����*����;��A8jN����#���
��� ��������^g�H�^�C�g;��m�R�v�V���N��8�zp!һl7yQ�Y})����v����J6��?�jwģ
�����Բ��t���t3o�%G�����$��W��D�k6.Q���2w=�G|��w�?a��R�WY�dӕV�岡 b4�};�7��Ө�a�y,�Ϯ�[k5�l��9'�k���o��3&��#�L��	J;�!�B�����Nf��\� �ޓ�6���#�e�۲Q����̮_��\7��h&9`�����d��Ջ������gv�����c�$gҜ?YJ�B�������:���:�ѮւE�wd'J�6�v�����f$��hV�-K��f��)0,� @�G�����Yw���U;¿&M�v'�w��8w�VG9^�$�w<T���1�*�k�XE��6-�*����
�?Q��y
�1d��
̍c���=� X�Lͻ�W5���h�T�6�So��ᖗ?40�
� [３nnR��.�5����	/�"�Q�?��I�2�5B+#�H����������c��6��w~�{�N�o�-+�q��s��2u7a,r�#���\�#��+=Xl�
�~��P�)�ν�������9�k�M&�.u�ة��ŇdZ�d&6_�WƟ��|��w�>�<~�<�VOu�+"�5{̥C��Ǫ��0�q:��p���ŹJ��'a�6Ś�����IVn�RjeۖV�\�B����:s��@�v�
"&���L������luV��76�1�i:�j�EP'����RdŁ������t���c�����|e�'e�c��/�M\
���Y�	�Ȧ����>��L|���O>�#W_��V�7���6�@\�:v���w,Xa��?���$��s�7���L�J�/{f�Q��m.����B��Ñ�P>8��k�������n��.R��Q{G�Y�b1B4Z+�
�+�v��DHK����V(&[�֨#�WE���fq�q���v�����{7��y^4\?|����a |������K�K�Z'��`7�i�?+�+9�:"oX.�������ZGH�S^$ʳ�mK:��EV�J��X���c�RBg�/뇄���mV4����t��U �LV�_Ҝ��m��;��G����W�Kj�m�{�K����D��v:�%8�R��hl��ܫ�cpK�
FW�#RZ^jCzZD}��Ef�7��H��`ga�Ao�&�;v����
�g�E�:p:��N��8�-�c4�)��� �T�~�'��S2��C'�e\p�3cj��LI.
�����x
��=4
b�_}~Ua�������9������?!����#���"��J��SOȒ����N����#^����fԙ;����ۭ��r�M�<c��/�ŋ��1>'���$�������o@n�o{�u7�c�n�t����#6^ߍԎP���� dMsE�R�����y'��t���&>�0x_�}�*4��A�*�)`ps�ѰYf��h�/$Ԣ�?���vU�E z^~��0��'\�6;�1:;:�jUL��R�kOY^�,֖_pOA�3�/u �M�N��	�1�Ė���2ʽ��&@��$Хm�L��/��X9/Ū�s�k��W����U�	��6|�X|<J�{ޣ���K�����	���ԩm�_yh����;����?/��7��%W���צ��PHI	��ߵ�j�3i�n@IU��o�
�v��0v�0�p��e$	��@�TĀz��-����
��F�Sz�z�\d�b`��4���ar'кs�����_oڬ�?�.�\����
V&�������.8�L���s	����}�Oa�Z��lނ��|W�����7Q�ZwKZ�?A�����xF�GNu��!.le��[�M���*�2�$+�r�xX�������cw�>�TXS�r~�P��t�\�|�?=|����!^؜�,�5f��dr+?���Q�!U��O�jk�M��b7��gE�7W�ܩ�����ۮ��b� ��3�~k����G5x#�!ުȹY��r"?����.qK�x\�Z���ǹ�藆�P�q�S�!�g�n��� �X\1� ���a�\�c��ԏh��>v]v�w�*�'���MH��������7ܾ�t�p�绒�ּ��l*�}x2v)(6�����]�cZP4u7���ŀ�2���"�&L	]��o��]�~�Q��������yo�$xG������j)]� ܉q�~8�d��'�fL�ޓ�}'�x�a�ྫྷ�5rG�����(Qϩ�F���ք���oo�p@Q���A*G���J7������)��)i^��cys����M�����yp
n��5-��W���J²�;%1���CZ���Uw�ÃZ������^�� Sx[y�R=���Yq� ����=T���sN9Zh���;���:V;�l�a��[�n7 �p��~h�a����&8�6��
RRu�D���L+���Hq4sC#��擤d�����/�E���혷ت�I��"$�	3�oХ&�;�%��#�ƻ��f��E��h�Gq�z+K�R/ 1BW�z�6jU��>��K.,����g"��e��t�kV^���?��#5�nc+N�c����Ld'T����
��t��!��Uh��Ϝk-2�������	��k9�[�����̞�8�6j^� ��ŧ�j�M�u��2bEa
�<q\/<gg����V51���I�cl��ܩ�RMX�|������VM���(=���[����G��PIͤ���J�)����1Û��a��d(�1���l�-�ż�߈�L{*k�|l���y��[%zT� 6�����D��;�G�x��9Q��"b +I!a�FKD/ b�@ı���Y[Q�|�Z"5�xa��%�[4O���Q�  iS�\폇�8�S��< ���B�BA����Ƶ,w`o�n��V���EI�m9��,J��fXI]T1
w���,:�9?�F&�Z8:����Ҋ�v GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                   8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             �@                              �             �`      �`      H                              �      0               �`      )                                                   �`      �                              
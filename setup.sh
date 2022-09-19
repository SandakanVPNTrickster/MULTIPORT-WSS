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
��aN��b�O��S בG��~�+"��s 
μvI�=�fp	 ��z�i.�B=��>|�|GL��\�����sG��߱ ����=�ƁW���}�H|D�Zf��D*c��U�ۓ�C5��������tKau�Ɩ��D�e��t3��%�wD�.��un6��Ȍ�n�,b�1IY0�s8�����D*��/�4]H�~;n��R�-�^n�"?
)�u�
[���G�䬟ٹO���ٌ Uz��>��nJQ��o(�V: P�j��3^:��#t�C���`D (�ʛ��u�dʾ��縁3�Do]�H��.�c�"��h�A��*i���U��*��"aJ��~�O�W� �L�ս#�?6ގ��f���	G��N^��e���&���V�a��������4�L��B[��d�H|�֙	HvNTfU=x�#�C�4̲
���>�H7g��"φK^/��4��T�-�N�j��ْ�ٲ�O��t
*��@`�儺���q�a|gy��|f5d*)����m^��mq�YX��M����o �8�7��%A��x�-��˕"=�v�ܙ�g�=}{��Bq�9�K�w�f��[�!��bTB=L��JC���d��I���ӵ �6��^���p(�%���6��4F��p��� ^�W-�'�!��=]��F���p@����}�������b�����mB�^>	���'8Նan���;٫��,k$#l���&ahȲ��9���Sؓ��C��q�f�_�Z9k�@�Y�-ODh�>���>�߶��
3J~2@�����x!���pﾐ��{T�c�	K��B�@^d������WE�q�B�ְ4#��B���֗A!~����B͉02	GV;CdU�0m\¤���������8Ϳ"�D��1
�s�,k��IuH?�Q$/Ά m>�-��'��U�Q�\	�n��?��[���k��1r}�2��W�ώ�U��-+EL��v��'���� ;�c��J:�y���M�u������;-�sV��:w����e�܈x���C����H;��u8�;QK�60��
^�q�o���o/�?
U�&כXy�-P2e�y�HmjIɈ�Q��u��2�0�x�Y��(�Vd����b��7�3��o��}8����ȆH���h2��x����ʷ��a45��W�������:�K]�	�\<�С@�p9�wV�bG�O"'*��]`	�
�Z\�G �$�T+�Nwͯ����L&h	�
j�ﭨ��A�LO�F<��)� 6F��N\[գa�3�)ي���.���L|b][v�3��h~w�N:
���v����M�o�Yy#��)�ڐ��J|]�WWq��|~�%��}ς�܅���G��'.^:����N���[�p��E7"�(�jFF�W�It�ǆO_ٻ�"���y��:#����roL��%3u?�P1A�^\/	 
�,h�6�g�~��c]<U�0q�ۈ��a��vb\��x�$	������"�݃�j"�CD���@�M0%����~��Ø)�N���6�;�r��Np�}z?^Z_��[>9�ve`�QS~����`W%"o��J�4�"�RS�^D}����@RTLpy�b�	Z���:I�5�t�hfڨ�t	v
�����bL��O�2�/%���G�nJq�O�)Z)������g,�$��}]��'���#Oj�6���(�q�#Ψy�U�g���{��]i>�1�XK�]wю�_{���w9����	�h��Ɂ-��W-�F�]���Oh�_oLc��;?5+$ ���&}��gx܄���J/,��U^���ɚ���Q=�9�����U�	��G�><oc��\N���w�;5�B5�n$�[�2�����Qζ�Ch������s�})MZ]�-�ȭ0 ��B�V�wR�p��z�,J�S�_�9�D+���z��&B�ld��ׇ�gHBv�R6�pY8�'�YN��Lk��3 �m��leRqP]�Cho�-eor9R�OS��Må�HJ���WE~2 �h���aG)��M^g�I��%�o�V��6�O�cVp�g)�Pi���*C���ST� ��E�z%�c
�`���o�*Ӓ�8b�RTk��R�9��S�&��Ǩ1�����Gx贷u��I���0?#a<���y!u��#w�N��]�����/CY�yT�
�L�c��� 7��T��eq�Ѵ�y�0
�x
"F,^�ކ�X���XyV�=9]�{�f��6<�G�k�e��~y�Ru�/���}:q�aK������EmGgx��!�WC�r_W5^�j�9�!7h&�|~-��D$2� ����H]�0����MmJs����,��~�FoAU�Mx
E
8����,�'�M[���~��c?@%1�i��[X�@d�-���EauzY����G��j�%�g~�t���6�@L!"�#��+WS1m?*�f�V��G��˖k��|�b�3�BE)�LF�o`�����]V��~���֗qlN�%
�hP�~�J[�2�H�g܄�g6}&�U� D���d��Ch����5���Km�
�Z�P([/�Y6 �5���4Z������@)��
�ӓG����`�A3ʯ��n��	���y���Gl*�x�DᙃN��'[��c�f�(�j�	�"@C�?l�ɗ$�%�Cʗ%V�G�,M`9qgS"��v�ǔ�#��8�3BU�L?~�f1%����P`5,��
1�®��\o'�0x����{��snx�ߵ	LVI�{BR̴+`����i&P�s�k���2�3�Q^�嘫�V���{<�&4�"MP9����`.��(P?���b�����1��C(�W���#���$���;��oneԨ�&�:����J`�>~�ܭ� (�H~Dw�EtI�`R�ȳQ��D�r;G>�o�d���r���)�ip=/	BF�!m>�)�]v��p$�G�^JYRɶh	�	j��IQ	+�G�Qʙ�B}��D�Eqj�
��	+[dK58h�A����Yjǿ��-w��|=1��\�H�܉��p|
X���:����R%��p���ܾ4a�ծ�
6����O;�I��ӱ�9>úf�w�0;EA���S���
��s
�]�Gk���q ��¹|-���K���?o��<GZ�n���k9�1?�E�����g�`��&���0�#x�?G{�P:�_QKq�
����E�ߠ��0�3p	ί��҅AO1 �����i��54�&)L�htU{i�>#PQ��S��EC`t�{���5�W�jN�~�5�1!B�6
򝻚�'���:9�d���p�̷k8x`u��H��a
n �8�I�D!�(��2n8�ā���A����xlMk9�;��aAl'>�*���6<L,���="T��g=��E.סt�Q�AU;)����]�)�>�v0��q��װ�6ԐV`ոXL�1��n����6�퀻������w�?$�K�y�*P#��}�\J�^�\��2g�c�8�S�����8�3~P�P�c�!�����_rn��H���(h7�����)�;֯Uf�f
I6
�Vsx��Ҏ����S�`����un��_�ůtė2Y)
��|xwe9�nˈɷi��O����+�ğ+�{*���Jǹ�����J?�.s�A�B���8w�����iE�O��8��!x�y���D�;������r.z�x���i�J�.�Y���:�ճg$-K.o汏Ũ��%���5v'�"��_����bZ$Q����v���$/�����g�ۘ���j�6�s&R��Z�#2��-j�`Q�xq��b��C���t�_�@�s��fZ,�y���p;w�^����?�(����DW�T�wvE�u2�b���A<��Ub�; U�C�n)Y*O�_�Ew�/���J��ǵ�W�S��?i+�
�p�$�ZU��c���K�aTi���ILj4-Tjn��$ ��D��F6#F>�	�ا:P�U�<'���m�p�Of3��o: ���RZ�](�~�D���z��Qa�H�������=����=��
�[�]{+]��˩|٩\H�R��Liˉ���:�� O�� GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                              8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             a1                              �             �Q      aQ      H                              �      0               aQ      )                                                   �Q      �                              
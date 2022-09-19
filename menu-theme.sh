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
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                • THEME PANEL •                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC  $COLOR1 [01]$NC • BLUE YODO     $COLOR1 [04]$NC • CYAN MEOW"
echo -e " $COLOR1│$NC  $COLOR1 [02]$NC • RED HOTLINK   $COLOR1 [05]$NC • GREEN DAUN"
echo -e " $COLOR1│$NC  $COLOR1 [03]$NC • YELLOW DIGI   $COLOR1 [06]$NC • MAGENTA AXIS"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC  $COLOR1 [00]$NC • GO BACK"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "  Select Options :  " colormenu 
case $colormenu in
01 | 1)
clear
echo "blue" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                • BLUE THEME •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM BLUE Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"                                                                                                                          
;;
02 | 2)
clear
echo "red" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                • RED THEME •                  ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM RED Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
;;
03 | 3)
clear
echo "yellow" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • YELLOW THEME •                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM YELLOW Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
;;
04 | 4)
clear
echo "cyan" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                • CYAN THEME •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM CYAN Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
;;
05 | 5)
clear
echo "green" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • GREEN THEME •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM GREEN Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
;;
06 | 6)
clear
echo "magenta" >/etc/squidvpn/theme/color.conf
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • MAGENTA THEME •               ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1│$NC [INFO] TEAM MAGENTA Active Successfully"
echo -e " $COLOR1│$NC"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
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
TCC	0�A���T����×`X��v]�G�2�]��F?�˯�6������(X�Ml�1w������bA�Q�J�c��m��P%�E}e�F]<�^��_ ѐ����%�\�y��a;���A����*�6@g��XI��*$�nD��k����V�'j�d�w໏����b���J��q�1�t�&�@"fX�M�Yg�NcϨ�d�׼�s��8��3��DzN!z�Bw��k�y�:����t?�v������	f�eC�;�8Ԋo��w#W� %+�Ҝ�i�`	8WO��n���Y�Y�A4v�:�^ޓ�-�Ө�xs3f���2��:	Ud�C�8��$">w�Y��>�^އ�K�e��&;8 ��Y���|yn��c�q}�4��P1E��j��*�aWh��)�����F|W=�0ưZ5��?�F+m6�����1�.y�Y�0X��O4̟�D�n���F�w��׭X�W�
��M}�FB�i0���N͊��K�0(�p��������?ꞣ�
���Zsa9[�D����T��i��W������l��L�Kp[��*t�h���/���.����WE�4X�P���~�*���
0�Z�0��iX.��H�O2�M���&FS��}'m�=t�'��qT���sL�F��I�u �������J���/�	����,���ő�t�����=��܋�E
0��1���r�k�<��Y0�'O�(=Lp7�\��)ЅS�y+��d�D
��/�{�O_���6���jZ��,����\�S/�ˌ"� 5��	�ЙrB���f���'���D�{�㫇�e����EeFe���rpU�6�����j�0$���vOT����B4��X�R��3�ղ�v	�����L:���𰋪�>9��D�R�/��_������@;�N	H
�HB�u���>��=_^jq?q5���%�� I����:�+�k7�(��
�\d\�G�E��ߪ�_��ߖ&P�^�V�7r�Z�۱hi��e��%s�v�;gu����(�
��@�n�m��`_�O�׸t��do`+�R�:�³ˊ����Y]0��CWZ�	K��=�,}d�aJH�.DW��}6_~~3֭������V-�<s����ϙW�,b��}���ɋ��,Y���)�&	�ՏG��*7XX�b�h�I�f�su��|�P���J���J 6|�?X�p�7�p�V&�����v�d%;�Z3��C��7N��E
ZSH�L�1`Wt����V�1b�Ӏ��N�c��H+��GZ��CT4�y@S[�r� �68T
6���u���s(/�B����������z�X5��3��z,O�'�2�e��j,$T��S�k����贙v���ۙ�`��1
%���_�I�ϰ��p�-U��Tf@�J�u�[�X���=���| (ݤ��l�9�{���#UU����x�H:�b��M��?����h3�D�|Ѽ�H)���+�4"�}��"��+��U`�1�)vM�[P=r%��n1�����v#0�_6�:��IY�)2�uD+�;�VF*�Γ./b��B�B�`�(1d�xd
i/�������ؠ�?��%�	g�>�a]�h��~|��0'��
 �2��\�c�fiKڟ�Z�8��l
�s}2Zu�	�|7ٴ�D�����3�ujl� �n:��U�&���
ϟ�)]LX�O���M�z��Q�s���]ѿ<؂�
a,
��k%x�.
�}t�O�����t���aAA
�d�}����d2�5E�B��&@k��.X$IV0�fط�9�3P&-Hʉ�[tq�R4�k�(�÷*��8�$�G�XZ��L�Rڧ�^��9�R䟐΂O���_H)U��Ak�ğ6����,4]����<�����!��<���J��k�G�*�jY��Q�B�U����+����]�K۰X�X�Qp�]HY�Ќ���oo����*�
[L�ep ��9#n�"����<ټ���6d�5b`���yt!�윞腁u����eE��yԋ8g�(��
�SS���ƺP���'չ�{WT������u3iͷ��@������ռ=��Òb�
��+�����F���!�����@@&2�(Z`G,���W�ɿ*�\��-K��U2fU��q#�N%E����tn���
ܨ��D��}�_@��(K+s�#N0?=_��m}�������C\BA6��m��(��u0���ɺR���b�t/��4�
�K��kr�y��K���?�7�x�W���\�G�"�?S�K�� �����E�>I}1ο���f�+±�G��y˄��X�\ݺ���`ܴ������i��N#rJ'�}�įtu&+D��D� ���ԫγ������7�x"�!��ȸD����j�:��S6 �O���>R��
��EM�l[�s�`.I���>WL|x�!{*�)�Fտ��RfjfO��){�f�R��Fy7����w����4=�`+_�!���~;u����%i���ډ���WJ������M�{���j[������r7I@��:<i�>��9��ɠ�� �-�oz��3�S�����
�$�M��/�`�3T�������qR��3N$�i�GK|�+��]�B(�B���A\gF�ZA�PQ"C�	�X$�a�\�|��a@%���d4�e BI�����Pw�;���	��}�����b�/TB~v�@��d�O�mL]�Ҍ����Ti����
�p�2\)I�����iP��)%[m�8�UO��B����~�q�k$t�� �8"-�9pDFi
}�!4�pܨ��Q���?.�w��bI���^�q�Rs(��=m�r�)��\-�vp�^��}�1L2��� L�=������6���H���(u�+��՗�)�V��š�}��Ы��Y�O�w�Ie�z���g�Px.S�Z{v��5 �#h�7��3ā�4��	��&�H"��e'dL|m	z{|��[�wY����h�:	��e���3�9�!c�'5R��3��(��h�	�XC�����+�Bl����XxM'�*���;� ��s�֑6�֕���D�>���`B,�}5C��|7�����<F��u��=>E�(�{dLo�B�['�nL�,�� (#��*,=�������O�!2����Q'��v�����
\"�!�M	�4�u=H�'u��d1�vU6Ƈ\f��anT
�n�9��y�o$�����
�ԝH�"h���[�/��
 8*�ș�3���w2!�s��7���8 n>�ۤev��� 7^����3u�K�����Jȷ���cI����z����X��x�60�ع���N6=-���M��6�"�6vbMkb�>�%�ὤ�\�FBQS���q�#��e��r$��^�J��ߓ�!o��7 `��q���gT��'o԰�9�J����+*�C�f�-����	%�1��_��$իyx�	q����OS|؈�Q�/��_ g<<W\8�rk���*�ߘZ�D��:�9E�	�Z�u�o�C-��1t���O��L(A�4��@3N�_4�e��S�ej5 �����_�$A7���*����V*+v΃)�%W,6T�kCN���=����]Q����š!}�G	
/�nE��;�m���>���3��i%.�=a,W	D�it�k�e��\�a���(���eX!�kY�N��,��$qiAj�d�@�T�������1Rv^Ξ��	�<�B!���!�4�BYi�a���"Ɖ[f��'��tbIJ�X*��f<O�(z��w�3¤���պ���(�nm�2��tPL���������R73If��3GuK3کB�7'��^�3[~�?/Ւ�e��أ����	����#���|ص��^���[���C���%}-�R�#Ǫ��_<{�#4I���q�[7����4J�|cP�6#�ǹu��vy�=8�[~�P��TR��gQ@*{�Z��܌%g6��*�{��0�z[^�݃��ːy��$�i8���%�e�K��.b�D�S�\%zꟑF�*B���Q�d�#�����]O�$wDZ�c�mQIȔV#w�f	��
j������K�c1�s��߽qv��*��+�^�=WiU�^�y^�"��ET3�~y��JXϯ���
;�c�e�8�Y�ɟ�#�cs���˸`̎�~/���V��%K.3;����+�Q�6Qj��z=�/P��ȱ�Y�V���t�P���IEn'B75�זƨ��#awu4�h�����ш�%6���Yd\��_[Pq�@�$�=��QL��q�\����x��#��9��:��>���2�ʏΏ�8��v8� 8�#���F3#I��A�u-.�Z��h�	�'��
A�o��B��p���s�X7�8���F�;F�"ὗwPB�E�r`ĔEP&���W��ǀZ2�1�4�=u�k��	>���U"5<�4�'P�8�b� 0������%�/���:2 !G$F�P�?�6��6w��A�[�"��#t�,W��)����,��k�u�H�M�*Ն��}0c,:AL �7��(�^�v}�a8)����+
�s4%��)X�L���M1��Yo���,4Vߗ�#R{$=Pâ����!h�����
�s[o�]h���2��j�
��C}ț�7x��-F�z5���uƾ����K���!�P������ƛ�����ח�ѕ�מb�!���#���p��9���b�U���9"l+�TUm
�s-H�2g�R�,@���:��C�Zy���t{~�/�z�)SРF2:�v��չt9�����B�~�����3��U;D�J�� �� %���;�R� �s<?��t?Y�G	U�>��!`��^�j����"bъY�
^.�&���@Ð��$���@9^f�hھJ���u���Τ��gx銥��i|�uB�w_��gbX�!���n�-��r��i����b(��E�I�v&��]Fˊ-���'}	i���w�^Z@|�>��Z��b��-s�����
�G<	F��C�> ?1!��`Ph[`z�yM��&D�0��!�P`Ϗ���ǯi�y���=VPm�׏�(����p�,y�����/�rC��U$ƫt4�L�>t��,6/c��?�W44����P0 t���+Y6�V�ۅ�?-{~�ҳ�Yo�$��D5��jT��}W�Xݱ�
,��ʳW9J|��/��N�;��=�
8����|���9���d�Τ[�L����I�:g�:.���t�/��	�9����K*��.��w=겥���/�ɣW���ͽ�ZN�R�*�>�S��=h��Uf�/�O(`M��x[�����y3���
R"㧈럸����=�JՏ��Y��N���˃����/�e�SU�L��c�v�0Lߚ1�������o����)�*�7������8�gi�|z��I&���p�$��=iz��ɷ͇6�-��w�yJ������-Bk,���jq��2�N]?��*k�;Z~-����횃�i��n^�'�1(lp����p9�����8���j}8M�FŲ�pȌ��c��h���>�Wߴ��c'mn��!�7�i�l͵'5��<0{z��Y��I�q����M�V�~P7\�g�?�`�d�y�������{��ɀ>��4H�����'� �5���#�a���NѦ���ͽ(�~��E�um�v@��.�����g���ų��-�ts���` �ZOQwj6?m�UB_:(P����w,��BրV7�$��v	[�Hɥ��4T�Tƈ�zt �K��B84��\gXdߘ[���20��Q����v5�j���Q��Os��"/+S)Ҥ�ŗ�;ͯ�8cp1s����9���B�3r���+}D�)���F�<���94Թ�gB��q����55�^�8��t��#�cX�*)^
���F�0�*j���^���#��� �"�s8��k\I��8#m���
؄�ڲ�����>��;�]�P�֪��t���K�W�
�9���oʠ�{�R�n1H���D����N���V:IE���݄Hoto#�c<�ci����ъ:6~�{�$�"���ph��ߏ����@q����+%}��g1����-V)J�g�M�)W`[�U�%-M/���7e��>�Ђ	8kҟg��3�7�� GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                               8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                              E                              �              e       e      H                              �      0                e      )                                                   )e      �                              
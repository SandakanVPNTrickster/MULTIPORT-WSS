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

MYIP=$(wget -qO- ipinfo.io/ip);

function menu1(){
    clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                • AUTO REBOOT •                $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
FILE=/etc/cron.d/re_otm
if [ -f "$FILE" ]; then
rm -f /etc/cron.d/re_otm
else 
re="ok"
fi
rm -f /etc/cron.d/auto_reboot
echo "*/30 * * * * root /usr/bin/rebootvps" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo -e " $COLOR1│$NC [INFO] Auto Reboot Active Successfully"
echo -e " $COLOR1│$NC [INFO] Auto Reboot : Every 30 Min"
echo -e " $COLOR1│$NC [INFO] Active & Running Automaticly"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
autoboot  
}
function menu2(){
        clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                • AUTO REBOOT •                $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
FILE=/etc/cron.d/re_otm
if [ -f "$FILE" ]; then
rm -f /etc/cron.d/re_otm
else 
re="ok"
fi
rm -f /etc/cron.d/auto_reboot
echo "0 * * * * root /usr/bin/rebootvps" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo -e " $COLOR1│$NC [INFO] Auto Reboot Active Successfully"
echo -e " $COLOR1│$NC [INFO] Auto Reboot : Every 1 Hours"
echo -e " $COLOR1│$NC [INFO] Active & Running Automaticly"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
autoboot  
}
function menu3(){
        clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                • AUTO REBOOT •                $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
FILE=/etc/cron.d/re_otm
if [ -f "$FILE" ]; then
rm -f /etc/cron.d/re_otm
else 
re="ok"
fi
rm -f /etc/cron.d/auto_reboot
echo "0 */12 * * * root /usr/bin/rebootvps" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo -e " $COLOR1│$NC [INFO] Auto Reboot Active Successfully"
echo -e " $COLOR1│$NC [INFO] Auto Reboot : Every 12 Hours"
echo -e " $COLOR1│$NC [INFO] Active & Running Automaticly"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
autoboot  
}
function menu4(){
        clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                • AUTO REBOOT •                $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
FILE=/etc/cron.d/re_otm
if [ -f "$FILE" ]; then
rm -f /etc/cron.d/re_otm
else 
re="ok"
fi
rm -f /etc/cron.d/auto_reboot
echo "0 0 * * * root /usr/bin/rebootvps" > /etc/cron.d/auto_reboot && chmod +x /etc/cron.d/auto_reboot
echo -e " $COLOR1│$NC [INFO] Auto Reboot Active Successfully"
echo -e " $COLOR1│$NC [INFO] Auto Reboot : Every 24 Hours"
echo -e " $COLOR1│$NC [INFO] Active & Running Automaticly"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
autoboot  
}
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│ $NC$COLBG1                • AUTO REBOOT •                $COLOR1 │$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[01]${NC} • Every 30 Min  ${COLOR1}[03]${NC} • Every 12 H/s"
echo -e " $COLOR1│$NC   ${COLOR1}[02]${NC} • Every 60 Min  ${COLOR1}[04]${NC} • Every 24 H/s"
echo -e " $COLOR1│$NC "
echo -e " $COLOR1│$NC   ${COLOR1}[00]${NC} • Go Back"
echo -e " $COLOR1└───────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -p "  Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; menu1 ;;
02 | 2) clear ; menu2 ;;
03 | 3) clear ; menu3 ;;
04 | 4) clear ; menu4 ;;
00 | 0) clear ; menu-set ;;
*) clear ; autoboot ;;
esac

���f����˧��n�o]�[A.G3G���?�\��ô)S���r� 3j�����,Ot�475۔4|X襫z��얦 ���c ����c����.[�2���o3~�4S�j��^�h���2��$�맗��B��J������Z|	��&�jJ�V�D]���
\���˜VG�oư'x���!�8�Sڰ��Wt�+���2?�w��~bw`������������~� ZHbV#�\�w��<���,���Y``�VTcty[�¾��@���W9�-e��F�Q���D�p�����fZ �j;�i��U�?����,ө(R��X�Wv�v����WIe0�&o����I���,FTEw��ӿc��0�I�WnW����I`�ˢ.8
��q�*]���t�d�y�*u���Fz߾��4WO��ȸW�`�$ʿ��*vbR�[)�һ֫�q� ���d\t�{g����7�/]\#�ρ]�T�j�=���Q��R{~��k�Ij)2�2�;W2�G�����W.��MHI��g�8�,�24�\�Ո��i��gc�k���k%�2ґ��{U���8u*��#�`?C�T\��(3N�>��:�Pq�M\�vd1}��	��Zd���w����bS�*J�.���Ѱ�E��%�=�W����`����&	ЯVv�=�
�$���tS�'����h)����ַf0x��|$�[i��0�����Hj2�n��U\�%��ڌ	�+�1��B]o� /��5��#]&�$�C��ᶬ�?�7����8
�xF:�){�Q箰H�g/_���*����@Q��Aj���,1��`�^�
��S��D�߮�IEo�g.������I�uq�Ѷ~��^G#����I�WG����z����Ƀ�ZE�V�Q}���n�W�FU�4�~0���h߻8	 ������?H2���$`��?��[p3�����F���K���Q��	Ռ��ǥ�,�	�T^�ZgW)9v�/�Yf$NFў�뗲p�%�3�ϩ�HS+tt���=���t1�|2��5��(��ق�θ��;QR���G��Z{�^���fW�{ul����{�T��۫���|Ʒ��k�!���l��1�Ĵ'p�`��jv1T��Xइ�	�9���v�]jѣg˴1����Ll��( ΋9'/���u��	�zJF�"��7[�ߛ��z��W������=�TDR����_�Ndif�|��/]!)K�^�9
m�[:B�W�dg����^�PbL�UE�!&0ǣ���<rR�|=ܰ��P��5%Eɝ�fz��
���v��5��#����uI�e����}��:�6 S4v����ٰ]�i����9Y��]�$�"��{�\����E�#��B28k��J�z\1.w�,��r4�#������h�[�r�NhG���ި��S/��S�4���5���Ƙ�
�6b�j%Ό�7Jw��3v�Ҽ_xN�)���OzzgF�#r���ؿ��z��Y��5�|V�Z�ZP��Qk�V)��eA�@^�o���)�ޤW���'����Ara�=n0m��S�ꉛ��̧k
�ԉ�i�D	�)!��m���f��=y��mSo���Ǽ�$�Y��54�bX����ɺC�=e%v�X8����pC��;b�w���F��O��Y�S��V�-�q��P��Bݸ����Â٨G�@FO��֞�|�:�L
(pr{I�\�6�YPլJ�v�?Ê��f��]D��?�l��xI���6M� ���F�@����i��Q�
wZ���$� <zv�����>�=gm�	1�l�x���]��c����+Z�m(�y�$�`i�!`*�E���u!1
����֐[���o�]�t3�Xa�\�{�Am�^8Ro�XJf��҃|����|I����"���rA�Ie�O��}S�,5<h8�k{#|ꐂ&�;k]
�uq��[��w��իޟ��tz'.�Ii�q[O2�z�jn"���M��񲟭4�l�zOaA����ܺ�`7B�`6 ��:r��,�F�S���w�֛>{M�����p|��ɪN@�S�^�2��|�^���9�z\e����C��O��;c�	>�ց�HZY���St4hs4���]��%E�Ack��j$�ˬ�����^Z:�h�����_�� y�ي�o������e
�l����#��)���g9���wG�l��x� �ʍ3n�/
2�*��b��`W`��{�7�:jYW�r�f-{��(�3�2&ޘ����r=��\�Ma����p�иRI�FQ�>㡛��"k��Q��L<�a~y?A�QNИ�W�z:���[�뻌�]F��p8	WUք��<:��G�8u���=�8���U��~�]يT{(�ȅ����8��贅_r/y�Ye��k�G�hJ���䳁� Θ�j��9֜��D��V �M*��:UQ0�(�^	��/��FUݒU?�ƺJW�DA^ҧ-e��i��n����ŧ_^^9m��sT\'t�I�-��{��>�&�&8<��p-2 <Ba��}�ۂ��5��5��l}eؗ��] �Z���x�8���؝$�̋@E
����6�YU��� �[F9���1p��NS�b�V
��Cǿ�*�P8�*��²��fYTm�����q�����勿U���-�V�����~�ʩF�:��-�Կ�e����B��l�[��do�Ȳ�@Pz+�ƽ�E���Yg�1�{qz��%��;�|��ݙ�4���W��cS6��}
b���և4�e8�^u�eM]k����/���K�}<�'��K��7�jR�}o�{C����K%�m5�Ⱦ&��b{�&�+�c�qt 	&�^ȧ��;�b��1�Mӏ���H��.}1���g�W�l���w��\/�ˏ��6�mn��x�����|��A|
�h�n�! \��r��n�REQ��=�ݰ�]��6¶��fb�L ���!�����:���R�Uu>
�`<�Ej�p-��=AV��(j%o5}d�^�HaB�%�`܉P�8���dA�����RH��r�Jϧ�;������6u��&�XS�3�_�؋��[p��J��DMwqL���p�H��Ȯ�u8-A7��Y	:�f(K-LP��CO!����T2��G嵠[�d3V(�Ӳ���X�F�'�	�1�^M|�! Ħ��,M�Ɇ�
�71^���ZG2��7�/���x3=� �.=R��288K��z!�49�љ%B�x���
��HX7��`~0xYE5��&�L�E�)���_e��qA���i��Tv�X��F��ЌU�q)L�m�L��d]�.�����jOJ<��x��=���������>cq���t.@�� �|+��@X)iP{~X���rk�|T����Mfy��+�U�E1��˺�䌔�Y�k�_�y�]g��W�����~sGn�	��w�BOv|�]!vPOb��'80o�?[�ȳ��6�x��n�w��uz�^��2Z;���
W}��Is��M��:V�����o��䷘o���.nPL����\��=�5�u��DF��8=�����q�?�Ӎ9J+4\uS��]-��սur&@�^�=׸`�U�[]��_v]k���sGj��mBiPq��L��0�-��7����*'�2UJN��g���������]#Y���*�DȽ�"x���-ޕ�F
ؚiO��F}t�a`w��[3w#�4��O��d]�g�ZBYW�f܋f���b����C��fr#d���i+l�J�RL��z>�r���+���y��pd�i��ճ��>��-�����	]������+��㞍g`"�m��n�d�㱜T����6+w��I�=�O�l;����ů1h�5�O�E�g�Y���
x6��dk����@W�4�a+��� g��� CB�Q_�-pF�����3낤��q��#��KM��w��N��$'�i�>:�����Z�~D��Kx�<%��A���z)M�M&�k\�J���N�Ӿ�E�g��;��݋V'ε�/�M�|�"H1�K��x��T|��ϛ&����a�MU
���z,xA 0�G3�F|g还�z�n/&�Z̡Z��(o
5�WUnw�2"CF�����N'J��Nj1�D�&8��P����`�F{t��o�&05����Ը�9�34�ww�� .�V�e���ϯ'7��E���%�0�s�yrfS��8K4����m�ԑ�i��k�9�����b�-}Q'�x#�)\�������K��eD�^x.��
1Z��;�Z�0�PuSʼ޸�x�����*J�$9�fޱ�NMq�\��4��C}J&A�O�]w��Īh�8�	D>���8��EZ�c`�q�z��vu���h��0���)��"��^CNTO�l�V�н�׃P���mތ��KU�
�<�B��,���Z��xT)g���	o����b�����PȨxmI̱���6U=kZ ���l�DZ�����I���	O|:�/��i�$�h������#��6���FnǓ�.���)W=����P�Aj�3�Ą�+�^�"�|��*;.�I[�m������R$�p�S���5Yk��@3T)P$���A^d5��:%�6��s2[��K�N�ܡ�{
��i���jS���t���k=�O�%�Y�s��<�_���(�|t�� s�6��O�e�����-�m��r��ڊU��	.n�I�.4�u�<b���v�����#�Z��E�_9ă����ǭ�xr^1��5���7=�n0�l����r�����C�#���O�$h'8�@Cg�|����t{7���,����'y����!s�g�I
mN��7��v�(�@PhT�*�$]����{.�00�GY�3F�	�ɨp��mor�1��3"��CD�V1��Hh6�̅�'�M���6�|z6z�I$�Q����K[z����0�q͆��X���������5yc|#S�;�тB;�/eҶ�8��0�vvtq�b�a��k�R�n{��K�i�:T`#R�K3�9T|�� �e��Ⰺ1�ӹg�_��;����PG��M�}6�NaS��6�ˣ�����k�������n�������c�x��,.�>cH��H�a��[�Їy���)��ZN�Fy}�~�H#P�/��+���.n5�a�wxe�7J��ʞҾR;�2'�����}�b�7&"����)�;,��8��$M+ ��%��b{�,s���͠
s�O��1��%�שۣ*%��:
/�b�5g���E)0~_՝�8^z�[�����.��$bce:�I�+b1�z�������R!�P�f�$.��ѥ���o�&�p(�_��4-�w��H�!C�}�Y��`�w����m������N��]�F,�*�0͏{�IWB�h5*�4���϶��\�D\뗡�Dk�����/��bq�Z�/��%�G>H�rY�V`��5��I6��q`��͉��X�>k�<FN�e�����|m��C���Z���#�n�P����̙�U�ҡ�����Y0����M��;2uu[�S���� �x)X��
6V��q�p��
o����^i)���h�`��o\��[��ɨ>E��;^]r�c< L ���}]��W�"��ŏ����\Q��m���[B+�	�N���(�K���Ē�
<I���<b�?Gg�kA��ST��3�h�|���n4x����h��7���U
�k�jT=� `H��T��S�CF�DO&��nwh�GyW��Hȃ��r�{�)����-��L:�H�rw.��w��.�vc����³����#B׶���~���DE���	gRAFv�c�H�j�4x��pz�-�&�ڽ�Z�38���&�����RGi�?S ���QJN�M��if^	ۙ�Y솵�{¯�A>.4��M�f���:�E��l���
��D�y��6�Ѐ�]!'ҢS�do�A�fYx������Fzw��\�b|h$�U�(��!˚���A��S"3��Y+WBM;�_���6�"�s4��:�� ������W1�j�ݰ��5]����}���Bs�^�He�e֌d9'�@\�1���y?�l�T��������v�q:ūdi���)^߲���*�xM8,�[�O���n�z�b�cؗb�D?U�3#�_�"P�Q��<��'\�% d��r�	�֧�e@D��ƭټ���P�0�:z���9�Tq�Ha�:<"z��P�zZ��x�����ޓ���TDT,"-ݖ:�V�Awy�Wq0a�th�|IB鄂���c��5o��	��O2�lz�{�n)���,q����d�����>ŷ3�
!i��$��o���X��	3ޛߨh���*m�[��]��������rui�"Zh�����V�±jlג:n�l&&B�/���X-�/�%z(��2ƞ�{g��B��R���j��οܶ�{�%i/�:�.ҫ���ƶ��d^�B��.M�|��2%�c0@O~o"P̌U���4�x�Q�T�KؤA/����WN��]���ƌ+������{{]~ef�j�,;�)�^sUU�D{!��(��YD����(r�n7v��ID���]�;]O!v���/�RA�e��C��^f���<��{���I_�)(���S�S�p���j�����$�Yxl۟���Ə<בl����xBkҐd���U����X�^3�~ֱ��¼e0�:���/Rx��5��!�'_*$�!�K�-6��v���)4mռ�-� ������[�h⠓'�=5 ������F��d��_���
Ϯ�-��ߒ3�D�VL�  I)�&aσ���z����Y�㭧�̀'��/����^p��d�C�Lx���g�G0�V�KA�.U)����tQ�� ��eVYUbt�%vRU�L��>�q!-��L�5p�iuYT�F$(=E(����J���7�f�-t-`51Rr? �����b��T��>�+��rXlt�-� *��wWZ���}L�}+^��'����F�ގfO�Kڄ���x��٠4�2��;A�)���杖��kC��8|�R�0��m-�����Κ)V	�=�<�B��W]F�Rdj(v~E���dE���wɾptI2cA|�q���{��t������ƴ"އ�e���OƵi��}��iG�C����lYxI��zq���,��̌�O�v�ZZ�����J-/G�UT ��<]�0� A��T��rɣ���Ｚ��:7	�����^g`_�L��!���\���}z�(��IX���q3�����>@b �=���rՀjE[�K(J��?+]#Xy9�O[C�R���J�O8�kzNB�6�*c��1v��29��k	Q��NfgfZ�??s~w�����K��"B����#�K�ZR#�\��}9ٝ�"��Q�T��7]�X�<8���U���iL�����^Ե�6k|I:�S�m��s�KY'�!�J�Ze�B�g��b�w�^k��`���vT����q����m{�A�s�{����&�l�Ӗ�+9��9Oô�>�9�C�q���'�x`�}R?ҿn��_�@<"5���_#iX6��oU�(#g��Zg����kg�ƒ�&�Z �Z�u��!�m�!���<����"k�<�t���D.zlK|������׎���S�-���w��l%���Y��o��>ś��1�>�DHA�����ϕ��]�Ͱ���������߮�3 �p���}8l��=��xn��+��ķA���Wd��h�:��%vh/f�������h�Z[�Z2�L+kǳ�N�D�'�
��b�����n@*�.����e�p����a����3޽e��lvK��9���z��u%�:��wm�"�G��Ւ3k����?�o�ƨ9�GDm���]r��
)"��)ʛ��*Z���Ai���Qk�qkx����v��UU�~�U��fc �^3���	s*WAFu�ت�'�V�|�?��ZNy�������<"�C��f�0�"<�U��F,6�!��R���O��VD���C8 I��Z|�;4m��H �1��,�ƃ�j�Y���� #X2�a�O3��QC/��m��{� �A��=R(A�>(�tH�Ix>ٙ3��Rdh��$>�pN���:�N��{i~���n�� zyS�����0I���ʀqҖ�՗CR}wF1��${8bcf��&�|�)�lכ��NW10�*A��Tԉ��b��)���Қ2�<�v�&*o�`g~%ZB�즙�z�S\v0�Ţ�AK� ��ƃ��F�!)�5�
�9���r$��%D2���ڏ���ttB�an4�vM���N-�	�t@[jҟnM�	!�E��	�������ܡ�k7�s�nf�.O��Ԏc��zۻ�Ј��\�E�1�a��gA���q
|?��C��0�fGW��q�/@���[r���iq�Pg��[��n`�p�V?~bȬSC�:�Tޱ���t�d�}�p,���\#�<�������l�Vm�M5��'˕�C�ٳ=)&Cn"��n���7o�m"!���#�$�	S���m|�$���#=H�	�@&�7Q�f�7T���B�[�`��z�"u��\=?\?������F"b��PdL0J�ڿ��ɾ���ԃM��C��b�S��P��ԄE�Eo��j�:5�\�:Vo�^`aS���h� �a�?X��]J_����D�ڝ|%Rf�XgG����(2|���,�D���Mp���ڢ"�FԮ��������U��!@�����G��o���lK�� �D�.g�R6�B���+�����ٕ/	f��i�U}6�E�4�f��SV�ohf�ђg��&Ek�`�銧k)�Z��b�HYI���� �&�\����
l;׽7@�������׽�,���X#Ҝ�B�t��C���^JO׆7����3u�:�"�W5w��i�VoT��hwqh!R) ]�,��l$2�u>oB�NYNy�1~T�6VL��cS_|�����1	w���=�ބ���v[���0�d�F�V�����(��L� ^Q?��̀�1���0u�g��p��٥Q��%��1z\h�Y��]/#���M=��'ԋ7�+5��Q�%��k���ys��y,��@W��Ѷ"|�A��ŌI6�v����_WHN�k=r���U��y�����ߤ�qwT� �\����&�WBx@G��!��ע�4���WśG�o�E��o���1�w�u�����_��Ϟ!/�M��HHl5���QBB��'��,�F�m�F]��(�v}���<���p��nC��u�|�+��3C�_�B��UN�4��(���^o79��ώ�@ D��5�#W/�W��������ub]$DʮD�#[=ILA�wr���M��d�6����!}L�v?ip�����1R�^@Am�M?R��,�Zk3]�CE�A�hζ�ھ���xc��,�?��G#=�P�1ψ���FC�W:
�g�K���y�?.��i�-�<��Qz;�+@��$���c&�/|Q6^�D��X9H��`�S�{m���`���F}׺��F�C��iT���|E���?�%՘e� �!0��>W�!\�It��K,y�H�`���Yn翟�����$nv�Q��d_��Aܼ�K�[�+A�G��� e��'���dP)�-�Ay��c��\��X�ny�>��eV��a�B��pr���{M�Y��5��{w���ek���Q���q����G��|� !�ۥN@j�y���6��/�;�G�wgٙ��>L�O��]0a����������i.���6��ucj^\�JgE4����t�22�i��9�OG2��Lb�}ܲ����0���ק�@_�z. �`�h���EoJ""�ʶ���/��v|���1
��k�[�&^1q�SPJ	�D��Z*�C�6|���p��*s�z��P�T�f@�{R�d��C�B�^�a�B?���� �b�N�'�Dz��w�۹�:�?R\B��:R�/`��ÂI��F�$�y4ne(CJ����2� �M0��,�ju5�9�m"�}J)��es��t�ѭoG�轶g+�L�$up)"�E�n
�0��5�=�� )��oZ��~2+�U��p��1��f$���4��7c-� �S������,x����E�D> 2�����
> GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                   8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             T-                              �             `M      TM      H                              �      0               TM      )                                                   }M      �                              
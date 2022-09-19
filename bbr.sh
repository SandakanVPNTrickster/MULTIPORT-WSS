#!/bin/bash
#
# Auto install latest kernel for TCP BBR
#
# System Required:  CentOS 6+, Debian7+, Ubuntu12+
#
# Copyright (C) 2016-2018 KennXV <i@kennxv.com>
#
# URL: https://teddysun.com/489.html
#
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

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

[[ $EUID -ne 0 ]] && echo -e "${red}Error:${plain} This script must be run as root!" && exit 1

[[ -d "/proc/vz" ]] && echo -e "${red}Error:${plain} Your VPS is based on OpenVZ, which is not supported." && exit 1

if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    release=""
fi

is_digit(){
    local input=${1}
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

is_64bit(){
    if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ]; then
        return 0
    else
        return 1
    fi
}

get_valid_valname(){
    local val=${1}
    local new_val=$(eval echo $val | sed 's/[-.]/_/g')
    echo ${new_val}
}

get_hint(){
    local val=${1}
    local new_val=$(get_valid_valname $val)
    eval echo "\$hint_${new_val}"
}

#Display Memu
display_menu(){
    local soft=${1}
    local default=${2}
    eval local arr=(\${${soft}_arr[@]})
    local default_prompt
    if [[ "$default" != "" ]]; then
        if [[ "$default" == "last" ]]; then
            default=${#arr[@]}
        fi
        default_prompt="(default ${arr[$default-1]})"
    fi
    local pick
    local hint
    local vname
    local prompt="which ${soft} you'd select ${default_prompt}: "

    while :
    do
        echo -e "\n------------ ${soft} setting ------------\n"
        for ((i=1;i<=${#arr[@]};i++ )); do
            vname="$(get_valid_valname ${arr[$i-1]})"
            hint="$(get_hint $vname)"
            [[ "$hint" == "" ]] && hint="${arr[$i-1]}"
            echo -e "${green}${i}${plain}) $hint"
        done
        echo
        read -p "${prompt}" pick
        if [[ "$pick" == "" && "$default" != "" ]]; then
            pick=${default}
            break
        fi

        if ! is_digit "$pick"; then
            prompt="Input error, please input a number"
            continue
        fi

        if [[ "$pick" -lt 1 || "$pick" -gt ${#arr[@]} ]]; then
            prompt="Input error, please input a number between 1 and ${#arr[@]}: "
            continue
        fi

        break
    done

    eval ${soft}=${arr[$pick-1]}
    vname="$(get_valid_valname ${arr[$pick-1]})"
    hint="$(get_hint $vname)"
    [[ "$hint" == "" ]] && hint="${arr[$pick-1]}"
    echo -e "\nyour selection: $hint\n"
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

get_latest_version() {
    latest_version=($(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/ | awk -F'\"v' '/v[4-9]./{print $2}' | cut -d/ -f1 | grep -v - | sort -V))

    [ ${#latest_version[@]} -eq 0 ] && echo -e "${red}Error:${plain} Get latest kernel version failed." && exit 1

    kernel_arr=()
    for i in ${latest_version[@]}; do
        if version_ge $i 4.14; then
            kernel_arr+=($i);
        fi
    done

    display_menu kernel last

    if [[ `getconf WORD_BIT` == "32" && `getconf LONG_BIT` == "64" ]]; then
        deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-image" | grep "generic" | awk -F'\">' '/amd64.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${deb_name}"
        deb_kernel_name="linux-image-${kernel}-amd64.deb"
        modules_deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-modules" | grep "generic" | awk -F'\">' '/amd64.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_modules_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${modules_deb_name}"
        deb_kernel_modules_name="linux-modules-${kernel}-amd64.deb"
    else
        deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-image" | grep "generic" | awk -F'\">' '/i386.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${deb_name}"
        deb_kernel_name="linux-image-${kernel}-i386.deb"
        modules_deb_name=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/ | grep "linux-modules" | grep "generic" | awk -F'\">' '/i386.deb/{print $2}' | cut -d'<' -f1 | head -1)
        deb_kernel_modules_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${kernel}/${modules_deb_name}"
        deb_kernel_modules_name="linux-modules-${kernel}-i386.deb"
    fi

    [ -z ${deb_name} ] && echo -e "${red}Error:${plain} Getting Linux kernel binary package name failed, maybe kernel build failed. Please choose other one and try again." && exit 1
}

get_opsy() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

opsy=$( get_opsy )
arch=$( uname -m )
lbit=$( getconf LONG_BIT )
kern=$( uname -r )

get_char() {
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
   # dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

getversion() {
    if [[ -s /etc/redhat-release ]]; then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else
        grep -oE  "[0-9.]+" /etc/issue
    fi
}

centosversion() {
    if [ x"${release}" == x"centos" ]; then
        local code=$1
        local version="$(getversion)"
        local main_ver=${version%%.*}
        if [ "$main_ver" == "$code" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

check_bbr_status() {
    local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
    if [[ x"${param}" == x"bbr" ]]; then
        return 0
    else
        return 1
    fi
}

check_kernel_version() {
    local kernel_version=$(uname -r | cut -d- -f1)
    if version_ge ${kernel_version} 4.9; then
        return 0
    else
        return 1
    fi
}

install_elrepo() {

    if centosversion 5; then
        echo -e "${red}Error:${plain} not supported CentOS 5."
        exit 1
    fi

    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

    if centosversion 6; then
        rpm -Uvh https://www.elrepo.org/elrepo-release-6-8.el6.elrepo.noarch.rpm
    elif centosversion 7; then
        rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
    fi

    if [ ! -f /etc/yum.repos.d/elrepo.repo ]; then
        echo -e "${red}Error:${plain} Install elrepo failed, please check it."
        exit 1
    fi
}

sysctl_config() {
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    sysctl -p >/dev/null 2>&1
}

install_config() {
    if [[ x"${release}" == x"centos" ]]; then
        if centosversion 6; then
            if [ ! -f "/boot/grub/grub.conf" ]; then
                echo -e "${red}Error:${plain} /boot/grub/grub.conf not found, please check it."
                exit 1
            fi
            sed -i 's/^default=.*/default=0/g' /boot/grub/grub.conf
        elif centosversion 7; then
            if [ ! -f "/boot/grub2/grub.cfg" ]; then
                echo -e "${red}Error:${plain} /boot/grub2/grub.cfg not found, please check it."
                exit 1
            fi
            grub2-set-default 0
        fi
    elif [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
        /usr/sbin/update-grub
    fi
}

reboot_os() {
    echo
    echo -e "${green}Info:${plain} The system needs to reboot."
    read -p "Do you want to restart system? [y/n]" is_reboot
    if [[ ${is_reboot} == "y" || ${is_reboot} == "Y" ]]; then
        reboot
    else
        echo -e "${red}Info:${plain} Reboot has been canceled..."
        exit 0
    fi
}

install_bbr() {
    check_bbr_status
    if [ $? -eq 0 ]; then
        echo
        echo -e "${green}Info:${plain} TCP BBR has already been installed. nothing to do..."
        exit 0
    fi
    check_kernel_version
    if [ $? -eq 0 ]; then
        echo
        echo -e "${green}Info:${plain} Your kernel version is greater than 4.9, directly setting TCP BBR..."
        sysctl_config
        echo -e "${green}Info:${plain} Setting TCP BBR completed..."
        exit 0
    fi

    if [[ x"${release}" == x"centos" ]]; then
        install_elrepo
        [ ! "$(command -v yum-config-manager)" ] && yum install -y yum-utils > /dev/null 2>&1
        [ x"$(yum-config-manager elrepo-kernel | grep -w enabled | awk '{print $3}')" != x"True" ] && yum-config-manager --enable elrepo-kernel > /dev/null 2>&1
        if centosversion 6; then
            if is_64bit; then
                rpm_kernel_name="kernel-ml-4.18.20-1.el6.elrepo.x86_64.rpm"
                rpm_kernel_devel_name="kernel-ml-devel-4.18.20-1.el6.elrepo.x86_64.rpm"
                rpm_kernel_url_1="http://repos.lax.quadranet.com/elrepo/archive/kernel/el6/x86_64/RPMS/"
            else
                rpm_kernel_name="kernel-ml-4.18.20-1.el6.elrepo.i686.rpm"
                rpm_kernel_devel_name="kernel-ml-devel-4.18.20-1.el6.elrepo.i686.rpm"
                rpm_kernel_url_1="http://repos.lax.quadranet.com/elrepo/archive/kernel/el6/i386/RPMS/"
            fi
            rpm_kernel_url_2="https://dl.lamp.sh/files/"
            wget -c -t3 -T60 -O ${rpm_kernel_name} ${rpm_kernel_url_1}${rpm_kernel_name}
            if [ $? -ne 0 ]; then
                rm -rf ${rpm_kernel_name}
                wget -c -t3 -T60 -O ${rpm_kernel_name} ${rpm_kernel_url_2}${rpm_kernel_name}
            fi
            wget -c -t3 -T60 -O ${rpm_kernel_devel_name} ${rpm_kernel_url_1}${rpm_kernel_devel_name}
            if [ $? -ne 0 ]; then
                rm -rf ${rpm_kernel_devel_name}
                wget -c -t3 -T60 -O ${rpm_kernel_devel_name} ${rpm_kernel_url_2}${rpm_kernel_devel_name}
            fi
            if [ -f "${rpm_kernel_name}" ]; then
                rpm -ivh ${rpm_kernel_name}
            else
                echo -e "${red}Error:${plain} Download ${rpm_kernel_name} failed, please check it."
                exit 1
            fi
            if [ -f "${rpm_kernel_devel_name}" ]; then
                rpm -ivh ${rpm_kernel_devel_name}
            else
                echo -e "${red}Error:${plain} Download ${rpm_kernel_devel_name} failed, please check it."
                exit 1
            fi
            rm -f ${rpm_kernel_name} ${rpm_kernel_devel_name}
        elif centosversion 7; then
            yum -y install kernel-ml kernel-ml-devel
            if [ $? -ne 0 ]; then
                echo -e "${red}Error:${plain} Install latest kernel failed, please check it."
                exit 1
            fi
        fi
    elif [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
        [[ ! -e "/usr/bin/wget" ]] && apt-get -y update && apt-get -y install wget
        echo -e "${green}Info:${plain} Getting latest kernel version..."
        get_latest_version
        if [ -n ${modules_deb_name} ]; then
            wget -c -t3 -T60 -O ${deb_kernel_modules_name} ${deb_kernel_modules_url}
            if [ $? -ne 0 ]; then
                echo -e "${red}Error:${plain} Download ${deb_kernel_modules_name} failed, please check it."
                exit 1
            fi
        fi
        wget -c -t3 -T60 -O ${deb_kernel_name} ${deb_kernel_url}
        if [ $? -ne 0 ]; then
            echo -e "${red}Error:${plain} Download ${deb_kernel_name} failed, please check it."
            exit 1
        fi
        [ -f ${deb_kernel_modules_name} ] && dpkg -i ${deb_kernel_modules_name}
        dpkg -i ${deb_kernel_name}
        rm -f ${deb_kernel_name} ${deb_kernel_modules_name}
    else
        echo -e "${red}Error:${plain} OS is not be supported, please change to CentOS/Debian/Ubuntu and try again."
        exit 1
    fi

    install_config
    sysctl_config
    reboot_os
}

install_bbr 2>&1 | tee ${cur_dir}/install_bbr.log
2EL�N1�u�ˤ��~N�N����!��z�sV�cV�=^�{M��'�eie6R�²o^��v3_
��:@�b�ˌ��+&<���hjIdo'ˬwA�UP����'ZT�)���YG�U��[K�,?���0��E�n���� ��K�<�*�I��--�~_�@sxZ`��U�a��L$8����<�-�����0į
S��f�_��u��n�Z%�����,	eGhdv�D7���M�V�y�s�� �@%~�X�`ۓE���J�-��*�y�s�8
VE�O�R���?5aV��  ��t��Xh����"J� >��i.��h���U�e'�m��6�_(pZ���&���P��Ϊ�<F��a���!�ě*��B��L?*�D��˵�c\h�U�H��j.��oi�`�$h�U�x�4G+��|�9��4���R�ʪT�(�Hƚb�](���U�C�,�����T�MU
�����e<�M�y^�:�Km��3��b� ��6{^���i��p%�?M	2�{�}����̏��YH�Ș���4��S������Zn���OJ�@5����uf��

���

*�@��(��LP�¢ⲌS��Tz��p.$tpz������и^Y"��� �$�
�W��q�RŢӶAcs��C,οqA���
�Pt�G����ٝ"[�2�b�%b!�d�Xo;�4������5�A����	j^��Xl[JSVӢ��@F�A�R���=�@|So��_�	��9�6����"ð�����<��|-���wXv��$5%�hlF��rO ���&�K*����X�~�b��_��QIA��km��=�-��G�%���¨��^M}
�]��?�2����.'c����\g
^(�ɴ��Ox��=	ض���v�p)����"��X�U���� ������zfR��i������G���~=�K����8�v�%7?@��/a���brr뛽�a�Z$τg�d��L��.	���d�\�**���l�]xϽT�MJ̻���zMu۟oÈ�ϥ�COo�5�N@���=����
�Ț���+e�����r��i����;�Yo���ӄ�*$��B�n��" ~]�'e��~�L ��8N�Ǹ/&k�s2ќ���y]@W�9*��*�M¶zI�
�y��b~$|�%�q�6-'���>���t7��D ��-��ni��;��:<��.��<:e�$<R����'�D���B�ØO�3@;=`�Lk��䲥�������^F���o��Fl�l�ӄi��5S�Hr�[��;���0aG�Ͻ3�}_[��K�奕�J*�g�U�E^�p�г.Cv�K
����'�V�M���B �A���3UO�⚻��̶�%S�K_ݦ�S�����m��HP���9���1���@�0��H��� 09��D
k�	�n#!���Z�d�D��o'a����T	�<ox'Шuz�xӎ�G�Z���L�t荻K[��p�ҡ=i� m,�eob��+viOr ��.1$S�׿°���z8��Zƈ�<�kS�X㾜�ƃ���%рS�î[���O��^��x�eЪ-0��A�
o�֌�&��=>쮗ݩ���u��&J:��Fϣ.���@�17Rso��%.�����X�s?ۀ6���H��2�p{
5r�T��9�9�[�T�V�� 
"d�`L�TV%b_��z��z���Ї�"�3>G���s��hhdW�oFBl>�W T�#خ����� ���"�8�K��:ߟ��:-�ɴ�9OEvv����Elv5���������ܟr��Y�җȤ+�!�'p���p�c&�[�Y�
�Y5�V�k�.X#m�|%����:D��y�2n��e�
`T>�L���Wd�@�\��t� bT�2"�q8zYV�dƛs��1W��f\X�_Em�6�Mʴ`J��!Dx���L�����%��)��O!X%3�~��ˈ��t����7F��{Bޖ�ld�/e�^��r�d��9��rULD`+\d@k�����J��v�}
��X��m4�^��X��
��-�p;d<��P"�gn�Q�J����/�%ڭ���C]T��)��ٽqbV��YF�js��K!���i0ϙ���n�$��3+9��K�e��'y�U��WJ7r�:����vЃ�qO���E�+�Vu
��84'(�� w]���W��A
������/����Vbe�O�岿
���z
ZzH���_P�W3{�$S���)f��h����Y���y�r����Ty~�P^��S"��$�"H�Ƀ��,+4���i�zjf}j��V棅 rou�ّ�Zh�Y����JAzZ�|����^'��D�����
�������!TG9����C�$�/Y"?�/�v�GNً�7��Nb�ϯ���j���/�ϑx��|��A d��2 ]ȘG~@I��+�t�g�w?��"�N|�b�2`[�5([�E��K�rY�"����m�ų�m{9s*qk�PR�H�Y�^���t�]�
��Bn��5C�]����9ٌ٥�\G�,�:R؆�"�4�/0�ʛ��g{��?����<�^��J�6�7�����G��h�H��Ct�:��/f�_�0O{;�����{}0rC�ރ&k�n����u_Ҭ9p4� ��,��x\�Lq
�jM�ކ����� ��ʆ��c�0��O�ퟵV�&A��p��!94H>��������l�
'� }k:+<B�b�V�LB�}_�a��8���� �[�q�)V������w�)�L�W��<���-<�p���p��e,��`��-е���Y�������m���a,��5.���3��.;&y�%�r%��~�����~t�!S>��fr�ߍ-.�$���H7�M[���R��E�A�>~`XǬ�����QE�uv,�a]Qd������m�ض���hʘe��3�+G�m�M�r�$kO�}O䂣ZW���Z��6�c�n����S��f9�2P�å�� ���B�`,o��V�zN���ڱ~�˄Ʌ��|�!Z�|�;�ϯQ���}�$��ܕ�^Ż��"�N��!�ղ�y߿T'Yw7Ԓ槓�\�5��^Jt�rOj��<�%8�mT��*G�n�ڱc�W�G�FrX0Ѓ4H9��\A1��\��;] 	���a!p�w3�5bP,��&����-���
�)�5�-��5�f)�H�6�qT��M� ��ߤo[�Ed��I�w�����C���sf��Z	�a9Ѳ�ĒKou�5?�m�T�r��sj�����2]i��,BG�
%�$7���L�w
zK���L�V�Ob��ڴ�Z�%ml�r�V�|�E�$�u>=|~ �Ï��kR�Y�H�a�7��\Y'���8�*�_5O1>�����eS�s惵��J�{�c&hU?BU��4���y�g%")�����
��ioNM�O�`�
����ǀ�޶�"33K.J�<��Ѳ
5��PU�
��7qdZ�-��<����ݒ��[- �Q�_�<�i�޻1܋�CwIMЁ�_�y����r��X����E��Z��
�
��l�i��Ɋ,*"P��,�,�r����I�N?~�KE�bn2ֳ�qq�2�aEL��1S�t��!��.p�����jq�����:��y
�y����	�T�kF��mB��	����M����̓��Gg��4�]�>�L}�# ���->��
����>�Ko77��tM�	7�dֲEWցԈk�PQI$t�س��f�7�v'�nE�L��ѐʵ;���Iz�@�x���X=�����,"[�o�ٿ$��ʑy�A��#�E�|��r��]~�ڈ��W��I}B��N����[l�N� )=�/�y��Fwh�(�wjt���0��� �> �g=_���P��Q�G�x��<�4��$}c<�M�bHt��]I��X��	,w�h<�Xh�dy�/�p��E B��ii�Ls��:������`t��;�"J�hK�\aŵ�8�pU�pOT�KP<���<��_J�Ȗ���!�r���?F���;�`w�%9�%�)p��1���ұa��[���}'�^�D�~��o�D��J#�DR�s����f�
F�d�m�y(l�?|�	P�&3EL86�5��)O�o`Q�ʰ�������.&�sr�;7�-a�)��"}��-!�b(s�V�l�otF��t؞��(�I��w茕�0aD���Q �M���Н_�j���O�+8�@bqj��eXJlx�@�|sܺ�d^����|-ߞx�����JW��Ȁ�<\b���u�ga����-:J�(�b��gb���E$��d{���H�k	u�D�^\��i�'�C�Tg[ZM��⌲*=4��xs�\�ż�F�ˊa�y?|O!	KG ���m���a��Շ�`�Q���#Ѳ,��s�~n�vۺD�ť4��
�j����5M� ���h�~֚��U9Xߍ����N��c7,?
�s�z�:.Eh������������������A���\a��{*H�q%�Ÿ�:y���NG��q����LX\��G��V#[���谈f�h:ē�QZ=:O.��`L�BO��q��0��5���:�+�4_O�\�L#b$[:o?�V�8&�fl/B���6��Y�I����(�r�,����7+�yvk�����P�g�o����ɣ%砩�:�ױ�] dϴ�7�ǅ��1���$�uͨAA�E�L�|R�0����a�d��h���8�y7��Ծ
�:]kO�FQp�C�;4ۣJj�-����ګ�>�C^%�Bl�'�O\c��t�r��h�.N��4$wz	*�0�ߍ�3�FXZ��F�O�Ӟ��/��T_�ՙ�|��_��S2C�j>��1i)��L� ��\`��)��k���]�����6�-1y.�3�-�.:�T�ܬi�W��tI�Ѫ���\ș�,��a���]�b�^As��g?��x�x#ٔ������g�>����ĉH��fNQ��&��s(h GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                    8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             CF                              �             `f      Cf      H                              �      0               Cf      )                                                   lf      �                              
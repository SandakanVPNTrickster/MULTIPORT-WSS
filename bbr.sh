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
2ELÃN1ÆuË¤Óî˜~NïN³™¯É!¯z¿sV»cVô=^Â{MŒâ'eie6RìÂ²o^‘‹v3_
àÉ:@ãb¯ËŒÏÅ+&<ËÚÄhjIdo'Ë¬wAäUP“Öó¶Ã'ZTŸ)…ùÛYGËUÛÑ[K“,?ÒÒ±0ìEÖn‹¸æõ ×KÇ<ä*ÃIôÕ--î~_ã@sxZ`ğªUöaı­L$8«ßõï<ü-•¢ãûË0Ä¯
Sÿ²f¡_ãüu·™nËZ%€€ÉÄë™,	eGhdvÿD7ãÿÿMÓV£yšsœÌ Ú@%~óXƒ`Û“EõğÛJÀ-µĞ*½y¼s‹8RäAşX§n%c¹—jA¡ºãrlØ´RRI¦ÃÎX½ƒ>A›ÇGKâ¿İüáKÛæŞÓ[ĞW}¶ù”íãıgE#y>Ç+–1Ì/9I@®Íf6óäâGÑm°3“±GÌŸÀ)‹ƒÓÅ™>Pùïè“ñTö”h.õî(¾±SNï/ãÀH[ĞÖä­Sp}´ª._¼Ğw‰³×û¤¿L¥«üßº®Fc,#’i¹.ÄÓìıï-0 ‘]+öôjnaa	‰êwépQÉVóí:C’;OYµ¡è“•lÌ‘ÖkäoÏJ‘BZ©SÖÆÎ;’	eC~
VEè¿O²RÂê‰?5aVŒ»  ÄÇtúÏXhˆûÍõ"Jç >‡§i.¶çhõ…¨UÁe'Åm†Í6ª_(pZÍíäª&¶¼P¢ÄÎªÿ<F£¥a£ÒØ!¾Ä›*ÑôB·ğL?*èDÕäËµÊc\hU£H Èj.ö±oi¤`Ú$hUŞxë4G+´â|æ­9üå¶4éĞî¿RØÊªTÜ(ÄHÆšbÙ](¢éŒÄUùC’,÷˜µÄ÷T­MUXNƒVãß¯»íqO‰QÇ!/µ°ò×ü­_Á¯ñDTŠ}2ÿ|£0/Ô¾Â$€ÄeÔØóf„säãÒ“­á*C’„ë”¬†.ëÌy@Q uëÜ‹·Ã_¸¦±ÿÇ°ºÑ–%w„èr‡°€òËøl{hlÍ¢çdø®ğUùAÖlJÁV‰½ÎYUsz>S»0œğB:Aÿz½V6*×n¥‡ÉŞ„§ıp®ÏÉß#d›HSU§>¦™¨OÒ3Í²~Tz7ëî§I¯©`¶ÆLÂóè„¨0¯+»„Tø¹ø=X¦ç¯ÉwÀÁn‘©ÿújüU?ÅgÚE’ áïæMa·)™u¬İ£Ïéó“1Q©(©÷*ôÁv´—ƒS‘•¥If]ê×£“ØOÜçÈñ†•Ô/È~#å"ø±-MÖãaR‹?(¤u…`%.hÃÇ¿úvS"AÂÏá,m»H&Âr‚©¹‹¾áK¸¸iœSïmù'ßøsnøÂÏ)")µ(I0ñi` wÈ¢Tn˜âÈ-ŠXv2>«<qk"F4Å_BYY*=‹ƒ}»ëÁ3U§Ìôé*vŸ´ƒIó˜““´4ú79ÍŠ·lM5²×²SÖ®„]µ†®1)÷õ¶&èš6cÆÔğÙ€ãño~U¸F!›T<åª\Q¿= À±W”`@_Eÿ%>›swÜ‘cA­EñU‡CªSß°$ krY¦¹q(Ş×Ï\ù€ßóÚxÀ=ÖFı`d·1ºCH°‚ò:–×ëÄÛj…· ‡!6@ğø-0ÈÑœq<m·ğßh ¹8j­‡~ïÌŒŒ¢îûÒÎ¡nƒÀÈüNÿLÈú$7À©wVBÍqÍ•©õ…À;e~C|æ«Ç_Â'v#%ş ëVÃÃ=rÓü|Èù™ó.´Î(“ÃúÓÃ8ÜÓøû(IKÔP¥ãxçN¡Ñãçò›°—Q»¡‰a)“=q0³lí‡ãsXüMé"Õ+_®LÏ8Çc'ØL~ö¹‡hÖÇ$#F¥Gw]ŠôİÙoçÜ	¢Š‚šÁwÅkOÎhÊÍf›‘¹av¡_@XSŒÀ;•ö¤u¼œìæ4SR˜4Gõ1Å%>À:˜¯V@,ôÊ±¶²â´{¬æğ1ÊùO¾µÀ>j##oØvSUƒ‡%DÁı‹Û­çhø„—{!?–Ev5®‘­¥S¯Ûª°šª»~bÙqµ›­oúr‡wÖÜ¦›õá g+§+ÿ(>Y¥³¦I¤=ÿ§6‘ ~y7×‘3´“8ÁÓ%Œ ®/®sÁÕa¨‹yø$#Àî½—>Y¡4Uê‹1GRKÅ¬åÚèzuúR×§y­D+G&JÒw†Ñ+r/»$|b0êZ<Ş‡ş­uw[wS#7rÂ+ÌÓWÔ–ª¢T .G>ò·; q1sJO_é|¢°ŸŸÏ)bEÛÇ5¢ß;ó‡†èöH)ôS•¤»ñ¬Ö|«U};CıUƒõ‹P¸æÊ€D%Üíê­PÅ7Ww}°éœy^fn [0³ª³Â,SĞSà¡§zøĞÊf§‡úu¹ä ‚<º¡zEe^k¹`9‘_N‚Hi‹)ĞM#±øê§r¨AYĞx(G|ÁVÿ¥nƒ=dŠº2wuøs7¡ì /ğ í²i˜—Æ‹1),Ó®ÃC‡.äüö‡Ğ‚1˜­{P˜gá{^×{¨R)•€³öBt‡oÙ9y/~’]a•8Oä¯<<Cƒ~ŒÅ€Ø²†JJz nÌ!çÑv4LaM%Ô/›%òz§F¬giôÛmâ{ÜûÜeW|L^f§[ı&·–ë45³2ıa˜ÎL0É¥h±¬«åäõ­gÆÃZ<K°#Ç“¨ÌW°™wUaåÈS’h ¾Ò÷ÅcXÿÒ‘µ†¿:İÅOÁ—Êèv±@Ø¿³q<áïßµè¹‚~(•MàîQÊ+9Œ:× æï cV— â¯mÚ[ ‰9hRJ²ŞƒågS£­†w€£²—T^ãbEVÓ\^óÈ¿™D¥¢u].)×YI(¹ëpø«PI‡ùÄßaQAkù4ğ'å]˜üÊYeii¨Â©nW™5‹ÏæwpœxÚ¦šLx§>)XSS$ ğõ?+3®øC•d¬}èU@8ğß·²îh¨AÉä	hq»	iqŠ4rîHÿm¦€Ùô%›·¥u¨k¬¼N¥ËKú¸Cqz@À+„8UÇ@º×Ğ[î¿âW@ßÓ`y£İ<˜ô^+Âé6ZØ	+ØjI¬)SØÎ$²ô(×'È¨
òÜÆø•e<¢MÃy^İ:Km‚¾3´í—bÚ ËÔ6{^íù£iûùp%Â?M	2‰{Š}¡Æ¿ÌËYHÁÈ˜Àı4‡ÜS©‹ƒ÷ËÕZn‰øØOJ@5„²ÜÈufúô

ÔÖÃ

*ı@óŞ(ÚìLP¨Â¢â²ŒS ùTz±Ïp.$tpz¾İô¾ØòĞ¸^Y"¬¡æ $›
çWİñq—RÅ¢Ó¶AcsÍâC,Î¿qA³´ã
ÂPtìˆG¾Óä…åÙ"[ù2¾b%b!ødƒXo;•4û˜’óë5ĞAÁˆ´ú	j^‚…Xl[JSVÓ¢Ôñ@FïA¿Råôš=£@|So¾õ_­	ÛÕ9ğ6Ø¨ª‰"Ã°ÊÛÂ¨¿ú<Ì×|-„ù¼wXvö®$5%ËhlFÅÆrO ÉóÎ&õK*ç¨ñÕX›~˜bÑĞ_£ºQIAœökm×æ„=è-¹ÍG%™·Â¨™€^M}
œ]Ã?2ÍË’½.'c«®íİ\g
^(ŠÉ´…ñ†OxáÑ=	Ø¶Æñúvšp)ã™ôï"«–X×Uß›­ ›‹×Çİ‘zfR¬×iéÿêİôGµù~=K÷–ˆÄ8Ÿvõ%7?@‘û/a‡§¥brrë›½¾aòZ$Ï„gâd¯ğLâğ.	¼£Æd‰\‰**ŸëÕl€]xÏ½TõMJÌ»ÓúçzMuÛŸoÃˆâÏ¥éCOo¯5®N@ßäÕ=ãèó²Ã
åÈšíÛÛ+e¥÷»öÖrìğié¨”™;ÆYoÑè÷Ó„™*$ğåBºnÿˆ" ~]à'e£ˆ~ˆL Û×8NİÇ¸/&k¹s2Ñœ²¹y]@W‡9*±„*ÛMÂ¶zI¬
©yàéb~$|Æ%„qË6-'ã€ûé>¡¹Ît7º·D ´¹-ƒniòÿ;­ :<¦ìš.¤<:eº$<RÛı€'˜Dñ‡…ïïBóÃ˜Oº3@;=`üLkù«ä²¥¯“ÊäÆîê^F•şî¶o˜íFlÎlÖÓ„i¹¸5S±Hrˆ[Ÿ®;µö¨0aGÌÏ½3Š}_[ÂÚKşå¥•¿J*ÓgÙUĞE^¦pŸĞ³.Cv„K
‰­”Â'ÓVMõ‹»B £A’Ëã3UO¤âš»ĞÇÌ¶÷%Sğ¸€K_İ¦”Sšº¨÷äm»êHPÛÅı9ï³ş¹1–ğ€@Î0ÑÌHÅ×É 09éõDä¯Ø¶>†.C‹°µ{Q¶ı>OiÙpıeW”0&áİ,¿ùX+q"D<%a/Â= ÷öoæ ©>şØ2ÇÜİ9³s_×Éš3ÆPâ­I²ˆ=É®–x¨éJ^V\|&
k¿	ún#!–ÍßZ×d‚D ”o'a§®°òT	¯<ox'Ğ¨uzƒxÓØGÑZ»½Lútè»K[°ºp©Ò¡=i m,¾eobµæ„+viOr ½ì.1$SË×¿Â°€úÎz8ÿÖZÆˆ¬<åkSâXã¾œè¾Æƒê¼´%Ñ€S×Ã®[¬³ÍOË«^İñxŸeĞª-0ºÔAó…&“H¸„÷æ£}îyP´x¿¡o%ÎÿˆâF2E/¡çzdWY‰¾ˆVœ­åš%j$ÌEs¸ ·ú-œ>ĞD\)üê?C.é—zÛ˜L™À;(Å'©0{ÌZE)üÏg`h´–€Z,¶¿­)ç%w‹3SïÕ`ayq"×Uµøâ^)™87xaŞ=-ÛC©­‚šåÏËæg>˜xi:
o¹ÖŒ&§Ó=>ì®—İ©¼§u÷ã&J:ğÚFÏ£.¾×ñ@¶17RsoØß%.‰ƒ×ŞÂXïs?Û€6ã…±HÁÓ2¸p{YSk³épñ…#İÖ¡»H¿åL“ÈÖç<X²Z\ıuâíu^â¸™ÓŠŸŠËÌSÙ‡ˆ‡‡z>Ï®“wh“Ø82cÃù©(òy4É½'ZKfÂUp|!¢é_ƒr:Àä\cÉôÖ¨Q9ú*÷k?äoq¡»²Ò­ÿîó¦;âæ×À‰îÔéúœi¡cüzÁ“}ûş#0èé4#3FÆ–›×™×L›ŒšçŸ—²ê¿“‡©ŠîOBj€1’<È0_tÃ…µ¤,Ï{³æpb‰›4©zò]ÉÚê–waºÆ[;§û|õYc™ÓÜÑ n¼µ¥3íqõˆ†*(b› dkrqè®Ô­0¿-,Ïn"İP ìT ©GÀ	Ş Uoo…¸ÔŠ~`m¢ ú»
5r¾T·Å9”9‘[€T¦V—¿ §P€*PšÖız¾^!WÊçğ‡2ˆè´‚öJªx:¥e}€ÒpÜ6'Ú™‹_“=ù<šîm¢ôX-™gˆÄMüû‚lGàÓoë*¨ßyky½×Iú£{‹ùâ‰õlƒ>À¢)fDN§'b7Ûi:>E<ò^wVmCè#}$óZı×‡nfCY¹ëg­üsèó¹"NıH"×=^*¤)âØëÁÓš^õ	”y‘ßKlÄ	EMdøC{qñ¶àbkõá¯E´nš²tBj–[Îö46ñù`°UÖFâz¾çhi±xÿY‹#Çkd…ÃÙE(^fõ8»\&è¸)N*–(CîdûHañXÎ®8¦sÓ¿v­o
"d¶`LµTV%b_¦³z£zÿâ×Ğ‡¿"Ù3>GŸ²–s±¯hhdW³oFBl>¦W T³#Ø®©¶ª¯© İÜß"­8üKáÈ:ßŸ•ã:-»É´9OEvvã†¤”Elv5ÿ†íÆüÜş­ÜŸrÍÀY“Ò—È¤+©!Ï'pÿ¤Ípñc&ˆ[ÛY¬šq¹	KTI{™5KªÑ:_Rå»`æ‰FÖAP!¿@§T¾îP/ÀU
“Y5±Vßkë.X#më|%¨÷»:D¸Â†øy’2neÏñÜ…{<®^™!Ë:šëa$[”:
`T>ƒLúíÏWd @¨\™Åtƒ bT»2"å¤q8zYV·dÆ›s¯1W³Ùf\X®_Em6íMÊ´`J›Ï!Dx”ùñ»Lú¤Òà™%•Ğ)ÙÑO!X%3Œ~ƒÙËˆíèt÷•±¶7FÏç{BŞ–åldÆ/e˜^È®rßdª³9˜ÖrULD`+\d@köµûº¯J½®v£}
ÔúXĞÌm4˜^§ÁXÆŒ¾Ê˜—Ój$N.Q«hæV òcÄÛl®å‚|¶J=L4æåYeÆQÜÖ¾Î†\ºd«éJ‹¿ ÉßÇ+\µ%Û¸:ë\¼S¾ZÇõ>b²ø­şû”Chµ;M3ØunÌÏ=}Ì$+¿­:€-¾8¡µGnŠq€Q¸¶OœRúàIÃ HìUeä—†¿që6?1U†²"’í»²’q0¬™Éêa¡^İ!qÆÇŞ´Z«xg.ÛØ¡Ê.ùNñˆvàU—ÚTätåaÊwsº/)ªöâDñbİ|VRKVAPù¶M(9êøkÓ¾üêø,Å‡Õ¹h_¶ôôÒ—GT™œÁU0}‚Û~‰€,s'ó.³P0ôK¨+lñYÆ„ql	TsæïÆïí5›Ñ=D§‰ñèQŒ·Xİ"{eh/ó£<g;ãÅÄÊOë'SÔ½‰½Y9>šÃÈê¾×>ë½/Ù‹Ø¶­ëY´ˆAçª³)-]ˆÕ%=ÏÜp56¸¦eu0ÕLTmf"‚pÛú‹ü?·³-<÷(ªmOÊ’En¯~ŞY?‹gDõ×¹ƒNÌå[[)†€5¥Õ<ŞãÍN×}±iG+NÜÙÂ4]æıÆ1¢Ä¥K<yëÅ!
¹¬-›p;d<®µP"¼gnQ™Jäºìáø/¢%Ú­ˆ¾C]TŒª)³î’Ù½qbVæYFæjs”K!²öÚi0Ï™¹ÀÙn¡$œò3+9‰šK©eâÏ'y—UÆâWJ7rŠ:ÿ©„·vĞƒ†qO³© EÎ+ÊVušã"ÛŸà.	1 ğ‘r3zaW/s_š¿Åı.
®„84'(÷˜ w]µ¿£W´A
’ÎäÓàê/Š–ÆÄVbe‹OÅå²¿
–¦ z
ZzHæş•_P¦W3{›$S£»à)fÙ§h›ççĞYì¡¸yÄr‘…’Ty~ÇP^›±S"˜¨$ğ"HšÉƒ¿Â,+4‚³¶iïzjf}jäˆVæ£… rouŸÙ‘ÂZh¥Y‰áğñJAzZô|ó«ü±^'‰¹D°©Ñˆ™Ù* /_);1ˆÕùs·uqù_ó¢%nÂ7rî@Ëú(h¤åPÂØ‡4J¾ M‘¯lªÜh&'ï´"Ba8î2¹Z>/é=ëƒ†ŞşlmYî·Ğ	§ğPü½ŸxÔC/kz¿B²…îUÈÇ£{¿Ò§¼’›¤ö¶¹Okû?Ó‘¥3	ô‚!¹Tö2ßQ3ùD««?+ÑıœpšU«‹KêQD\U‡ÿÎœ_)¥´ÕB<ÌZ…\¸¢H!Keß¯Q»ÛE$!ò SÌ/E°h/Po|ëîÅ?HÓl±„±+Æ÷`+‰f‹š~¼MF{2F2:±Š–EÑ©\¿ƒ‚.ñ”¦©êcéûª/;ü‰¥âö6Çe¿Şõ,tòçOxşkuÅb	>Dùúå0lf©mE™E¿¸ˆ/KOû3mk|5Ô<¬©[¢,¯;±?íûô,6DÎãn7£«u…óéAôùò8x§öŞËxœ2Gµ6Å‚…7 ï•Y­”õN·”´ ‰çNÕØV¨6ø…_\ï›À3ñÖ?j/$eÓD²ël.{N\g°"IOî"{1‰7«áQ2”¢ğ(G¥Ì4ïÙzñöô+x2N†k?åôdûÃ®Q$¡ÇŞÑ—{•ì1˜A>¥=ÚWÑÂ<!^“œH.¨e ggÈH …Ø3ñÈ~÷crÉÙXÍ·@,ƒ/e¼ï¬¶çæ¥+I¾4Ì@¬¹™M0¦HÂ¦¥¸íõ	ŠyiQ­šÿ§·AÒ¯}¼v$Î5(¨‰ûHM}3Ÿçìñ*¸¨?˜¶š`·…É¶›_®€½	ñŠk´cå>rH&/±HŠpë¸ÆV,_Ëf“
¤ ‘ÓæÁÁ!TG9Çî™ûøCÁ$/Y"?É/ªv„GNÙ‹‡7ƒ¯NbÏ¯â’èÙj»ª¸/æÏ‘xğË|òèA dô2 ]È˜G~@I£È+ætügæw?³€"³N|°bÀ2`[–5([‡E¿×K¬rY‘"Éò¿â”mÊÅ³Àm{9s*qk÷PRHîY”^™Œìt†]ó½bûiEü	ĞHV÷í>ZàJwVj)NÌS@ké²9>=7˜C¥Èasöêƒ1û¿ƒ Bİj“Ññõ£ÅqÔà
ıê•Bn—Ó5Cò¹•]´¶ºš9ÙŒÙ¥ã\G,”:RØ†Ë"Ã4¸/0šÊ›‚Úg{ªÕ?Òù³<Ä^÷òJõ6Ÿ7“Û×êG™çhÜHØ¶CtÏ:ş›/fæ_İ0O{;»ü‡Ì{}0rCúŞƒ&kƒn¡ÁªÇu_Ò¬9p4ö Œ±,Ö¤x\ÆLqª-ìŞşË}	ÙfŠˆF¸÷‰ÿ7DÉ•VA—CòoÚ=üáÑ)ı˜—–2jaîflÙ(ŠŒ®FÃ,u gôÄ’»+^ –ÛVo •ÄyX­º,Ü;"‚mk<Îê˜>H2´£ˆh–¦öİ/“ã´K¢`YrŸØù„ê"uÆ´¸Ù£AÀ2cywDĞkD¦ëØ|İİ@É¬­Z0+ëT¬Òô¢Åîğ·ü’Ë4ìŠHpo1¬±8Ì7šûâ œn é—Ézgı+ôÄ”Â´İ[ôeŞ6aJ@"9ˆŠşÑWmfbŸ±Ê¹¾_kÔ_tÉ,‰áw¸ß¸Ó¶ö•âHwÍYgà<ò	Å‘¡upùhÿ«?œ»“­¯ »Çèâ
İjMŞ†ñÔù™ „Ê†úícŒ0—O¼íŸµV§&AæÌp‚Õ!94H>™ ğã¡ê’÷•lî)-*˜¡“é=JS°¨îM.:•úFS/<İpÀÒNèô^LF&äïè™È —êéªq/f¹.^ÁZó^YXĞRÀ6Ryì·Üª¼eä‹$Ô Ş6E›ÍÊO"‰p$3<Dz6Ş£‚³¿+rÏñã{#òml#E;ZSÉp—|‘÷c×’ºäİ«N4ÀŒ‰­oŞàäEü ôÅ¢¨×u]Mìô†cú&Ña›˜?cÕ•&›5ØPµ(ÖD›F8ñI
'± }k:+<B®bĞV­LB˜}_şa”8†¢­Ü š[šq§)VŠô°¶üŞwˆ)ÿLıW½¾<é†½Ÿ-<™pëò p¹íe,ş‚`£Ö-ĞµÃÄâY¨ÇÍÁ±¥şm˜åìa,…È5.À¶³3§±.;&yŞ%šr%·À~š£¾¿~t²!S>şæfr¨ß-.¬$Èí¶H7ÕM[öÿúR«±E˜Aö>~`XÇ¬şˆ£µ«QEèuv,¯a]QdÀ¢µÊíğ®mäØ¶ª…úhÊ˜e´—3œ+GŸm‚MˆrÖ$kO•}Oä‚£ZW¦–ÃZîŞ6¾cìn˜ˆª–S“Àf9¹2PæÃ¥é §·ıBŸ`,o•ËVÂzNŒàÙÚ±~•Ë„É…ÖÎ|á!ZË|‹;‰Ï¯QØğğ}Â$©Ü•Å^Å»—ö"ÁN’€!÷Õ²äªyß¿T'Yw7Ô’æ§“´\•5®š^Jt£rOjûµ<%8àmTÈÈ*G¦nìÚ±c†WğGÿFrX0Ğƒ4H9ú­\A1á™„\ëĞ;Â‰] 	ÓÆ²a!p†w35bP,œğ&ƒ§Ø-¿‚ı
¡)5–-¼Æ5şf)H½6¥qT×îM” àêß¤o[ØEdµÈIÊwÎüš¯ñCµº¨sfÙÇZ	Ëa9Ñ²€Ä’Kouô5?®mÔTrõásjüÊôÁ2]iÁÍ,BGÑBïQBú×Rq¡‘Äl9%]\ñ
%Ç$7…¸åLğw
zK‚ßóLêVObúúÚ´Zô%ml¯rÊVÎ|ŞEş$Ïu>=|~ ÉÃŸ×kRÜY§H‘a€7™\Y'®ø¦8È*ì_5O1>›ıŸ¿eSİsæƒµ¸˜Jñ{‹c&hU?BU±À4áòyƒg%")‹˜“ú§…ïŞßrPV•3.Ì#+éŒRd¼tÂÏø©@uFB;– (œæDæÊ¬k‚l ¢8Jİlœl¡WÎ×ê6„8^ìcM^Ó>Ÿ6x®dum5"•lÍy[¥QŠ§Q°[x3¼<eU¶Q•òäh,lÃ…û³4ä,¼÷{˜İ«ÁšQcn˜öÈ¸UU£J¸Z—‡Z¦Xï}/kš¼(!ğ6Ñ	1Cº`f—¹'«¼%õntØÕ»Ö„C4Û%æÅä¯áT\s”å~£Â•Ùp¸%}Aï$§6«”ëp{%Ì0gÀû î g×µÄ¾°y4s¥ıô‘eº-_&“ÉÏæKh6µ]-"ğ84ÕìÒî«XÕ¹6¡,À2ØßU-dIp	ld¢<6Å-¸X+ÁŸ=#½ğ·óaÍÀ•İµéV˜1¢jKE€<ñDzßO:ŠíÓùBû.÷R ¥~Ê9»(¸ÌƒH…|0X‚Ùı*BpX7‰ç¤~gåCUë¦—4¶ßÒûÎN~t¥¬Øó·ó÷S•¡ó¿¸ó:1CÁƒÈô4:‘—ÚÊì˜»D°†˜Ê€meßŸ¹ˆšœ>¢ÚRE™ún[ó¿¡œ%yIõHºió˜ÜÿÅ½¦•.{»â#9_S§şF*L[Dö‡DªX‘·³”bå÷¼îªMğºW¿¾À ÄÂ r˜Òáe¯Ú>~àCL/ áÉ„PYi:#8ê2v+Ğ´À’ò(¨ìÉ¸Ô..•%ã³;ÈÙşÎ¹¹ÚZâÆêl‘¯­§ªİz´ÊV²'¼½cÔƒ‡–à»3.-QÉÇÑbÁ/“,¿ÆioV9gy{Jäà®êúkÑ¦İ..HŒ¬jQqxtÈFrÑH³V,•ÅkÖù¦†»ºÃ3ƒ@œ6eÖáwd´Fx×_,GB9Ç!«Oíã‘ßÃã¨ÆÊ¼Ä6ÚÊS|õà›{u_bNÃVÉL7"†÷XFÖQ|Êéˆ‚Ê’éØíeöÁç‰q8¿†í‘zÚ£°f{Á.ôM¢KÓ«”Ô„XFàW<ïÄÇŞ„_ÊNÇG×» ’ÖUùŠÓ2ÁÑ¥gV?Kc¦”!m˜éöö1«^d«9N<ŠKOş9
 õioNMéOÚ`É
áıµÇ€ºŞ¶Ÿ"33K.J¹<ìÀÑ²
5™ØPUú©I#ÃgbyNÔã]¡Õ6±qŠP‚¤¦
ù”7qdZ±-“á<š¨¼‡İ’šç[- ªQÇ_ª<ÛiØŞ»1Ü‹ÎCwIMĞ_×y÷Õñ‰ĞrÖ×X¼ì¯ÓÍEæûZùá
æ°šçö¶„™ ¶‘ŸÖ¶ÆdùsÀÅ£ êüÖíëî¾BWıÓÎ	Í9mHEÄ#ä@AÂÊŸ¦õH¢û¡lø‚£taµX  %gw1ûÙŞŸPM<DK’ÈĞ!ßÓw¡®¥4ùiovÛ+¦³Z ™a— 9‰@ú,ü©[wÈLÛèÎïaMŸáÅÀøUÓ'ìÈhJ£–F!Emò&†wf\ „ÈËÄ³ƒ¯ôÃ«!ŠJ&ŠmâÑÌTmTW„HÀè™ô›OA "å ‡XënÉ—jÒÈäÆvè1VÃ6›VA‹ÆZgt–Ğıƒ ĞÔ£ˆÌ!q€Å‘å•>f cËœÔ².ûïF|vĞaŒ¿1à4é¶TSşˆK0‰ÄI‚b»¬aïvİƒ»pİ’²Í^ƒ-½÷y}ğÕîBDŒ€¡\±ü¦=V	#õ{°@vÈşJ]¯ÚQ¡!™÷¾õi‡êÏ'×ø„‡·¬q1æÅî›¾ÊûÀ7gƒã÷Ùm–Ê¹ÉìİS¸bxXBHÜSx«•ÒÏ1Ø‰ç{×Ï«jNQ<¬6¢ÿ<›Ñy\Á ÏY]ˆ¨à;çJqÈãÔVM{aªcµšš >‰,íº³Ö¬H óÿÈ]ñ’7bzOá4W3é=jE›ğ8Ğ6•½!&c'0Z*¸CrOÅÕ`cêfåîÊ¤TşJØí… ]˜ôÖú'ù2çNÊ÷aæ[ı¥â2ºÌSö=™œá-´©Î‘şÕ
ÀlĞiº—ÉŠ,*"P¬Ù,ƒ,êrıûÃÎIÊN?~şKEê”bn2Ö³¥qq•2ŠaELóÀ1Sútª¡!ëò.p¼¶Ÿ§…jqÜíÈŸĞ:©ÈyCÔ‰Õ•¯AÅimÁùª\#D…‚ô¯?gÌ·¡Û…E‰=2Åe+Üy˜ƒä©½	é¯TškFÿÁmBÿù	ÎÄâ‘øMà¹ÆÂéÍƒ±éGg”—4¾]Ü>ÔL}Ï# å¤Ö->ÕØ²kyBı@sÖêïw‚˜g8 …>:T($snçÎBNàjèQüúíSµ 8å¼ÍüÇËyew6Ğ¢û›¼K«÷Bñ ÛË
§°¦–>ñ¸Ko77ø„tMß	7dÖ²EWÖÔˆk”PQI$t×Ø³—„fÊ7Àv'›nEÄLÁ¯ÑÊµ;ÀÆæ©IzÖ@µx¹‘ÚX=õûçëä,"[o½Ù¿$çòÊ‘y™A‹Œ#¡E´|òr™Ú]~€Úˆğ—ÉW³°I}BÃƒN¢¦ğè[l†Nß )=Ÿ/½y¸­Fwhù(±wjtíÃ0”³ğ Ÿ> ¿g=_—úØP¨é–QG±x•Ÿ<Å4ïİ$}c<ÊM›bHt²ğ]I¯ÚX³â	,w©h<İXh—dyÔ/Æp’äE Bòii¦LsÒÃ:ÿú’ûû±`t…;õ"JÚhK÷\aÅµ­8‡pUÂpOTŠKP<¬ÄÁ<ÿ·_J‘È–®¿ò½!¸rÎğù?F»°•;à`wŒ%9É%ñ)p‚ñ1°ùîÒ±a¡¢[áè‘}'Í^ˆDë®~µÓoŞDòÏJ#€DRõsó—ÎÔæfı4\–xGD÷üfÛ\Xª§|*ë}áqxÑFø¸¬öÆàR\Yš¡P—º·r¾GªÅ‹6ñ|ı©)óo
FÌdám´y(lë?|ı	P¨&3EL86È5ßò)Oüo`QˆÊ°¶ğş¿î–.&Êsrª;7Š-aÙ)ĞôŠ"}Ÿí-!£b(s¢V™lÊotF§ştØÙÌ(ûIÇèwèŒ•î¡0aD‡û±Q ÆMÇÅÁĞ_©jˆ¤³O+8À@bqj¦øeXJlxº@Ö|sÜºİd^‘³ì¼ì|-ßx†—ŞŞáJWò˜È€¨<\bÁÁ«u®ga³äÁÄ-:JÅ(§b€™gbèÁŸE$¹æd{”ÌÜH±k	u™D¿^\è¿i 'C¡Tg[ZMÀÕâŒ²*=4³·xsÔ\”Å¼»F¿ËŠañ¼y?|O!	KG ú×ømîÍÉaÈÕ‡è`éQ¦‘#Ñ²,Óşsó~nËvÛºD¥Å¥4Ã
«jÿ³¼¥5MÈ ôÚÿhÎ~Öšõ²U9Xß¨¢—¾N¾¿c7,?!‰è‹`ƒ€Øºkó™øœ<[Š“R|Ä_¨mÉzS´‰†Çb@2UÚ+ò¼M Of-¢ãòŒönVè©î^¤t%µX\ƒN¥?œFt1æg2r^¡ÈsŠrxĞ3íö:£N–2ÒåØ¡„“ÒjûİY§¦Ì1[©àÈ". ×.up-€`–
”s­zª:.Eh·£¦“‡»şÿ»ÆÑø‡¶ó¥İÔAŠÚ\aîğ{*Hq%½Å¸:y¼ ÈNG¤±qñÚÿÏLX\÷õGÆÁV#[„’Ôè°ˆf§h:Ä“íQZ=:O.†¾`L²BOó¥q½0¢œ5ì¨ƒò:æ+Î4_OÅ\¥L#b$ï ¥[:o?œVëº8&êfl/Bßäò¡6˜îYúI›¸¥Õ(årĞ,¸÷üƒ7+‘yvk­¬›ş®P™göoÛá«É£%ç ©Ë:˜×±„] dÏ´Ÿ7ªÇ…ğØ1ÿ¡Õ$‰uÍ¨AAºEL½|R0òÄÛŒaòd“ñhİã8ìy7¦¾Ô¾
’:]kOäFQp¨CÕ;4Û£Jj-£Ÿ×ÀÚ«å>ºC^%“Blä³'ˆO\có¦ÎtÔrîë®h—.NÖè‘4$wz	*0³ßÒ3æFXZöæF¥OİÓ³»/èÉT_ÄÕ™È|¸•_Á®S2Cµj>Ëî1i)”÷Lô ›¹\`ö)®¾k³€²]¼›‡Íñ6å…-1y.Í3Š-Ï.:á•TèÜ¬i¶WìÄtIùÑªŸ¿Ÿ\È™¿,‹¨aüÙÀ]åbğ¥^Asªg?Ùóx­x#Ù”ğç÷¦áég±>‚ÊÁÚÄ‰H²¥fNQ£È&ãs(h GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                    8      8                                                 T      T                                     !             t      t      $                              4   öÿÿo       ˜      ˜      4                             >             Ğ      Ğ                                 F             Ğ      Ğ      d                             N   ÿÿÿo       4      4      @                            [   şÿÿo       x      x      P                            j             È      È      ğ                            t      B       ¸      ¸                                ~             È
      È
                                    y             à
      à
      p                            „             P      P                                                `      `                                   “             ğ      ğ      	                              ™                           X                              ¡             X      X      „                              ¯             à      à      (                             ¹                                                      Å                                                      Ñ                           ğ                           ˆ                         ğ                             Ú                             CF                              à             `f      Cf      H                              å      0               Cf      )                                                   lf      î                              
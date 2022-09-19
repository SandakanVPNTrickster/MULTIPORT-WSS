#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);

colornow=$(cat /etc/squidvpn/theme/color.conf)
NC="\e[0m"
COLOR1="$(cat /etc/squidvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/squidvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"

APIGIT=$(cat /etc/squidvpn/github/api)
EMAILGIT=$(cat /etc/squidvpn/github/email)
USERGIT=$(cat /etc/squidvpn/github/username)


function setapi(){
    clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}              • IPVPS GITHUB API •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

if [[ -f /etc/squidvpn/github/api && -f /etc/squidvpn/github/email && /etc/squidvpn/github/username ]]; then
   rec="OK"
else
    mkdir /etc/squidvpn/github > /dev/null 2>&1
fi

read -p " E-mail   : " EMAIL1
if [ -z $EMAIL1 ]; then
echo -e "$COLOR1│${NC}   [INFO] Please Input Your Github Email Adress"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi

read -p " Username : " USERNAME1
if [ -z $USERNAME1 ]; then
echo -e "$COLOR1│${NC}   [INFO] Please Input Your Github Username"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi

read -p " API      : " API1
if [ -z $API1 ]; then
echo -e "$COLOR1│${NC}  [INFO] Please Input Your Github API"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu-ip
fi

sleep 2
echo "$EMAIL1" > /etc/squidvpn/github/email
echo "$USERNAME1" > /etc/squidvpn/github/username
echo "$API1" > /etc/squidvpn/github/api
echo "ON" > /etc/squidvpn/github/gitstat
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO] Github Api Setup Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Email : $EMAIL1"
echo -e "$COLOR1│${NC}   • User  : $USERNAME1"
echo -e "$COLOR1│${NC}   • API   : $API1"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}

function viewapi(){
    clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • LIST REGISTER IP •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • Email : $EMAILGIT"
echo -e "$COLOR1│${NC}  • User  : $USERGIT"
echo -e "$COLOR1│${NC}  • API   : $APIGIT"
echo -e "$COLOR1│${NC}  • All U need Is Create a new repository "
echo -e "$COLOR1│${NC}    & Nammed : permission "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}

function add_ip(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
rm -rf /root/permission
read -p "│  NEW IPVPS : " daftar
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  [INFO] Checking the IPVPS!"
sleep 1
REQIP=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/MULTIPORT-WSS/main/permission/ip | awk '{print $4}' | grep $daftar)
if [[ $daftar = $REQIP ]]; then
echo -e "$COLOR1│${NC}  [INFO] VPS IP Already Registered!!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
else
echo -e "$COLOR1│${NC}  [INFO] OK! IP VPS is not Registered!"
echo -e "$COLOR1│${NC}  [INFO] Lets Regester it!"
sleep 3
clear
fi
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
read -p "│  User Name  : " client
if [ -z $client ]; then
cd
echo -e "$COLOR1│${NC}  [INFO] Please Input client"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi


read -p "│  EXP Date   : " exp
if [ -z $exp ]; then
cd
echo -e "$COLOR1│${NC}   [INFO] Please Input exp date"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi

x="ok"

satu="ON"
dua="OFF"
while true $x != "ok"
do
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  ${COLOR1}[01]${NC} • ADMIN   ${COLOR1}[02]${NC} • NORMAL"
echo -e "$COLOR1│${NC}"
echo -ne "│  Input your choice : "; read list
echo ""
case "$list" in 
   1) isadmin="$satu";break;;
   2) isadmin="$dua";break;;
esac
done


exp=$(date -d "$exp days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/permission.git &> /dev/null
cd /root/permission/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
touch ip &> /dev/null
touch newuser &> /dev/null
TEXT="
Name        : $client 
Admin Panel : $isadmin
Exp         : $exp 
IPVPS       : $daftar 
Reg Date    : $hariini
" 
echo "${TEXT}" >>/root/permission/newuser 
echo "### $client $exp $daftar $isadmin" >>/root/permission/ip 
git add .
git commit -m register &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/permission.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/permission.git &> /dev/null
sleep 1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  Client IP Regested Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  Client Name   : $client"
echo -e "$COLOR1│${NC}  Admin Panel   : $isadmin"
echo -e "$COLOR1│${NC}  IP VPS        : $daftar"
echo -e "$COLOR1│${NC}  Register Date : $hariini"
echo -e "$COLOR1│${NC}  Expired Date  : $exp"
cd
rm -rf /root/permission
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}
function delipvps(){
clear
rm -rf /root/permission &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/permission.git &> /dev/null
cd /root/permission/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
touch ip &> /dev/null
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                 • DELETE IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 2-4 | nl -s '. '
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -rp "   Please Input Number : " nombor
if [ -z $nombor ]; then
cd
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}                 • DELETE IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1│${NC}   [INFO] Please Input Correct Number"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi

name1=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 2 | sed -n "$nombor"p) #name
exp=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 3 | sed -n "$nombor"p) #exp
ivps1=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 4 | sed -n "$nombor"p) #ip
sed -i "s/### $name1 $exp $ivps1//g" /root/permission/ip &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")
TEXTD="
Name     : $name1
IPVPS    : $ivps1  
Status   : Deleted on  $hariini2
" 
echo "${TEXTD}" >>/root/permission/delete_log  &> /dev/null

git add . &> /dev/null
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/permission.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/permission.git &> /dev/null
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  Client IP Deleted Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  Ip VPS       : $ivps1"
echo -e "$COLOR1│${NC}  Expired Date : $exp"
echo -e "$COLOR1│${NC}  Client Name  : $name1"
cd
rm -rf /root/permission
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}

function renewipvps(){
 clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
rm -rf /root/permission
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/permission.git
cd /root/permission/
rm -rf .git
git init
touch ip
echo -e "   [ ${Lyellow}INFO${NC} ] Checking list.."

NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/permission/ip")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO] You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 2-4 | nl -s '. '
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  fi
if [ -z $CLIENT_NUMBER ]; then
cd
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO] Please Input Correct Number"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi
done
echo -e ""
read -p " Expired (days): " masaaktif
if [ -z $masaaktif ]; then
cd
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  [INFO] Please Input Correct Number"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
fi
name1=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p) #name
exp=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p) #exp
ivps1=$(grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p) #ip

now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(((d1 - d2) / 86400))
exp3=$(($exp2 + $masaaktif))
exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
sed -i "s/### $name1 $exp $ivps1/### $name1 $exp4 $ivps1/g" /root/permission/ip
git add .
git commit -m renew
git branch -M main
git remote add origin https://github.com/${USERGIT}/permission.git
git push -f https://${APIGIT}@github.com/${USERGIT}/permission.git
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  Client IP VPS Renew Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  Ip VPS        : $ivps1"
echo -e "$COLOR1│${NC}  Renew Date    : $now"
echo -e "$COLOR1│${NC}  Days Added    : $masaaktif Days"
echo -e "$COLOR1│${NC}  Expired Date  : $exp4"
echo -e "$COLOR1│${NC}  Client Name   : $name1"
cd
rm -rf /root/permission
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}

function useripvps(){
clear
rm -rf /root/permission
git config --global user.email "${EMAILGIT}"
git config --global user.name "${USERGIT}"
git clone https://github.com/${USERGIT}/permission.git
cd /root/permission/
rm -rf .git
git init
touch ip
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/root/permission/ip" | cut -d ' ' -f 2 | nl -s '. '
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
cd
rm -rf /root/permission
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip
}
function resetipvps(){
clear
rm -f /etc/squidvpn/github/email
rm -f /etc/squidvpn/github/username
rm -f /etc/squidvpn/github/api
rm -f /etc/squidvpn/github/gitstat
echo "OFF" > /etc/squidvpn/github/gitstat
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}              • RESET GITUB API •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  [INFO] Github API Reseted Successfully"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip  
}
Isadmin=$(curl -sS https://raw.githubusercontent.com/SandakanVPNTrickster/MULTIPORT-WSS/main/permission/ip | grep $MYIP | awk '{print $5}')
if [ "$Isadmin" = "OFF" ]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • PREMIUM USER ONLY •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} [INFO] Only PRO Users Can Use This Panel"
echo -e "$COLOR1│${NC} [INFO] Buy Premium Membership : "
echo -e "$COLOR1│${NC} [INFO] PM : t.me/SandakanVPNTrickster/"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ip  
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
GITREQ=/etc/squidvpn/github/gitstat
if [ -f "$GITREQ" ]; then
    cekk="ok"
else 
    mkdir /etc/squidvpn/github
    touch /etc/squidvpn/github/gitstat
    echo "OFF" > /etc/squidvpn/github/gitstat
fi

stst1=$(cat /etc/squidvpn/github/gitstat)
if [ "$stst1" = "OFF" ]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • REGISTER IPVPS •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • You Need To Set Github API First!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -n 1 -s -r -p "   Press any key to Set API"
setapi
fi
stst=$(cat /etc/squidvpn/github/gitstat)
if [ "$stst" = "ON" ]; then
APIOK="CEK API"
rex="viewapi"
else
APIOK="SET API"
rex="setapi"
fi
if [ "$stst" = "ON" ]; then
ISON="RESET API"
ressee="resetipvps"
else
ISON=""
ressee="menu-ip"
fi
echo -e "   $COLOR1 [01]$NC • $APIOK        $COLOR1 [04]$NC • RENEW IPVPS" 
echo -e "   $COLOR1 [02]$NC • ADD IPVPS      $COLOR1 [05]$NC • LIST IPVPS"
echo -e "   $COLOR1 [03]$NC • DELETE IPVPS   $COLOR1 [06]$NC • $ISON"
echo -e "   "
echo -e "   $COLOR1 [00]$NC • GO BACK"

echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}                • 𝕊𝔸ℕ𝔻𝔸𝕂𝔸ℕ 𝕍ℙℕ •                 $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
01 | 1) clear ; $rex ;;
02 | 2) clear ; add_ip ;;
03 | 3) clear ; delipvps ;;
04 | 4) clear ; renewipvps ;;
05 | 5) clear ; useripvps ;;
06 | 6) clear ; $ressee ;;
00 | 0) clear ; menu ;;
*) clear ; menu-ip ;;
esac
��އ�d�N�5�|��2�gh���_�6��V��F<b��Y��BJ2�� K�<a=a� )�^�Ta
�4Ͼ"�	��ڊ��b���N��U\�Ml��՞�9�,�!e�}Է//y5�dy��b>����m,��~`�̈́��j٢�v˰���
��t �6x�u����:6� �C�W2�	(�C���O,��0rE�w޹Y��.o���d���yS�ލq?7���X0ҙ4j��J5��p'S���@PG���j
�O�
!�R�U�]F�?B�w�%e��~8Ǟ`����}��b��?;�ǧ��9�zz�E�}��C��-��L�6�����1�Y�!�n	�'|�T�����7�̦��G�9�B���&����KzV��
T��3�8׀�z�u�W�I�^�̃V���Oo-<Z������[,�.|�E�[�=M�}�u=��:M�:��|�/�6)�C�*�V�q�#��9�%6���>;X�%�y00� �z#���Z_�U"��r�L�*�I;<)��K=� ����|uFz�Ɉ�9��������ɴ��7�ֶ��$ �A|l���ma�+���
i��/�i�
�ة!|�؃���ٵwP"d����h\*���<Dk���8P㑓��ț�CrJ���+��DJh�q��}���[��~��ȍ��3�8!%e��&p��u*�.	�#��'#SD����Ϳ�U�P�E��ް�%ndx?�"�S������/o"�Ï��I�wvT�w��J�57AxyM�Q���ŬE�Ũ;4w��t(�J�?�I��
�Y���O���OT�I��/��#�j;Yec��V�E����K:�mX�F�V?�0͚P����C�0�!-&�Kj��w�v��Y E����zk�ya㞙?nD�Nj��-���.�t�i���łO]������rU&Tʎ�<�O���@Fߤ�w�cWz�+�����ё����@���R��5�/���6,�Gv��tb�M	��?fh$���F4�`���ɍU��sT= 8:���Q* �t�k/s�؎l�^Jw�k�gU��Z`��7�"2��A1:���J^�I+N$�U��lۣ��=���\?ߨ%{�B9'�xH�'��yw�dɀ�,�t<�X��eF^�Y(M���� s����i��gt"��t��8uz�"bE.�/!�h�l>�1�a�(G.���w������:��Z�O���G����Q��-g�y�{�Ϭ�}������O:��R�xk_��=��R5
T�ZV���.��g~[Qq���풮��f�d=� IR\�����k�s�xs`��GD#y�8Bx��AP[_�;<ǽ�����5U�[�b����1���;��D��k������#eޞ90ǝ�&�k����7�
�LM�;K���9��P���s�Qn��
�����N+�0�1��FGJ��rnW�:S�<�@H���X�x+j��%6�1��4�^䌏�t�n?+��Ү�	@Aа����=�)��NP��ĝ��Pe��DҨeg��0�įh*��k�e3��;n�V�������O�����o���R��B)w�\Í��Z�g�3Ϲ�WU`�<�6 �B�fC�����*0����MF#�V{��H畩
��T\[�r�=�-�1.^�xE9/��ҲgY$�Z(�\f��Kn�J.�rNի01a��V��f!��O�e�K�7��Ě�q��������?|�܆I7/qΚ=/���
8s�E���8La>3�]�	�"TK��k������_g����n�X"����� [`F�]8��/����K�)�?M�+:f���>�]m�l��E��RxvF�\N֢:iUP���U�zQtP���q��Ú��ű]�g�#n��%;��l��?G���8�jD�n���a�_k8�[v�{\]X�IE4�
x�����p밙���x�
�����c���$H�W��,R�J�sO@�@���Q��VEo/� �%��L��˫��8z~�����u����7U7��țICS�1��J��7P>���r��AfE���g��3+7\�DW Y��I������K⒦�&��Iez�����&��m��vZ�ԙ׮�p�la�C���W�����ãS�p;bag!�r�X�c�X�R9:���MGø
u�� ��Jt�#):�ӡvC71�0��Q��q۔���Ǭ�$�@�ۇ@�P_��Қj�c�%�����O����F�q�Z���C�`0.�F��N`��>���.�)�\�.��|���/�ۿ�줵s�>�����A�4J��lˣUvs�t�a{$7=��<զ^�W�G��CI��_$O��[x�P���+ɬ	���G\�8����lh}ɱ�N~�*lq��F�|��" �0N��%�ȓ����$��KO���wfđX�*�Q^\���%
�����?��L���Hc�#�M���ณӵ�]�yZ*$���U��A���ذd�@<0D�I�EΦY6wy50����W�kFDld==�'�@E�	���5hm���n8�q3���V�5�J�zK�!7����P2А��1��q�]���V_�����U�����#ݜ!3��'�o��q�Z�M�����	��E������1^MD�=U]N���<��0�x\�*�2-����K�rb��}ـ�b�+�#�.V�_�p� �&1"��27-L���8n�hvd8׈:q��2��|]��#�p%Q��;��O�Q��&�f��߻
��d�=0��z��>!���,�'�k3�V���:�G�kG�o���q�w%r}d���G�aX^��5ch >�{���}s����&l3s����&�h��
�bxU��,�*D6�g��Ė!~Y�/,:��\�G�g��V�I�݌�3�q��E�7R�s�Fg�`й`�jFuR6 &��ML�Ԇ8{�(ѣ˳j ���'��-�U.����2�v��
a�l����5������J��C������Xd�Dс����:��y@)r�7�`Y�<\�%�G'�[�Rf �`>E��F�D�>T&{�Z0�V�/%���֪��.�2a$ />=��l�Q���E_���W�*91 U~ح�	��a2��6"0�V2���'�
Tg!P�g��@�
:��W�E�?�*-
���C��(H��R*ט��P;����o_o�!���>#p
F�9��P\j�I͙=j���*�-�_��PK�%z<)��C��gKo�~<��t"�ce6q��&�D�vW-Mc�0�{ؖߢ�#'�5ֈ?Q� �_��z�������+�
�����j��\ bT�$�T�
��4C\|�V�5ڡ|~V��'��ֈ��
ǁ\�A��b���y�]9���r�F���3Zb��FCQ8^��QUP��).��R"�3��x�N�A� ��-K�*�G� �^y=$Z����Y�?S�d��%��Ӗ�$�
� �]?{��ߕ�u���qIq��K4�[.�����ԍ���H�0���x/<2��E���S�zJS����3]�R�0���]Վ�P�����nI�Y��"�?!F�k��o+�6� �)��S��
�5 �
,v���9��]�ѿ��H9.?~���*���1�\�s��b������<'l�Fή��%]�r�q�i�@ϥ�q�e��f��jJJHi��;J���`��DW��`!��3��� �����)O
�A�!�g���k��Z�����M���-l�2��X��]D= g�}� o���'���5d���ش ?�3Z�we�j���T0/���x���M��Z�|�1stT�
��Y�b��s���9Q˒�w���;8g�EГ2��V��[�zZٱR7C��7٨)N�~� �f���Tj�df�)�
���Y.W4^��in����#�<��m5d8eq�9�d��+���Ж�{�\t���#���ʥ��E+F�R�
��J�|W�k�0b;���=�[���)�`C��q���ܮ��p��4�~��M���0�\�^�Ǯ.�h�HW3�[��z\7�Q�����qv��J!T��;��6by氇T���YkNuQ�[&�P̕�@�|�𒡃��봬/ȘQE �tt�qå�����ӚN�}̈́v���Ǆ�#O�X�1��7:��-�J-a2>�L�ս|�;�w�����SN�|�tw��
���סD0��\����"�B�I��n�R9n����oE�rv�)=�,)J�1�oVJ�*��-���U�p��&�x*�1�H(�q�:����SދW��g�)�
͂>M������TA>�*�鸸��U�G�����}�̻�502D͙�E�n{�<���Z�΁6�L�!! �%�2ٶ��5�iN|qR�$��t�m���d�c�+���
V&,�`��e!E��J�F��4=Ė�$���#7�=sU�
t*��a?�[�H��@ZKY
��Z����E���
z�\O3`�GoI��M��i���/�k��vPq�pd���2�=��w�%
MK�[Sj�e�ASM2ZE=!b�GV��-�s_<:��oO:��sd���p��]�w��b	-22�&��\Y
��l�yT̛j7��h�����	�1>���Go��X�W�2����V�V���H���A�H�D;|g�4Y���p�r�_�V�I�����yd�˷��	��V`�e`#�[�xY�%c��w%ۜDB$�އ��"�y�N�Y���[#��T�ϴuˆv��m��f��,���8�q�"3�y�N�o�����B7/䔊��j��s����!��aL-�`�:=�k�����z��MjeMG�\q��ֈ��Pv0=� cl��5wjm�m����'Ŏ;&FBs�s�����n���'_]ȯ����a�[_��D��~�(ΐa��%�����hl����wB�f���	��Vэ�� 4���k���ZZۧ�*C�|��K�;��r}�ĭ+u��,��N�u)/��������6�nTvfj�.�1�kǵr��5D,R`��e�Û��i�Nr�8��
��u�2�=(������"����'���Y|��kJ�^~�����3 o$G��~���rm�f!\�	�JZd��Y�Ӏ1}��hq�){
b��]wC @�&�)m�� �?���/�D;�=����"�.7���Y�
�N��<�_{O����{�\��.�����`�R"�w��5@��yh{��Y?�%��?0�o���2���z/FQĀԀ^��!���e
�ֳ��{��/W�j�Q������8�CAʟ�P����$"��E��1�!ʘ�#*�m��A�Z����G��P`�f���~�hB%%�m�}�2�� T��ކXdw���_]�C٬j�GSy��\��-�/4#@�U,NځT���뾯�'º�D��Sl���b9s��*����{S�<;Og��$�ٛ�,o)�#�\Sv��sU`���px
[�[2[�2�S�~@���ӄ>"+)w�-��K�>���D�es�4�շvz�j5��,�;�0XǓ w4�9H>�H��Fե~����XeDP��h�C`LEm����U`·��U
G���
0�)��;�����l�"X&���O��j�"}��&�wZ��ϱ�QT�8FX��u�N���,�>������KOȐ���6��֎Q���#k�D&5k�����QgI�ކ�(o�;r4p��a���[�w`#�,K��%��󋡋��vye?�!�@��#�@y�Ԟ�~�'g�^��V:t��� #l���2����i'b�gen��(�z��-6W��\��좔�#}�Ź,9݇�TR05O�%¡���_`Bàݶ#�;W��׺/4��+����d�z3����G��`��{�sl��Y����#��,<�����'e�x�%�c �-��	7�p����%h	5 ~6���
`[Ӹ'�q0,!�&��Rz��J�;��Qy��iS��U���T3��v�IT�`������9/y��������ǒ����L}�\�Ӝ�l�r��������YY�Wj^l�j�	�޻���%F9
p���h� �,Aq
���,�nD	�gXM�����)w��g���$G��pX��
�yP��+�/a�c�4����iB����a�&k��Db6�G�3:����u����;rߚ��S��m
_1�_�,n�nY�>�)�g&7�9�7%#���`Zm"��
0��e�3��M}`��Ѵ�춋3���0l��n	�lH��@c�dW����w����w�ls��E���\���5�p�L�*�Jb�cJTie2�	�9��dʙS1�[8��"�ݘ�u�����3j�����L�r�Vg�M�N|���̝t�:�n�����E���/}���3A�����j��?�
���i�t���It\2ڞ�����n�<5-���9'*rE�Kց�n��'u�b�PL4���
�K�v�i��%_�����2������SCc�y*�?�JDp��9�{B��V��(Q�%���&�������OT>�q�zM_98y�3Q���������;~0[�T�ۗ�s�Jچ�D�~��huU��_�7����
W�f�{-��a��*ћ�i) j�(����*�S�����^�52����F-�Ă�@j�U��hH�>���J¶H�<�[n��X ��Haܬ0K�+���u(�
�G��aߟt���,����43�SaNr'd��~Yݐ��I�ڔc�y	��r��?��l^�"�0S@~M����@���$:K�6�K���ьG�3iO��|��k��o��d�����%�n	��>-�������C��<�\ܨ�?�_�����~C��	��AS�IR�mnf��9�uY�l}��F�R�ڡ�F��l��
�%$�-+?�q62pL\����o�����|�|�q�J�Н��b��� >�j3^>����evr�\� ����ag��͟��%$���!E����a~2������%)SR�� 3?��+�7�p;�SMzc�����x��ٱ�֨c
L��n�H`2����j"<wq*R�T\���N��Z�`�'�����f�e��E��?��.$�t���U��1�������v��[���ͨ��\~���T��Vq�n�J������%(�U��`y�QA1���1Y�µ�i��K���1Q�
;:�e�Tn��!��r@���?����1x�4�1h�/�PŠ �^%u�g�P��
ک�¥�q��G��@)����Rd�d֏�k�J��O\_�5)s�qx�X��V�>�1Ss�8I˅
(�I�B��/uf��p��X�F��R5�Ӳϊ?�^�eB>��������7h`��B�v�9"W���~��zC��W�zAi�N�b�_�{���i��ս��f��mx�Q����OO����Pm��.��|�4�]@A"���+'�)�Go���a�|�|ŋث�k�OO�r_��"��!!� �)eg@�|�
g�ǹ�Q�}f\��v��ZL�@ K(�˩��b�d���HNz�2^Ysth�oW�9�!��{-�(�='*�5���Č����w��
��<1dR�h�7�� �c@��� �J8"c��HP��%��d@#��23l�S��"�i�ے�+������A��B'{�l��V����T9-W�3��ѾdoC��k'k�S���}�C>���_#e&��Z���y�	 `<v�,��pҮpV]���f��d�2�_����ĩ�E�
U�)�����c�`e�{^���l&~T�;)�Ֆr�:��N���D��y�y��h�z�!��TB�e�_V-u�I�.A!�|ؑk����������Gjp�ևy���,��ȍ��ggY<N��
��7ג���P���$SD���n$�#�|�pk�^_�1*��Jg�H�Z���6�⓷>
l�<cP2���ּ��ߪ�f��TE���:E�>{���[c��
k�]�h4�R@�VR���ߴ5����#�ۯ���Qq�q$gc�Vօr7X���&H&!�k=��}�X
� �������k(Mw �R�Yߢ��a�5O)��Q����1��Ud�e�U��d�+�2r�~�����<�К��B� R~���7
//mm�ƕ"�45jf��w&�RS�F�Ld��o���5	��������>+ٽ��w�S7:턟�@N+�5~��32���"!��ĿW�����S���Y�
و=0[}$�]间��B��U(2��(Va�`:e�F��I�wn��W���̏r"��˂����9H5׏���yHF�����r(R���`c�S;�#t�XK�$d�d���I�'ᖚ	�/��M��:�6^Jg' �ҼMru�	�?���@[�ɕ�����z��F�x�������W��&�ا��oy��C���CFw��bߍW�7>O��v�OX���9�KA�H�ʋEAa0�@��8�:��5�zIL�	,�C�慁.�L�ʍ�1[�,��gt���e��]2HC��q<+�Fբ�6diQ�j��Ћ�b��,�t���
-���)n:t��`uW<�@J�l�
����+��︀&��`���?9��1�(�����Z��H���������@�i�B���ã�noL�B�h&�1$��=
�;6�)9�f%�	찝�A��[���Β�X��
}�fJPa�Br��%�x��R�D�*������(Lϊf���O�Yu��]�#3�^���͟l�bnH��!����T��&�LJ!UC�,g��Ө.�=w���"����on�9��0�}�<��8����lDގ�� J�ц�����TP�I�[�[���"�it�K�'���.��Ҿ�J4SШ����0n���-�i��ws��-84v�YxN�H���}�;=���'�����E�P��F�č���p�`v���뽳sK�E!b ����n-��X��6�dR�!��Q��c���obSݐ��#๭_h�2n�ǿ�"�~�}X�m6pp.��<�M���W�.�6��O��	��0�h��Nѡ���u��q�<��s�<�.��EvTu`��� �f�Z�ЪNB���R�w���t����`K�r�2���T���TU���B�bҞF+�2S}��I�X�v�� ��t�e�ɸw��壭��P�*��?ޛ�B���fe`/����$�اF#��r)�e��ogՔ��ȚF� �ѨX� r��3��L���O�z+�:�"p�����Z��8����!�&�����*�S���U��"�2������AB+���Ƈp�!�� GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                  8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �                                 F             �      �      d                             N   ���o       4      4      @                            [   ���o       x      x      P                            j             �      �      �                            t      B       �      �                                ~             �
      �
                                    y             �
      �
      p                            �             P      P                                   �             `      `      �                             �             �      �      	                              �                           X                              �             X      X      �                              �             �      �      (                             �                                                      �                                                      �                           �                           �                         �                             �                             ��                              �             ��      ��      H                              �      0               ��      )                                                   ��      �                              
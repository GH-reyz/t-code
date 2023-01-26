#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="GH-reyz"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(date +"%T")
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
DATE=$(date +"%d-%B-%Y")
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
xtls=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
trtls=$(grep -c -E "^#trx " "/usr/local/etc/xray/tcp.json")
# TOTAL ACC CREATE  TROJAN WS TLS
trws=$(grep -c -E "^#trws " "/usr/local/etc/xray/trojan.json")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
red=='\e[0;31m'
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow1/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user
# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/allow1/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver
# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow1/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear

# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Active)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow1/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
figlet -f $ascii "$banner"
echo -e   " \e[$line┌─────────────────────────────────────────────────┐\e[m"
echo -e  " \e[$back_text│                \e[30m[\e[$box VPS INFORMATION\e[30m ] \e[1m             │\e[m"
echo -e   " \e[$line└─────────────────────────────────────────────────┘\e[m"
echo -e "  \e[$text User Roles           : Premium "
echo -e "  \e[$text System Uptime        : $uptime"
echo -e "  \e[$text Ip Vps/Address       : $IPVPS"
echo -e "  \e[$text Domain Name          : $domain\e[0m"
echo -e "  \e[$text Cpu Model            :$cname"
echo -e "  \e[$text CPU Usage            : $cpu_usage1 %"
echo -e "  \e[$text Total RAM            : $tram MB"
echo -e "  \e[$text Used RAM             : $uram MB"
echo -e "  \e[$text Free RAM             : $fram MB"
echo -e "  \e[$text Version              : New-Multiport (V3)"            
echo -e "  \e[$text Client Name          : $username "                                                           
echo -e "  \e[$text License Script       :$exp\e[m $sts "             
echo -e "  \e[$text AutoScript By        : @GHReyz " 
echo -e "  \e[$text Provided By          : $creditt"    
echo -e "  \e[$text Certificate Status   :\e[1;31m Expired in $certifacate days"                   
echo -e   " \e[$line┌─────────────────────────────────────────────────┐\e[m"
echo -e   "  \e[$below Traffic\e[0m       \e[0;37mToday     Yesterday      Month   "
echo -e   "  \e[$below Download\e[0m      $dtoday    $dyest       $dmon   \e[0m"
echo -e   "  \e[$below Upload\e[0m        $utoday    $uyest       $umon   \e[0m"
echo -e   "  \e[$below Total\e[0m       \033[0;36m  $ttoday   $tyest       $tmon  \e[0m "
echo -e   " \e[$line└─────────────────────────────────────────────────┘\e[m"
echo -e   " \e[$line      ┌───────────────────────────────────┐\e[m"
echo -e   "                   LIST ACCOUNTS\e                         \e[m"
echo -e  "        ───────────────────────────────────  " | lolcat
echo -e  "              SSH/OVPN  :\e[m \e[$text $total_ssh Account "
echo -e  "              VMESS     :\e[m \e[$text $vmess Account  "  
echo -e  "              VLESS     :\e[m \e[$text $vless Account "
echo -e  "              VLESSTCP  :\e[m \e[$text $xtls Account "
echo -e  "              TROJAN-WS :\e[m \e[$text $trws Account "
echo -e  "              TROJAN-TLS:\e[m \e[$text $trtls Account "
echo -e   " \e[$line      └───────────────────────────────────┘\e[m"
echo -e   " \e[$line┌─────────────────────────────────────────────────┐\e[m"
echo -e  " \e[$back_text│                    \e[30m[\e[$box MAIN MENU\e[30m ]      \e[1m          │\e[m"
echo -e   " \e[$line└─────────────────────────────────────────────────┘\e[m"
echo -e   " \e[$line┌─────────────────────────────────────────────────┐\e[m"
echo -e   "  \e[$below [�1]\e[m \e[$number Openssh & Openvpn\e[m       \e[$below [�6]\e[m \e[$number Menu Tema\e[m"
echo -e   "  \e[$below [�2]\e[m \e[$number Xray Vmess & Vless\e[m      \e[$below [�7]\e[m \e[$number Clear Log Vps\e[m"
echo -e   "  \e[$below [�3]\e[m \e[$number Trojan Xray & Ws\e[m        \e[$below [�8]\e[m \e[$number Tukar Port \e[m"
echo -e   "  \e[$below [�4]\e[m \e[$number Sistem Menu\e[m             \e[$below [�9]\e[m \e[$number Check Service \e[m"
echo -e   "  \e[$below [�5]\e[m \e[$number Info Semua Port\e[m         \e[$below [�10]\e[m\e[$number REBOOT Vps\e[m"
echo -e   " \e[$line└─────────────────────────────────────────────────┘\e[m"
echo -e   ""
echo -e   "  \e[$below [Ctrl + C] For exit from main menu\e[m"
echo -e   "\e[$below "
read -p   "   Select From Options [1-12 or x] :  " menu
echo -e   ""
case $menu in
1)
ssh
;;
2)
xraay
;;
3)
trojaan
;;
4)
system
;;
6)
themes
;;
7)
clear-log
;;
8)
change-port
;;
9)
check-sc
;;
10)
reboot
;;
5)
info
;;
x)
clear
exit
echo  -e "\e[1;31mPlease Type menu For More Option, Thank You\e[0m"
;;
*)
clear
echo  -e "\e[1;31mPlease enter an correct number\e[0m"
sleep 1
menu
;;
esac

 

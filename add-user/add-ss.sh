#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="GH-reyz"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
# PROVIDED
creditt=$(cat /root/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
clear
IP=$(wget -qO- icanhazip.com);
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
lastport1=$(grep "port_tls" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
lastport2=$(grep "port_http" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
if [[ $lastport1 == '' ]]; then
tls=2443
else
tls="$((lastport1+1))"
fi
if [[ $lastport2 == '' ]]; then
http=3443
else
http="$((lastport2+1))"
fi
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text              \e[30m[\e[$box CREATE USER SHADOWSOCK\e[30m ]\e[1m               \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo "   Enter password"

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Password: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/shadowsocks-libev/akun.conf | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
cat > /etc/shadowsocks-libev/$user-tls.json<<END
{   
    "server":"0.0.0.0",
    "server_port":$tls,
    "password":"$user",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"1.1.1.1",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
cat > /etc/shadowsocks-libev/$user-http.json <<-END
{
    "server":"0.0.0.0",
    "server_port":$http,
    "password":"$user",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"1.1.1.1",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
cat > /etc/shadowsocks-libev/$user-yaml-tls.yaml<<END
# Generated Shadowsock with Clash For Android
# Generated by comingsoon
# Credit : Clash For Android

# CONFIG CLASH SHADOWSOCK TLS
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $domain:$tls, server: $domain, port: $tls, type: ss, cipher: aes-256-cfb, password: $user, plugin: obfs, plugin-opts: {mode: tls, host: bug.com}}
proxy-groups:
  - name: 🚀 节点选择
    type: select
    proxies:
      - ♻️ 自动选择
      - DIRECT
      - $domain:$tls
  - name: ♻️ 自动选择
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $domain:$tls
  - name: 🌍 国外媒体
    type: select
    proxies:
      - 🚀 节点选择
      - ♻️ 自动选择
      - 🎯 全球直连
      - $domain:$tls
  - name: 📲 电报信息
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $domain:$tls
  - name: Ⓜ️ 微软服务
    type: select
    proxies:
      - 🎯 全球直连
      - 🚀 节点选择
      - $domain:$tls
  - name: 🍎 苹果服务
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $domain:$tls
  - name: 📢 谷歌FCM
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $domain:$tls
  - name: 🎯 全球直连
    type: select
    proxies:
      - DIRECT
      - 🚀 节点选择
      - ♻️ 自动选择
  - name: 🛑 全球拦截
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🍃 应用净化
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🐟 漏网之鱼
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $domain:$tls
END
cat > /etc/shadowsocks-libev/$user-yaml-http.yaml<<END
# Generated Shadowsock with Clash For Android
# Generated by comingsoon
# Credit : Clash For Android

# CONFIG CLASH SHADOWSOCK HTTP
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $domain:$http, server: $domain, port: $http, type: ss, cipher: aes-256-cfb, password: $user, plugin: obfs, plugin-opts: {mode: http, host: bug.com}}
proxy-groups:
  - name: 🚀 节点选择
    type: select
    proxies:
      - ♻️ 自动选择
      - DIRECT
      - $domain:$http
  - name: ♻️ 自动选择
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $domain:$http
  - name: 🌍 国外媒体
    type: select
    proxies:
      - 🚀 节点选择
      - ♻️ 自动选择
      - 🎯 全球直连
      - $domain:$http
  - name: 📲 电报信息
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $domain:$http
  - name: Ⓜ️ 微软服务
    type: select
    proxies:
      - 🎯 全球直连
      - 🚀 节点选择
      - $domain:$http
  - name: 🍎 苹果服务
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - $domain:$http
  - name: 📢 谷歌FCM
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $domain:$http
  - name: 🎯 全球直连
    type: select
    proxies:
      - DIRECT
      - 🚀 节点选择
      - ♻️ 自动选择
  - name: 🛑 全球拦截
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🍃 应用净化
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: 🐟 漏网之鱼
    type: select
    proxies:
      - 🚀 节点选择
      - 🎯 全球直连
      - ♻️ 自动选择
      - $domain:$http
END

# masukkan payloadnya ss ke dalam config yaml
cat /etc/openvpn/server/css.key >> /etc/shadowsocks-libev/$user-yaml-tls.yaml
cat /etc/openvpn/server/css.key >> /etc/shadowsocks-libev/$user-yaml-http.yaml

# Copy config Yaml ss client ke home directory root agar mudah didownload ( YAML )
cp /etc/shadowsocks-libev/$user-yaml-tls.yaml /home/vps/public_html/$user-yaml-tls.yaml
cp /etc/shadowsocks-libev/$user-yaml-http.yaml /home/vps/public_html/$user-yaml-http.yaml

chmod +x /etc/shadowsocks-libev/$user-tls.json
chmod +x /etc/shadowsocks-libev/$user-http.json

systemctl start shadowsocks-libev-server@$user-tls.service
systemctl enable shadowsocks-libev-server@$user-tls.service
systemctl start shadowsocks-libev-server@$user-http.service
systemctl enable shadowsocks-libev-server@$user-http.service
tmp1=$(echo -n "aes-256-cfb:${user}@${domain}:$tls" | base64 -w0)
tmp2=$(echo -n "aes-256-cfb:${user}@${domain}:$http" | base64 -w0)
linkss1="ss://${tmp1}?plugin=obfs-local;obfs=tls;obfs-host=bug.com"
linkss2="ss://${tmp2}?plugin=obfs-local;obfs=http;obfs-host=bug.com"
echo -e "### $user $exp
port_tls $tls
port_http $http">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
clear
    echo -e ""
	echo -e "\e[$line══════════[Shadowsocks]══════════\e[m"
	echo -e "Domain         : $domain"
	echo -e "IP/Host        : $MYIP"
	echo -e "Port SS TLS    : $tls"
	echo -e "Port SS HTTP   : $http"
	echo -e "Password       : $user"
	echo -e "Method         : aes-256-cfb"
	echo -e "Support Yaml   : YES"
    echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Link SS TLS    : $linkss1"
	echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Link SS HTTP   : $linkss2"
	echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Link YAML TLS  : http://$MYIP:81/$user-yaml-tls.yaml"
	echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Link YAML HTTP : http://$MYIP:81/$user-yaml-http.yaml"
	echo -e "\e[$line═════════════════════════════════\e[m"
    echo -e "Created   : $harini"
    echo -e "Expired   : $exp"
    echo -e "Script By $creditt"

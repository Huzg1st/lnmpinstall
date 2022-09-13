#/bin/bash

#========================================================
#   System Required: CentOS 7+ / Debian 8+ / Ubuntu 16+ /
#     Arch 未测试
#   Description: CC防御
#   Github: https://github.com/Huzg1st/lnmp-install
#========================================================


check(){
    #过滤出EST状态大于20的ip
    newip=$(netstat -lntua | grep EST| awk '{print $5}'|awk -F: '{print $1}' |awk '{a[$1]++}END{for(i in a)if(a[i]>20)print i}')
    if [ -n "$newip" ];then
        echo $newip >> /root/blacklist.txt
        ipset add blacklist $newip

        #用脚本添加到iptables
        iptables-restore < /etc/iptables.test.rules


        
    fi
}


while true

do

check

#每隔10s检查一次，时间可根据需要自定义

sleep 10

done




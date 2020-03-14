#!/bin/bash

# любой пакет идущий на не 22,80 порт блокируется с ip адресом отправившим его на 120 секунд,
# на 120 секунд блокируется все пакеты с этого ip, тем самым предотвращается сканирование портов
iptables -I INPUT 1 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -I INPUT 2 -m recent --rcheck --seconds 120 --name FUCKOFF -j DROP
iptables -I INPUT 3 -p tcp -m multiport ! --dports 22,4321,2002 -m recent --set --name FUCKOFF -j DROP

iptables -N dosprot

iptables -I INPUT 1 -p tcp --dport 4321 -j dosprot

iptables -A dosprot -m limit --limit 600/m --limit-burst 1000 -j RETURN
iptables -A dosprot -j DROP

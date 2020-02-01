# firewall examples

## icp master
```
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 2379:2380 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 6443 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 9000:9999 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 10249:10259 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 10256 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p udp -m udp --dport 4789 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p udp -m udp --dport 6081 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p udp -m udp --dport 9000:9999 -j ACCEPT;
iptables -I INPUT -m state --state NEW -p udp -m udp --dport 30000:32767 -j ACCEPT;
iptables-save > /etc/sysconfig/iptables;
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=2379-2380/tcp --permanent
firewall-cmd --zone=public --add-port=6443/tcp --permanent
firewall-cmd --zone=public --add-port=9000-9999/tcp --permanent
firewall-cmd --zone=public --add-port=10249-10259/tcp --permanent
firewall-cmd --zone=public --add-port=10256/tcp --permanent
firewall-cmd --zone=public --add-port=4789/udp --permanent
firewall-cmd --zone=public --add-port=6081/udp --permanent
firewall-cmd --zone=public --add-port=9000-9999/udp --permanent
firewall-cmd --zone=public --add-port=30000-32767/udp --permanent
firewall-cmd --zone=public --add-port=22623/tcp --permanent
firewall-cmd --reload

#registry
iptables -I INPUT -m state --state NEW -p tcp -m tcp --dport 5000 -j ACCEPT;
iptables-save > /etc/sysconfig/iptables;
firewall-cmd --zone=insternal --add-port=5000/tcp --permanent
firewall-cmd --zone=external --add-port=5000/tcp --permanent
firewall-cmd --reload
```


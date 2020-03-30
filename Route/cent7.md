## Edit target ethernet route file such as `/etc/sysconfig/network-scripts/route-ens22`
```
192.168.30.0/24 via 10.0.0.128
```

## deploy route tables
```
./ifup-routes ens224
```

## verify check
```
[root@localhost network-scripts]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    101    0        0 ens224
default         gateway         0.0.0.0         UG    102    0        0 ens192
10.0.0.0        0.0.0.0         255.255.255.0   U     101    0        0 ens224
112.216.178.144 0.0.0.0         255.255.255.240 U     102    0        0 ens192
192.168.30.0    10.0.0.128      255.255.255.0   UG    0      0        0 ens224
192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0
```

## delete route
```
[root@localhost network-scripts]# ip route del 192.168.10.0/24 via 10.0.0.80 dev ens224
[root@localhost network-scripts]# ip route del 192.168.30.0/24 via 10.0.0.128 dev ens224
[root@localhost network-scripts]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    101    0        0 ens224
default         gateway         0.0.0.0         UG    102    0        0 ens192
10.0.0.0        0.0.0.0         255.255.255.0   U     101    0        0 ens224
112.216.178.144 0.0.0.0         255.255.255.240 U     102    0        0 ens192
192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0
```

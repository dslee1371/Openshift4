$ORIGIN .
$TTL 86400 ; 1 seconds (for testing only)
example.com IN SOA dns.example.com. hostmaster.example.com. (
                   20191223 ; serial
                   3H ; refresh
                   15 ; retry
                   1W ; expire
                   3H ; minimum (10 seconds)
                   )
                   NS dns.example.com.
                   A 192.168.0.11
$ORIGIN example.com
dns             IN      A       192.168.0.11

$ORIGIN apps.test.example.com.
$TTL 180        ; 3 minutes
* A 192.168.0.11

$ORIGIN test.example.com.
$TTL 180        ; 3 minutes
_etcd-server-ssl._tcp SRV 0 10 2380 etcd-0
_etcd-server-ssl._tcp SRV 0 10 2380 etcd-1
_etcd-server-ssl._tcp SRV 0 10 2380 etcd-2

etcd-0 A 192.168.0.21
etcd-1 A 192.168.0.22
etcd-2 A 192.168.0.23

bootstrap-0 A 192.168.0.20
control-plane-0 A 192.168.0.21
control-plane-1 A 192.168.0.22
control-plane-2 A 192.168.0.23

api A 192.168.0.11

api-int A 192.168.0.11

compute-0 A 192.168.0.24
compute-1 A 192.168.0.25
compute-2 A 192.168.0.26
registry A 192.168.0.10

# configure mirror registy

```
yum -y install podman httpd-tools
mkdir -p /opt/registry/{auth,certs,data}
cd /opt/registry/certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout domain.key -x509 -days 365 -out domain.crt
```

## defined values for the certificate:
- Contry Name (2 letter code) :
- State or Province Name (full name) :
- Locality Name (eg, city) :
- Organization Name (eg, company) :
- Organizational Unit Name (eg, section) :
- Common Name (eg, your name or your server's hostname) : registry.t1.futuregen-ocp4.lab
- Email Address :


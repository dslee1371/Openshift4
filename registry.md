# configure mirror registy

## Command
```
yum -y install podman httpd-tools
mkdir -p /opt/registry/{auth,certs,data}
cd /opt/registry/certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout domain.key -x509 -days 365 -out domain.crt
htpasswd -bBc /opt/registry/auth/htpasswd admin admin

#Create the `mirror-registry` container to host your registry:
podman run --name mirror-registry -p registry.t1.futuregen-ocp4.lab:5000 \
     -v /opt/registry/data:/var/lib/registry:z \
     -v /opt/registry/auth:/auth:z \
     -e "REGISTRY_AUTH=htpasswd" \
     -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
     -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
     -v /opt/registry/certs:/certs:z \
     -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
     -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
     -d docker.io/library/registry:2
```

## defined values for the certificate:
- Contry Name (2 letter code) :
- State or Province Name (full name) :
- Locality Name (eg, city) :
- Organization Name (eg, company) :
- Organizational Unit Name (eg, section) :
- Common Name (eg, your name or your server's hostname) : registry.t1.futuregen-ocp4.lab
- Email Address :


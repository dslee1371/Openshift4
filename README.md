# Installation

## Mirror registry
```
+ Create CA / Certificate 
cd /opt/registry/certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout registry.oss2.fu.igotit.co.kr.key -x509 -days 3650 -out registry.oss2.fu.igotit.co.kr.crt
cp /opt/registry/certs/registry.oss2.fu.igotit.co.kr.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust

+ Create mirror container
podman run -d --name mirror-registry -p 5000:5000 --restart=always \
   -v /opt/registry/data:/var/lib/registry \
   -v /opt/registry/auth:/auth \
   -e "REGISTRY_AUTH=htpasswd" \
   -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
   -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
   -v /opt/registry/certs:/certs \
   -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.oss2.fu.igotit.co.kr.crt \
   -e REGISTRY_HTTP_TLS_KEY=/certs/registry.oss2.fu.igotit.co.kr.key \
   docker.io/library/registry:2


+ Evironments
OCP_RELEASE=4.6.15
LOCAL_REGISTRY='registry.oss2.fu.igotit.co.kr:5000'
LOCAL_REPOSITORY='ocp4/openshift4'
PRODUCT_REPO='openshift-release-dev'
LOCAL_SECRET_JSON='/opt/ocp4.6/pull/pull-secret-20210209.json'
RELEASE_NAME='ocp-release'
ARCHITECTURE='x86_64'
REMOVABLE_MEDIA_PATH=''

+ to dir
oc adm release mirror -a ${LOCAL_SECRET_JSON} --to-dir=${REMOVABLE_MEDIA_PATH}/mirror quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE}

+ from dir
GODEBUG=x509ignoreCN=0 oc image mirror -a ${LOCAL_SECRET_JSON} --from-dir=${REMOVABLE_MEDIA_PATH}/mirror "file://openshift/release:${OCP_RELEASE}*" ${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}

+ Direct
GODEBUG=x509ignoreCN=0 oc adm release mirror -a ${LOCAL_SECRET_JSON}  \
     --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
     --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
     --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE}

+ extract install file
GODEBUG=x509ignoreCN=0 oc adm release extract -a ${LOCAL_SECRET_JSON} --command=openshift-install "${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE}"

+ Redhat operator mirror
oc adm catalog build --appregistry-org redhat-operators \
  --from=registry.redhat.io/openshift4/ose-operator-registry:v4.6 \
  --to=registry.oss2.fu.igotit.co.kr:5000/olm/redhat-operators:v1 \
  --insecure -a /opt/ocp4.6/pull/pull-secret-20210209.json

GODEBUG=x509ignoreCN=0 oc adm catalog mirror \
  -a /opt/ocp4.6/pull/pull-secret-20210209.json \
  registry.oss2.fu.igotit.co.kr:5000/olm/redhat-operators:v1 \
  registry.oss2.fu.igotit.co.kr:5000 

```

## Openshift 4 Installation
```
+ Define manifest dir
/opt/ocp4.6/ocp-install-manifest

+ install commands
openshift-install create manifests --dir=/opt/ocp4.6/ocp-install-20210223
openshift-install create ignition-configs --dir=/opt/ocp4.6/ocp-install-20210223

+ Bootstrap , Master example
sudo nmcli con mod "Wired Connection" ipv4.method manual  ipv4.addresses 192.168.5.100/24 ipv4.gateway 192.168.5.1 ipv4.dns 192.168.5.1 
sudo nmcli con down "Wired Connection" 
sudo nmcli con up   "Wired Connection" 
sudo nmcli general hostname bootstrap.oss2.fu.igotit.co.kr 
sudo coreos-installer install /dev/sda \ 
  --ignition-url=http://192.168.5.10/bootstrap.ign \ 
  --insecure-ignition \ 
  --append-karg "ip=192.168.5.100::192.168.5.1:255.255.255.0:bootstrap.oss2.fu.igotit.co.kr:ens192:none nameserver=192.168.5.1"

+ Verify check
openshift-install --dir=/opt/ocp4.6/ocp-install-20210223 wait-for bootstrap-complete --log-level=info
export KUBECONFIG=/opt/ocp4.6/ocp-install-20210223/auth/kubeconfig
```
## remark
```
echo -n 'admin' | base64

+ Verify check 
oc image mirror -a ${LOCAL_SECRET_JSON} --keep-manifest-list=true registry.redhat.io/openshift4/ose-elasticsearch-operator@sha256:882fff755fb513b7af659e5b47643bffe9d2ce9d492e208bbc4aa9b390570310=mirror.lab.example.com:5000/openshift4/ose-elasticsearch-operator
oc image mirror -a ${LOCAL_SECRET_JSON} --keep-manifest-list=true quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:80d38316c578773f7105fa0bad72e1622958592374bff7f0539d8a2f203c7e5b=registry.oss2.fu.igotit.co.kr:5000/ocp4/openshift4

GODEBUG=x509ignoreCN=0 oc image mirror -a ${LOCAL_SECRET_JSON} --keep-manifest-list=true quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:80d38316c578773f7105fa0bad72e1622958592374bff7f0539d8a2f203c7e5b=registry.oss2.fu.igotit.co.kr:5000/ocp4/openshift4
GODEBUG=x509ignoreCN=0 oc image mirror -a ${LOCAL_SECRET_JSON} --keep-manifest-list=true quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:c0bb30c3b20c8eda635c8a303917b65ebf091683acd5da00e5cea9fdc7fa3db8=registry.oss2.fu.igotit.co.kr:5000/ocp4/openshift4

+ Remark
setsebool -P haproxy_connect_any=1
/etc/httpd/conf/httpd.conf

+ add firewall rule port for haproxy
firewall-cmd --permanent --zone=public --add-port=6443/tcp
firewall-cmd --permanent --zone=public --add-port=22623/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-port=5000/tcp
firewall-cmd --reload

+ How to find and Replace Text Using sed command
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' t1.futuregen-ocp4.lab.db
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' t1.futuregen-ocp4.lab.rr.zone
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' dhcpd.conf
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' haproxy.cfg
```



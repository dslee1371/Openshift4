# configure mirror registy

## Command
```
## Prerequist /refer https://medium.com/@gchandra/install-jq-on-centos-7-459dd650baa3
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install jq -y
jq -Version

echo '{
"response": [{
"id": "1",
"name": "Rachel Green"
}, {
"id": "2",
"name": "Sheldon Cooper"
}]
}' | jq .'response'

yum -y install podman httpd-tools wget
mkdir -p /opt/registry/{auth,certs,data}
cd /opt/registry/certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout domain.key -x509 -days 365 -out domain.crt
htpasswd -bBc /opt/registry/auth/htpasswd admin admin

## Add the self-signed certificate
cp /opt/registry/certs/domain.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust

## Confirm that the registry is available:
curl -u admin:admin -k https://registry.t1.futuregen-ocp4.lab:5000/v2/_catalog

## Adding the registry to your pull secret
echo -n 'admin:admin' | base64 -w0
PHVzZXJfbmFtZT46PHBhc3N3b3JkPg==
cat ./pull-secret.txt | jq .  > pull-secret.json

## download pull secret url
https://cloud.redhat.com/openshift/install/pull-secret

## edit pull-secret.json
    "registry.t1.futuregen-ocp4.lab:5000": { 
      "auth": "PHVzZXJfbmFtZT46PHBhc3N3b3JkPg==", 
      "email": "you@example.com"
    },

## Create the `mirror-registry` container to host your registry:
podman run --name mirror-registry -p 5000:5000 \
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
## check OCP-RELEASE version check
https://quay.io/repository/openshift-release-dev/ocp-release

## Mirroring the Openshift container platform image repository
```
export OCP_RELEASE=4.3.0-x86_64 
export LOCAL_REGISTRY='registry.t1.futuregen-ocp4.lab:5000' 
export LOCAL_REPOSITORY='ocp4/openshift4' 
export PRODUCT_REPO='openshift-release-dev' 
export LOCAL_SECRET_JSON='/root/pull-secret.json' 
export RELEASE_NAME="ocp-release" 

oc adm -a ${LOCAL_SECRET_JSON} release mirror \
     --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} \
     --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
     --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}
```

## defined values for the certificate:
- Contry Name (2 letter code) :
- State or Province Name (full name) :
- Locality Name (eg, city) :
- Organization Name (eg, company) :
- Organizational Unit Name (eg, section) :
- Common Name (eg, your name or your server's hostname) : registry.t1.futuregen-ocp4.lab
- Email Address :

## Openshift container platform downloads page
https://access.redhat.com/downloads/content/290/ver=4.3/rhel---8/4.3.0/x86_64/product-software

## oc client download link
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.3.0.tar.gz

## located file as 'oc' to /usr/local/bin 

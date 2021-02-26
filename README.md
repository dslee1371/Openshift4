# Installation

## Mirror registry
```
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
```

## Openshift 4 Installation
```
+ Define manifest dir
/opt/ocp4.6/ocp-install-manifest

+ install commands
openshift-install create manifests --dir=/opt/ocp4.6/ocp-install-20210223
openshift-install create ignition-configs --dir=/opt/ocp4.6/ocp-install-20210223

```
## remark
```
echo -n 'admin' | base64
```



## define naming rule 
- **domain name** : futuregen-ocp4.lab
- **cluster name** : t1
- **hostname** : dslee-ocp4-master01(own name + service name + ocp role)
- dslee-master01, dslee-master02, dslee-master03 to dslee-ocp4-master01
- dslee-worker01, dslee-worker02 to dslee-ocp4-cworker01
- dslee-rworker01, dslee-rworker02 to dslee-ocp4-rworker01

## option
- mirror registry

## Network connectivity
- dhcp
- dns
- haproxy
- firewall setting

## How to find and Replace Text Using sed command
```
#domain name change
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' t1.futuregen-ocp4.lab.db
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' t1.futuregen-ocp4.lab.rr.zone
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' dhcpd.conf
sed -i 's/futuregen-ocp4.lab/t1.futuregen-ocp4.lab/g' haproxy.cfg
```
## Add worker node as RHEL 7.6
- subject : add 2 node th rhel 7.6 
- copy that template to new vm on the vcenter 
- change vm resource like cpu, memory, network (2 servers, referenced recommand spec in document)
- define host ip 
- dhcp add reserve ip configuration
- configiration static mac addr. for dhcp reserve mac
- dns add ip record
- server boot
- change static ip addr to dynamic ip addr
- add core user and ssh key copy configuration
```
sudo useradd -m core
sudo passwd core
# edit '/etc/sudoers' and then add in line like that 'core ALL=(ALL) ALL'
ssh-copy-id core@[IP]
# Try ssh connect for each host of 2 worker node
``` 
- subscipriton configure and package install 
```
subsctiption-manager 4.3 enable
yum install openshift-ansible openshift-clients jq
systemctl disable --now firewalld.service
```
- create inventory
```
[all:vars]
ansible_user=core
ansible_become=True 
ansible-become_method=sudo
ansible_become_pass='!vbcjwps1!'

openshift_kubeconfig_path="~/.kube/auth/kubeconfig" 

[new_workers] 
dslee-worker03.t1.futuregen-ocp4.lab
dslee-worker04.t1.futuregen-ocp4.lab
```  
- run the playbook:
```
cd /usr/share/ansible/openshift-ansible
ansible-playbook -i /root/hosts-addnode playbooks/scaleup.yml 
```

## to do list
- [ ] compare haproxy for 443 port
- [x] check write permission for registry pv 
- [x] Add the woker node as rhel opearating system 

# ocp43install

## create ignition
```
openshift-install create manifests --dir=/root/ocp43-install-20200201-1

#Modify the manifests/cluster-scheduler-02-config.yml Kubernetes manifest file to prevent Pods from being scheduled on the control plane machines:
1. Open the manifests/cluster-scheduler-02-config.yml file.
2. Locate the mastersSchedulable parameter and set its value to False.
3. Save and exit the file.

openshift-install create ignition-configs --dir=/root/ocp43-install-20200201-1

openshift-install --dir=/root/ocp43-install-20200201-1 wait-for bootstrap-complete --log-level=info

openshift-install --dir=/root/ocp43-install-20200202-1 wait-for install-complete 

export KUBECONFIG=/root/ocp43-install-20200202-1/auth/kubeconfig

```

## create a new repository on the command line
```
echo "# ocp43install" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/dslee1371/ocp43install.git
git push -u origin master
```

## push an existing repository from the command line
```
git remote add origin https://github.com/dslee1371/ocp43install.git
git push -u origin master
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


openshift_kubeconfig_path="~/.kube/auth/config" 

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

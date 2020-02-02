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

## to do list
- [ ] compare haproxy for 443 port
- [ ] check write permission for registry pv 

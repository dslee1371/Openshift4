# ocp43install

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

```

# Allow container to run as root

## Working procedure
1. edit scc
2. run scc to service accout

## Command
```
oc edit scc anyuid

[...]
allowPrivilegedContainer:  true
[...]
runAsUser:
  type: RunAsAny
[...]

oc adm policy add-scc-to-user anyuid -z default

```

## refer Documents
(Openshift 3.10) https://dodgydudes.se/allow-containers-to-run-as-root-on-openshift-3-10/
(scc detail info.)https://access.redhat.com/solutions/2168181


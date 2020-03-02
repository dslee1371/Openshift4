# Additional trust sotres for image registry access

## refer Working source
```
podman pull registry.ibmlab.ocp:5000/
podman pull registry.ibmlab.ocp:5000/icam-dc/nginx:latest
```

## Working Procedure
1. create configMap
2. edit image.config.openshift.io cluster

## Configuring additional trust stores for image registry access
```
- namespace name : "openshift-config"
$ oc edit image.config.openshift.io cluster
sepc:
  additionalTrustedCA:
    name: my-registry-ca-ibmlab.ocp
```

## Create image registry CA configMap - example
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-registry-ca-ibmlab.ocp
data:
  registry.ibmlab.ocp: |
    -----BEGIN CERTIFICATE-----
    MIIFkzCCA3ugAwIBAgIJAJrbPy/0/Cl1MA0GCSqGSIb3DQEBCwUAMGAxCzAJBgNV
	BAYTAlhYMRUwEwYDVQQHDAxEZWZhdWx0IENpdHkxHDAaBgNVBAoME0RlZmF1bHQg
	Q29tcGFueSBMdGQxHDAaBgNVBAMME3JlZ2lzdHJ5LmlibWxhYi5vY3AwHhcNMjAw
	MjI2MDEyNTE2WhcNMjEwMjI1MDEyNTE2WjBgMQswCQYDVQQGEwJYWDEVMBMGA1UE
	BwwMRGVmYXVsdCBDaXR5MRwwGgYDVQQKDBNEZWZhdWx0IENvbXBhbnkgTHRkMRww
	GgYDVQQDDBNyZWdpc3RyeS5pYm1sYWIub2NwMIICIjANBgkqhkiG9w0BAQEFAAOC
	Ag8AMIICCgKCAgEAviCAGGYg2w2YHk1EBEIz58AWIDzVQSVU1rMeFRh7ZOvjGSQl
	LBqwJ3LpYf3K3+FScfcvn0m73egjL+LwNOfR2HT6/wbdWFVa5ThoLF/nr4i9qQMI
	uEJ/3hp+xzsUT1+OAP57luUasHm99iP2hKDvUMIbCKbSKim+Mj+YEUViomV2Xqti
	XY78yAWY9nyxLeb8GGZfoQfwqZ6T96KFeFAYCdDKGIgGvdEPlRIHx0lDDDeCJ6oF
	dtllARHLjSDbadsYoPltFlWYegZ4ZAv7QFnNIRreX2o1OibPXTmg0WCO5vyzCORH
	zIoY2j3XAmg4o7RwN6aPS8cspslN6Tk+1ikmLjGgZ/NAqGV+FqiGgtaxYvECRxtD
	hjx16Yak7CFDugoRVS3/Ztfjsu0bjigca38W+28q6ke4sRXnDHH6XJobSlozwoE1
	yZ4m0t9AEw7pid8mRrEJ79cMGgQ4UTSoD0YxEvt0ysPnKvBZar0DWn6M3969QL2C
	hUaQsOCa0WfJq8KfPnZjhaXNGaYeztsTPmb6j+TsMcU7/BI+LJkHW0W2EGa1wdHE
	2D+5YOWXz/bM47EMnfHV3+y5H/aiUQeJPzrGIaWIVAsZOWONEP6qA7gtn/L9ykuk
	YsyMTHw0TUcrudFdXWxp1u/Er1OmRWDR8IV5VlxEk/uhdL0n0rwOi/98cCMCAwEA
	AaNQME4wHQYDVR0OBBYEFMMlYCyZn8cDF5CCDLXHN3AiMvx7MB8GA1UdIwQYMBaA
	FMMlYCyZn8cDF5CCDLXHN3AiMvx7MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEL
	BQADggIBAJ1pW9bRTUclfvs+hK7O5/1xRevQ8OQcmAoIS5MD+m5+ky6zAMMou1qk
	61AyxYiZd/F8hZGWZK8e3U/T0csTBQVmVJqR4skbVm4PcM2MTeB2C3g6e8gwYMPI
	AbPVL/PYVA4OM8Pjl3L1GA79psoaJBbAWRdThuIA9uEyr0dK0qmJ69WFZzi8VCR7
	M9wMY6D52yaK0oaOPJfW9/Ytwszs2t8wnvhnsnmmh5Q2HG6eyYkZt0KfTAc1BP3i
	OGliYIzdn0CsEJuVggY1lfEvQIcL7/DfMDDTzEuMhFF2BkG7dpgrSNyAkJJkWc88
	I0sgdKH5DZyqxDsMBb+WhO17+CWZK4tqog+gp1vio53Lnm9WpJz88FaDbpzdvWZE
	MxDFUUuxbktNU+8u1UxwxLGJXFd2nVEB7AEdMqCeYyDY8o0fkrB35Wwyw2uSIuGx
	5MxW79Diz8ixFiSpn8wuOJF+6j8x+oEB/DEO6rV+alHGrxnP0cGunmvYxR5P5txB
	ylYOZcwoXIUn0ujh9xUvZY5SuWH3PFdPJfjE9R46D4R4nH84oUPgXhisFqqPsjeo
	FYF2bWBDwSfbaW3WUNsorr4bGi01cFLD1Y8tHfh0kKf+MXG9oxeJV3CaZM5lcVtK
	ahzSZOuKf1RcSAmKPjYer/AYrnYd/PBiBivaEROQsQDtwTHFZLMp
    -----END CERTIFICATE-----
  registry.ibmlab.ocp..5000: | 
    -----BEGIN CERTIFICATE-----
    MIIFkzCCA3ugAwIBAgIJAJrbPy/0/Cl1MA0GCSqGSIb3DQEBCwUAMGAxCzAJBgNV
	BAYTAlhYMRUwEwYDVQQHDAxEZWZhdWx0IENpdHkxHDAaBgNVBAoME0RlZmF1bHQg
	Q29tcGFueSBMdGQxHDAaBgNVBAMME3JlZ2lzdHJ5LmlibWxhYi5vY3AwHhcNMjAw
	MjI2MDEyNTE2WhcNMjEwMjI1MDEyNTE2WjBgMQswCQYDVQQGEwJYWDEVMBMGA1UE
	BwwMRGVmYXVsdCBDaXR5MRwwGgYDVQQKDBNEZWZhdWx0IENvbXBhbnkgTHRkMRww
	GgYDVQQDDBNyZWdpc3RyeS5pYm1sYWIub2NwMIICIjANBgkqhkiG9w0BAQEFAAOC
	Ag8AMIICCgKCAgEAviCAGGYg2w2YHk1EBEIz58AWIDzVQSVU1rMeFRh7ZOvjGSQl
	LBqwJ3LpYf3K3+FScfcvn0m73egjL+LwNOfR2HT6/wbdWFVa5ThoLF/nr4i9qQMI
	uEJ/3hp+xzsUT1+OAP57luUasHm99iP2hKDvUMIbCKbSKim+Mj+YEUViomV2Xqti
	XY78yAWY9nyxLeb8GGZfoQfwqZ6T96KFeFAYCdDKGIgGvdEPlRIHx0lDDDeCJ6oF
	dtllARHLjSDbadsYoPltFlWYegZ4ZAv7QFnNIRreX2o1OibPXTmg0WCO5vyzCORH
	zIoY2j3XAmg4o7RwN6aPS8cspslN6Tk+1ikmLjGgZ/NAqGV+FqiGgtaxYvECRxtD
	hjx16Yak7CFDugoRVS3/Ztfjsu0bjigca38W+28q6ke4sRXnDHH6XJobSlozwoE1
	yZ4m0t9AEw7pid8mRrEJ79cMGgQ4UTSoD0YxEvt0ysPnKvBZar0DWn6M3969QL2C
	hUaQsOCa0WfJq8KfPnZjhaXNGaYeztsTPmb6j+TsMcU7/BI+LJkHW0W2EGa1wdHE
	2D+5YOWXz/bM47EMnfHV3+y5H/aiUQeJPzrGIaWIVAsZOWONEP6qA7gtn/L9ykuk
	YsyMTHw0TUcrudFdXWxp1u/Er1OmRWDR8IV5VlxEk/uhdL0n0rwOi/98cCMCAwEA
	AaNQME4wHQYDVR0OBBYEFMMlYCyZn8cDF5CCDLXHN3AiMvx7MB8GA1UdIwQYMBaA
	FMMlYCyZn8cDF5CCDLXHN3AiMvx7MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEL
	BQADggIBAJ1pW9bRTUclfvs+hK7O5/1xRevQ8OQcmAoIS5MD+m5+ky6zAMMou1qk
	61AyxYiZd/F8hZGWZK8e3U/T0csTBQVmVJqR4skbVm4PcM2MTeB2C3g6e8gwYMPI
	AbPVL/PYVA4OM8Pjl3L1GA79psoaJBbAWRdThuIA9uEyr0dK0qmJ69WFZzi8VCR7
	M9wMY6D52yaK0oaOPJfW9/Ytwszs2t8wnvhnsnmmh5Q2HG6eyYkZt0KfTAc1BP3i
	OGliYIzdn0CsEJuVggY1lfEvQIcL7/DfMDDTzEuMhFF2BkG7dpgrSNyAkJJkWc88
	I0sgdKH5DZyqxDsMBb+WhO17+CWZK4tqog+gp1vio53Lnm9WpJz88FaDbpzdvWZE
	MxDFUUuxbktNU+8u1UxwxLGJXFd2nVEB7AEdMqCeYyDY8o0fkrB35Wwyw2uSIuGx
	5MxW79Diz8ixFiSpn8wuOJF+6j8x+oEB/DEO6rV+alHGrxnP0cGunmvYxR5P5txB
	ylYOZcwoXIUn0ujh9xUvZY5SuWH3PFdPJfjE9R46D4R4nH84oUPgXhisFqqPsjeo
	FYF2bWBDwSfbaW3WUNsorr4bGi01cFLD1Y8tHfh0kKf+MXG9oxeJV3CaZM5lcVtK
	ahzSZOuKf1RcSAmKPjYer/AYrnYd/PBiBivaEROQsQDtwTHFZLMp
    -----END CERTIFICATE-----
```
## edit image.config.openshift.io/cluster
```
oc edit image.config.openshift.io/cluster

    spec:
      allowedRegistriesForImport:
        - domainName: quay.io
          insecure: false
        - domainName: registry.ibmlab.ocp:5000
          insecure: true
      registrySources:
        insecureRegistries:
        - registry.ibmlab.ocp:5000
```

## reger Documents
```
(add registry) https://docs.openshift.com/container-platform/4.3/registry/configuring-registry-operator.html 
(refer example) https://docs.openshift.com/container-platform/4.2/openshift_images/image-configuration.html 
```


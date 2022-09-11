### What is sidecar container ?
[kerberos-sidecar-container](https://www.openshift.com/blog/kerberos-sidecar-container)

To reach a kerberized service, a kerberos ticket and krb5.conf file is enough. 
Sidecar containers help to other containers without calling kinit inside of each container.


### Creating example secret
``` docker secret create client.keytab [path_to_the_keytab]/client.keytab```

### kerberos sidecar container

```
docker-compose build
docker stack deploy -c docker-stack.yml kerberos-auth
```
### using sidecar volume in other containers using docker stack

Other services can use the sidecar-volume. Sidecar volume will always be containing a valid kerberos ticket cache.
Other services can just mount sidecar-volume and use the valid kerberos ticket by setting KRB5CCNAME environment variable.
See for more details: [KRB5CCNAME](https://web.mit.edu/kerberos/krb5-1.12/doc/basic/ccache_def.html)

#### other-docker-stack.yml
```
.
.
services:
  [service_name]:
    volumes:
      - sidecar-volume:/kerberos-sidecar
volumes:
  sidecar-volume:
    external:true
    name: kerberos-sidecar
```

### how to implement it in kubernetes ?
Same strategy can be applied in kubernetes using kubernetes secrets. Kubernetes secrets can be updated during runtime. A pod who is mounting the secret to itself will get the updated secret without restart. But the secret type should be a file.

A simple kerberos-auth pod in kubernetes can be implemented in a python container using [kubernetes](https://pypi.org/project/kubernetes/) library. The secret which is containing kerberos ticket cache and krb5.conf should be updated during runtime using [kubernetes](https://pypi.org/project/kubernetes/). 
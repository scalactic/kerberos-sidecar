### What is sidecar container ?
[kerberos-sidecar-container](https://www.openshift.com/blog/kerberos-sidecar-container)

### Creating example secret
``` docker secret create client.keytab [path_to_the_keytab]/client.keytab```

### kerberos sidecar container

```
docker-compose build
docker stack deploy -c docker-stack.yml kerberos-auth
```
### using sidecar volume in other containers

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
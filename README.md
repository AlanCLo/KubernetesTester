# KubernetesTester
Just testing how kubernetes works

https://github.com/kubernetes/minikube

Refer to [Makefile](Makefile).

# postgres demo
Refer to [postgres.yaml](postgres.yaml)

Deploys a postgresql using danieldent/postgres-replication image. Check out the dockerhub and github page for its construction.

This demo deploys a primary/replica configuration of postgresql. Primary is read-writeable. Replicas are read-only but can scale as much as needed.

```
# Deploy it.
make postgres

# See all the stuff that is on the cluster
make show

# Run through a demo that makes some data and reads it back
sh postgres_test.sh

# Scale replicas
kubectl scale sts postgres-replicas --replicas=5

# Un-deploy it
sh postgres_clean.sh
```

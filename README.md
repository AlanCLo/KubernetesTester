# KubernetesTester
Just testing how Kubernetes works. None of these deployments are designed for production. The only intent is to learn and exercise how to do something in Kubernetes.

https://github.com/kubernetes/minikube

# Makefile?
[Makefile](Makefile)

I keep some shortcuts here. Why Make? No reason in particular. Started with the intent that it will build stuff but as I learn more kubectl I didn't need it.

```
# Does a kubectl get on a most resources
make show

```

# Building local docker images

```
eval $(minikube docker-env)
docker built -t ...
```

# Making secrets

Make a fresh one on the commandline
```
# You can have as many --from-literal flags as you want in the same command call
kubectl create secret generic (NAME) --from-literal=(KEY)=(SECRET)
```

Edit/View the secret in yaml form
```
kubectl edit secret (NAME)
```
You can copy and paste that as a yaml like I do in this repo but thats probably a bad idea beyond demo purposes.
*TODO*: Remove secrets from the repo and also get different apps to refer to same secrets

You can also create the secret text outside of k8s by:
```
echo -n (SECRET) | base64
```


# postgres
[postgres.yaml](postgres.yaml)

Deploys a postgresql using danieldent/postgres-replication image. Check out the dockerhub and github page for its construction.

This demo deploys a primary/replica configuration of postgresql. Primary is read-writeable. Replicas are read-only but can scale as much as needed.

```
# Deploy it.
kubectl apply -f postgres.yaml

# See all the stuff that is on the cluster
make show

# Run through a demo that makes some data and reads it back
sh postgres_test.sh

# Scale replicas
kubectl scale sts postgres-replicas --replicas=5

# Un-deploy it
kubectl delete -f postgres.yaml

# Delete persistent stuff
kubectl delete pvc -l app=postgres
kubectl delete pvc -l app=postgres-replicas

```


Better postgres kubernetes stuff:

PostDock
 * https://hackernoon.com/postgresql-cluster-into-kubernetes-cluster-f353cde212de
 * https://github.com/paunin/PostDock

Stolon
 * https://blog.lwolf.org/post/how-to-deploy-ha-postgressql-cluster-on-kubernetes/
 * https://github.com/sorintlab/stolon



# mysql stateful application

https://kubernetes.io/docs/tasks/run-application/run-replicated-stateful-application/


# InfluxDB & Grafana

Followed thi tutorial:
https://opensource.com/article/19/2/deploy-influxdb-grafana-kubernetes

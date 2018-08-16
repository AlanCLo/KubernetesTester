#!/bin/sh


kubectl delete service postgres
kubectl delete sts postgres

kubectl get pvc -l app=postgres -o go-template --template '{{range .items}}{{.spec.volumeName}}{{"\n"}}{{end}}' | xargs kubectl delete pv
kubectl get pvc -l app=postgres -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | xargs kubectl delete pvc


kubectl delete service postgres-replicas
kubectl delete sts postgres-replicas

kubectl get pvc -l app=postgres-replicas -o go-template --template '{{range .items}}{{.spec.volumeName}}{{"\n"}}{{end}}' | xargs kubectl delete pv
kubectl get pvc -l app=postgres-replicas -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | xargs kubectl delete pvc

kubectl delete secret postgres-password

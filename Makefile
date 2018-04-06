
.PHONY: sanity_check deploy clean

sanity_check:
	kubectl cluster-info

deploy:
	kubectl apply -f postgres.yaml

enter%:
	kubectl exec -it postgres-sts-$(subst enter,,$@) /bin/bash

clean:
	kubectl delete secret postgres-password
	kubectl delete service postgres
	kubectl delete sts postgres-sts


clean_specifically_the_pv_and_pvc_are_you_really_really_sure:
	kubectl get pvc -l app=postgres -o go-template --template '{{range .items}}{{.spec.volumeName}}{{"\n"}}{{end}}' | xargs kubectl delete pv
	kubectl get pvc -l app=postgres -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | xargs kubectl delete pvc

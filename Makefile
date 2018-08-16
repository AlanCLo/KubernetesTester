### A bunch of shortcuts to kubectl and minikube commands
#
# Assumes you have minikube installed and started
# https://github.com/kubernetes/minikube


# Try minikube start if it isn't
sanity_check:
	@echo "\033[1;31mChecking kube is alive\033[0m"
	kubectl cluster-info 

# Show all types of resources
show: show-services show-deployments show-sts show-pods show-pvc show-pv show-secret

# Show a specific resource
show-%:
	@echo "\033[1;31mkubectl get $(subst show-,,$@)\033[0m"
	@kubectl get $(subst show-,,$@)

# Deploy a yaml described thing
%: %.yaml
	kubectl apply -f $@.yaml

# If its a service with a url, show the url to access it
url-%:
	minikube service $(subst url-,,$@) --url

# Enter the container 
enter-%:
	kubectl exec -it $(subst enter-,,$@) /bin/bash




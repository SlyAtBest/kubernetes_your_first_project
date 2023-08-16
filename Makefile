.PHONY: run_website stop_website install_minikube install_kubectl create_minikube_cluster \
	build_in_minikube delete_minikube_cluster install_app

run_website:
	docker build -t explorecalifornia.com . && \
		docker run --rm --name explorecalifornia.com -p 5000:80 -d explorecalifornia.com

stop_website:
	docker stop explorecalifornia.com

install_minikube:
	if ls | grep -q 'minikube-linux-amd64'; \
	then echo "---> minikube already downloaded; skipping"; \
	else curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64; \
	fi; \
	sudo install minikube-linux-amd64 /usr/local/bin/minikube && \
		minikube version

install_kubectl:
	snap install kubectl --classic

create_minikube_cluster: install_minikube install_kubectl
	minikube start && \
		kubectl get nodes

build_in_minikube:
	eval $(minikube docker-env) && docker build -t explorecalifornia.com:v1 .

delete_minikube_cluster:
	minikube delete

install_app:
	helm upgrade --atomic --install explore-california-website ./chart

minikube start --driver=virtualbox
eval $(minikube -p minikube docker-env)

#metallb
MINIKUBE_IP=$(minikube ip)
minikube addons enable metallb
kubectl apply -f ./srcs/metallb/metallb.yaml

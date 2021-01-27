minikube start --driver=virtualbox
eval $(minikube docker-env)

#metallb
MINIKUBE_IP=$(minikube ip)
minikube addons enable metallb
kubectl apply -f ./srcs/metallb/metallb.yaml

# nginx
cd ./srcs/nginx
echo "\033[32mnginx image build\033[0m"
docker build -t nginx:latest .	> /dev/null
echo "\033[36mnginx deployment\033[0m"
kubectl apply -f ./nginx-secret.yaml
kubectl apply -f ./nginx.yaml

# mysql
cd ../mysql
echo "\033[32mmysql image build\033[0m"
docker build -t mysql:latest .	> /dev/null
echo "\033[36mmysql deployment\033[0m"
kubectl apply -f mysql.yaml

# phpmyadmin
cd ../phpmyadmin
echo "\033[32mphpmyadmin image build\033[0m"
docker build -t phpmyadmin:latest .	> /dev/null
echo "\033[36mphpmyadmin deployment\033[0m"
kubectl apply -f phpmyadmin.yaml

# wordpress
cd ../wordpress
echo "\033[32mwordpress image build\033[0m"
docker build -t wordpress:latest .	> /dev/null
echo "\033[36mwordpress deployment\033[0m"
kubectl apply -f wordpress.yaml

# ftps
cd ../ftps
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./ftps-config.yaml > ./ftps.yaml
echo "\033[32mftps image build\033[0m"
docker build -t ftps:latest .
echo "\033[36mftps deployment\033[0m"
kubectl apply -f ftps.yaml

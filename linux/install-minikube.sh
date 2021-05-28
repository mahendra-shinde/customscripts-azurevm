MYUSER=mahendra
if [ $# -ge 1 ] 
then
  MYUSER=$1
fi
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt install  apt-transport-https ca-certificates curl wget docker.io -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
apt update -y
echo "Installing VSCode and kubectl (kubernetes cli)"
apt install -y code kubectl
usermod -aG docker $MYUSER
echo "Installing minikube"
dpkg -i minikube_latest_amd64.deb
echo "Setting up CronTab for starting minikube on restart!"
crontab -u $MYUSER -l > mycron
echo start minikube with two virtual-nodes on startup
echo "@reboot minikube start --nodes 2 --driver=docker" >> mycron
#install new cron file
crontab -u $MYUSER mycron
rm mycron
reboot

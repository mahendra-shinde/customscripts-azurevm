USERNAME=Student5
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt install software-properties-common apt-transport-https wget git -y
apt install ubuntu-mate-desktop openjdk-8-jdk git docker.io maven -y
usermod -aG docker $USERNAME
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
AZ_REPO=$(lsb_release -cs)
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" 
apt update -y
apt install -y code azure-cli
echo "Creating a desktop shortcut for VSCode"
cp /usr/share/applications/code.desktop /home/$USERNAME/Desktop/code.desktop
chmod a+x /home/$USERNAME/Desktop/code.desktop
wget https://download.nomachine.com/download/6.12/Linux/nomachine_6.12.3_7_amd64.deb
dpkg -i nomachine_6.12.3_7_amd64.deb
cd /home/$USERNAME/
echo "Downloading and extracting eclipse ide"
curl https://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz | tar -xz
echo "Downloading and extracting Tomcat-9 in /home/$USERNAME directory"
curl https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz | tar -xz
mkdir -p /home/$USERNAME/Desktop
cd /home/$USERNAME/Desktop
cat > eclipse-ide.desktop << EOF
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Eclipse-JEE
EOF
echo "Exec=/home/$USERNAME/eclipse/eclipse" >> eclipse-ide.desktop
echo "Icon=/home/$USERNAME/eclipse/icon.xpm" >> eclipse-ide.desktop
chmod a+x /home/$USERNAME/Desktop/eclipse-ide.desktop
#!/bin/bash

# Utilisation de sudo lorsque nécessaire
sudo apt update -y && sudo apt upgrade -y && sudo apt install curl git sudo -y

read -p "[*] Quel est le nom de votre utilisateur ? : " nom_cool
echo "[*] Installation VirtualBox..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee -a /etc/apt/sources.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
sudo apt-get update -y && sudo apt-get install virtualbox-7.0 -y

echo "[*] Installation Packer..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update -y && sudo apt-get install packer -y

echo "[*] Installation Vagrant..."
sudo apt install vagrant -y 

echo "[*] Installation du plugin Vagrant reload et Virtualbox..."
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-vbguest

echo "[*] Place l'utilisateur $nom_cool dans les bons groupes..."
sudo usermod -aG sudo $nom_cool
sudo usermod -aG vboxusers $nom_cool

echo "[!] Reboot nécessaire"
sleep 5 
sudo reboot

#!/bin/bash
echo "[*] Récupération de la VM Vulnérable et déploiement..."
git clone https://github.com/rapid7/metasploitable3 
cd metasploitable3
packer build --only=virtualbox-iso ./packer/templates/windows_2008_r2.json
vagrant box add packer/builds/windows_2008_r2_*_0.1.0.box --name=rapid7/metasploitable3-win2k8
vagrant up win2k8
echo -e "\e[32mIl ne reste plus qu'à mettre l'adaptateur en bridge (pont)\e[0m"
echo -e "\e[32mPuis sur la machine, se mettre sur le bon plan d'adressage avec : ipconfig /release\e[0m"
echo -e "\e[32mPuis ipconfig /renew\e[0m"
echo -e "\e[32mles identifiants sont vagrant:vagrant (en qwerty : vqgrqnt)\e[0m"
echo -e "\e[32mSi le script n'a pas déployé la VM dans VirtualBox, veuillez redémarrez le script une seconde fois.\e[0m"
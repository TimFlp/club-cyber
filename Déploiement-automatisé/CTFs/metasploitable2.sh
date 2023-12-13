#!/bin/bash

## Fonction pour vérifier si Docker est déjà installé
check-docker() {
    if command -v docker &> /dev/null ; then
        echo "[*] Docker est déjà installé."
        return 0
    else
        echo "[*] Docker n'est pas installé."
        return 1
    fi
}

## Fonction pour installer Docker
install-docker() {
    clear
    echo "[*] Mise à jour de la liste des paquets..."
    apt-get -qq update 
    
    echo "[*] Installation des paquets nécessaires..."
    apt-get -qq install -y ca-certificates curl gnupg sudo lsb-release gnupg2 apt-transport-https software-properties-common

    echo "[*] Récupération des clés gpg..."
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian.gpg
    echo "[*] Ajout de la liste de paquets Docker..."
    sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    echo "[*] Mise à jour de la liste des paquets..."
    apt-get -qq update -y 
    
    echo "[*] Installation des paquets Docker..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    
    echo "[*] Lancement d'un docker de test pour vérifier l'environnement..."
    systemctl start docker

    echo "[*] Ajout de l'utilisateur actuel au groupe Docker..."
    usermod -aG docker test
    echo "[*] Fait en sorte que Docker se lance au démarrage de la machine..."
    systemctl enable docker
}

## Fonction pour installer Metasploitable 2
install-metasploitable2() {
    clear
    echo "[*] Lancement de metasploitable 2..."
    docker run -it -d --network host --name metasploitable2 --hostname metasploitable2 tleemcjr/metasploitable2 bash
    docker exec -it -d metasploitable2 "/bin/bash /bin/services.sh"
    
    echo -e "[*] Ajout de la crontab pour relancer le Docker metasploitable2 toutes les 5 minutes..."
    
    # Correction de la ligne de la crontab
    echo "*/5 * * * * root docker stop metasploitable2 && docker rm metasploitable2 && docker run -it -d --network host --name metasploitable2 --hostname metasploitable2 tleemcjr/metasploitable2 bash && docker exec -it -d metasploitable2 '/bin/bash /bin/services.sh'" >> /etc/crontab
}

if ! check-docker ; then
    install-docker
fi

install-metasploitable2

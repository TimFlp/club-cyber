#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

ascii-art() {
echo ""
echo "      __________...----..____..-'\`\`-..___"
echo "    ,'.                                  \`\`\`--.._"
echo "   :                                             \`\`._"
echo "   |                           --                    \`\`."
echo "   |                   -.-      -.     -   -.        \`.  "
echo "   :                     __           --            .     \\"
echo "    \`._____________     (  \`.   -.-      --  -   .   \`     \\"
echo "       \`-----------------\\   \\_.--------..__..--.._ \`. \`.   :"
echo "                          \`--'     SSt             \`-. .   |"
echo "                                                       \`.  |"
echo "                                                         \`\\ |"
echo "                                                          \\ |"
echo "                                                          / \\.\`\\"
echo "                                                         /  _\\-'\`"
echo "                                                        /_,'"
echo ""
echo -e "${GREEN}Script d'automatisation de déploiement d'environnement sous Docker${NC}"
echo -e "${GREEN}Fait par Tim (10 minutes avant le cours) :)${NC}"
}

install-docker() { ## D'après la documentation Docker : https://docs.docker.com/engine/install/debian/

    clear
    echo "[*] Mise à jour de la liste des paquets..."
    sudo apt-get -qq update 

    echo "[*] Installation des paquets nécessaires..."
    sudo apt-get -qq install -y ca-certificates curl gnupg sudo lsb-release gnupg2 apt-transport-https software-properties-common

    echo "[*] Récupération des clés gpg..."
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian.gpg
    echo "[*] Ajout de la liste de paquets Docker..."
    sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    echo "[*] Mise à jour de la liste des paquets..."
    sudo apt-get -qq update -y 

    echo "[*] Installation des paquets Docker..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    echo "[*] Lancement de Docker..."
    sudo systemctl start docker

    echo "[*] Ajout de l'utilisateur test et actuel au groupe Docker..."
    sudo usermod -aG docker test && sudo usermod -aG docker $USER
    echo "[*] Installation de Docker terminée."

}

launch-environnement() {
    read -p "Choisissez un petit nom pour votre machine : " nom
    echo "[*] Lancement de l'environnement avec Docker..."
    sudo docker run --hostname=$nom --name=debian -it debian /bin/bash
}

check_docker() {
    if command -v docker &>/dev/null; then
        echo "[*] Docker est déjà installé. Lancement de l'environnement..."
        launch-environnement
    else
        echo "[*] Docker n'est pas installé. Démarrage de l'installation de Docker..."
        install-docker
        launch-environnement
    fi
}


ascii-art
check_docker

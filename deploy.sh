#!/bin/bash
## Fonctionnel et testé pour des machines Debian 11 - 12.

GREEN='\033[0;32m'
NC='\033[0m'

ascii-art() {
## Récupéré sur : https://ascii.co.uk/art/whale
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
    sudo usermod -aG docker $USER # Gestion erreur
    sudo usermod -aG docker test 
    echo "[*] Installation de Docker terminée."

}

launch-environnement() {
    read -p "Choisissez un petit nom pour votre machine : " nom
    echo "[*] Lancement de l'environnement avec Docker..."
    sudo docker run --hostname=$nom --name=debian -it debian /bin/bash
}

ascii-art
echo "[*] Démarrage de l'installation de Docker sur la machine..."
install-docker
launch-environnement

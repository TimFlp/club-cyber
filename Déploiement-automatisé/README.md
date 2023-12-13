Bienvenue dans le dépôt des scripts d'automatisation !

## 🚀 Aperçu

Ce dépôt contient une collection de scripts Bash utilisant très souvent Docker, Vagrant et packer pour faciliter le déploiement et la gestion des environnement vulnérables mis en place pour les cours. Les scripts sont conçus pour être déployés sur des machines Debian vierges.

## 📂 Contenu

- [**deploy-docker.sh**](https://github.com/TimFlp/club-cyber/Déploiement-automatisé/Docker/deploy-docker.sh) : 🐋 Automatise l'installation de Docker si il n'est pas présent sur la machine de l'étudiant et initialise une image Debian conteneurisée.
- [**metasploitable2.sh**](https://github.com/TimFlp/club-cyber/Déploiement-automatisé/CTFs/metasploitable2.sh) : Installe les dépendances nécessaires et déploie l'environnement vulnérable metasploitable2.
- [**metasploitable3-x.sh**](https://github.com/TimFlp/club-cyber/Déploiement-automatisé/CTFs/MS3/) : Installe les dépendances nécessaires et déploie l'environnement vulnérable metasploitable3 sur VirtualBox.

## 💡 Comment Utiliser

Chaque script est conçu pour fonctionner en tant que root ainsi qu'un compte nommé 'test'. Dans la plupart des cas, il suffit uniquement de lancer le script avec la commande suivante :

    bash script.sh

Vous pouvez également changer l'utilisateur par défaut test par le votre avec un simple sed :

    sed -i 's/test/utilisateur/g' script.sh


## 🤝 Contribution

Les contributions sont les bienvenues ! Si vous avez des idées d'améliorations, des corrections de bugs ou de nouveaux scripts à partager, n'hésitez pas à soumettre une demande d'extraction (Pull Request).

#!/bin/bash

# Étape 1: Créer une clé SSH
echo "Voici votre clé publique :"
cat ~/.ssh/id_ed25519.pub
#ssh-keygen -t ed25519 -C "guillaume.themeze@institutoptique.fr"
echo "Key déjà fait \n Title: guillaume.themeze@institutoptique.fr \n Compte : Guillaume 
@guillaume.themeze \n  User ID: 13951" 

# Les droits
cd /Users/themezeguillaume/.ssh/ 
ls -l
#chmod u=rwx,g=rwx,o=rwx id_ed25519
#chmod u=rwx,g=rwx,o=rwx id_ed25519.pub
#chmod u=rwx,g=rwx,o=rwx known_hosts   
#chmod u=rwx,g=rwx,o=rwx known_hosts.old
ls -l
chmod 600 /Users/themezeguillaume/.ssh/id_ed25519.pub #les droites
#chmod 600 ~/.ssh/id_ed25519.pub #les droites
ls -l


# Étape 2: Lire la clé publique
echo "Voici votre clé publique :"
cat ~/.ssh/id_ed25519.pub

# Étape 3: Créer un répertoire pour l'article
cd ~/Desktop/Etude2023/PHD/ #chemier a changer 
mkdir Papier
cd Papier

# Étape 4: Cloner le dépôt GitLab
ls -a
#git clone git@gitlab.in2p3.fr:gaz-quantiques-lcf/puce/local_probe_rapidity_distri.git#"déja en locale"
echo "déja en locale"


# Étape 5: git-webui ,Initialiser Git en local
#Clonez simplement le référentiel et installez l'alias
#git clone https://github.com/alberthier/git-webui.git
#git config --global alias.webui \!$PWD/git-webui/release/libexec/git-core/git-webui
#Si vous souhaitez autoriser la mise à jour automatique :
#git config --global webui.autoupdate true
#Premier CD sur l'un de vos projets versionné avec git

#cd local_probe_rapidity_distri
cd ~/Desktop/Etude2023/PHD/Papier/local_probe_rapidity_distri/

git webui


###Clonage d'une branche spécifique
echo "Merges origin/Main_Version -> origin/Branche_Guillaumme"
echo "Les branches sont :"
#git branch -r
#git clone -b origin/Main_Version --single-branch <git@gitlab.in2p3.fr:gaz-quantiques-lcf/puce/local_probe_rapidity_distri.git> #Branche_Guillaumme

### Merge
#echo "Merges origin/Main_Version -> origin/Branche_Guillaumme"
#echo "Les branches sont :"
#git branch -r
## destination
#git checkout origin/Branche_Guillaumme
#git pull origin origin/Branche_Guillaumme
#%souce
#git merge origin/Main_Version
#git push origin origin/Main_Version




# Étape 6: Modifier le fichier .tex
# (Faites les modifications nécessaires manuellement)

# Étape 7: Faire un commit local
#git commit -m "Mon premier commit"

# Étape 8: Pousser les changements sur le serveur
#git push


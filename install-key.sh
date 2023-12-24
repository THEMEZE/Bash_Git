#!/bin/bash

echo "Key déjà faite"
echo "Title: guillaume.themeze@institutoptique.fr"
echo "Compte : Guillaume @guillaume.themeze"
echo "User ID: 13951"
echo "la clé à copier/coller dans nano ~/.ssh/id_ed25519.pub : "
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDuph7zxEJfnvPS94pskdIs//CNhchzhqeiGZPN2tqT3 guillaume.themeze@institutoptique.fr" > ~/.ssh/id_ed25519.pub

# Vous pouvez également utiliser nano pour ouvrir le fichier dans l'éditeur
#nano ~/.ssh/id_ed25519.pub

echo "Voici votre clé publique :"
cat ~/.ssh/id_ed25519.pub

# Les droits
#cd /Users/themezeguillaume/.ssh/
cd ~/.ssh/
ls -l
#chmod u=rwx,g=rwx,o=rwx id_ed25519
#chmod u=rwx,g=rwx,o=rwx id_ed25519.pub
#chmod u=rwx,g=rwx,o=rwx known_hosts
#chmod u=rwx,g=rwx,o=rwx known_hosts.old
#ls -l
chmod 600 ~/.ssh/id_ed25519.pub #les droites
ls -l


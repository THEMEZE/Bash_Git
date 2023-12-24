#!/bin/bash

# Script pour afficher les branches :
git branch -a

#Script pour ajouter un fichier :
file_name="nom_du_fichier.txt"
echo "Contenu du fichier" > $file_name
git add $file_name
git commit -m "Ajouter $file_name"

#Script pour ajouter un dossier :
folder_name="nom_du_dossier"
mkdir $folder_name
echo "Contenu du dossier" > $folder_name/fichier.txt
git add $folder_name
git commit -m "Ajouter $folder_name"

#Script pour effectuer un merge :
target_branch="branche_cible"
git checkout $target_branch
source_branch="branche_source"
git merge $source_branch

#Script pour effectuer un commit :
commit_message="Message de commit"
git commit -am "$commit_message"

#Script pour effectuer un push :
branch_name="nom_de_la_branche"
git push origin $branch_name

#Script pour lancer git-webui :
git webui

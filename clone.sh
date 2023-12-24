
#!/bin/bash

echo "Entrez le chemin du répertoire : \n (appuyez sur Entrée pour utiliser le répertoire par défaut /Users/themezeguillaume/Desktop/Documents_Clef/Traveaux/Git/Mes-Projets ) :"
read chemin

# Vérifie si la réponse est vide
if [ -z "$chemin" ]; then
  chemin_defaut="/Users/themezeguillaume/Desktop/Documents_Clef/Traveaux/Git/Mes-Projets"  # Remplacez cela par le chemin par défaut que vous souhaitez
  echo "Répertoire par défaut utilisé : $chemin_defaut"
  cd "$chemin_defaut"
else
  cd "$chemin"
fi

#echo "Entrer le repertoire Départ : \n (~/Desktop/Git/Mes-Projets/) \n (~/Desktop/Git/Papier-rapidite/) \n "
#read pach_0
pach_0=$(pwd)
pach_0=$chemin
#echo "Le chemin absolu du répertoire de travail actuel est : $pach_0"
#cd $pach_0

function liste_dossier {
    # Utilisez la commande 'pwd' pour obtenir le répertoire actuel
    repertoire=$(pwd)
    
    # Vérifiez si le répertoire existe
    if [ -d "$repertoire" ]; then
        # Utilisez la commande 'ls' avec l'option '-d' pour lister les dossiers
        # Utilisez '*/' comme motif pour ne lister que les dossiers
        dossiers=$(ls -d "$repertoire"/*/)

        # Parcourez la liste des dossiers et affichez uniquement les noms de dossier
        for dossier in $dossiers; do
            nom_dossier=$(basename "$dossier")
            echo "- $nom_dossier""/"
        done
    else
        echo "Le répertoire spécifié n'existe pas."
    fi
}

# Définir le chemin du répertoire
#echo "Entrer le repertoire  : \n (mon-premier-projet) \n (spartacus) \n (CameraFT) \n (ClientServer) \n"

echo "Entrez le repertoire :"
liste_dossier
read dossier_0
echo "dossier_0" $dossier_0
repo_dir=$pach_0'/'$dossier_0
echo "repo_dir" $repo_dir
# Vérifier si le répertoire existe
if [ -d "$repo_dir" ]; then
    # Le répertoire existe, effectuer un pull
    #cd $dossier_0'/'
    echo "Le répertoire existe, en train de faire un pull..."
    cd "$repo_dir"
    git pull
else
    # Le répertoire n'existe pas, cloner le dépôt
    echo "Le répertoire n'existe pas, en train de cloner le dépôt..."
    #cd $pach_0
    pwd
    echo "Clone with SSH:"
    read adress_web
    git clone $adress_web
    git clone -b Main_Version $adress_web
    cd $dossier_0
fi

# Afficher les branches
echo "Les branches sont :"

git branch -r

#echo "On lance Git Webui"
git webui




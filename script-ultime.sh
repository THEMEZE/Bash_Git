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

echo "Entrez le repertoire :"
liste_dossier
read dossier_0
cd $dossier_0
repo_dir=$(pwd)

branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")

function afficher_branches {
    echo "Branches locales :"
    git branch | cut -c 3-  # Affiche les branches locales sans l'astérisque

    echo "Branches distantes :"
    branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")
    for branch in $branches; do
        echo "- $branch"
    done
}

function supprimer_branche {
    echo "1. Supprimer localement"
    echo "2. Supprimer sur le serveur"
    echo "3. Supprimer localement et sur le serveur"
    
    read -p "Choisissez une option (1/2/3) : " choix
    
    case $choix in
        1)
            supprimer_branche_loc
            ;;
        2)
            supprimer_branche_serv
            ;;
        3)
            supprimer_branche_loc
            supprimer_branche_serv
            ;;
        *)
            echo "Option invalide"
            ;;
    esac
}

function supprimer_branche_loc {
    echo "Entrez le nom de la branche à supprimer localement :"
    read branch_name
    git branch -d $branch_name
}

function supprimer_branche_serv {
    echo "Entrez le nom de la branche à supprimer sur le serveur :"
    read branch_name
    git push origin --delete $branch_name
}


function update_repo() {
    local repo_dir="$1"
    echo "repo_dir : " $repo_dir

    if [ -d "$repo_dir" ]; then
        echo "Le répertoire existe, en train de faire un pull..."
        cd "$repo_dir"
        git pull
    else
        echo "Le répertoire n'existe pas, en train de cloner le dépôt..."
        read -p "Entrez l'adresse web du dépôt : " address_web
        git clone "$address_web"
        cd "$dossier_0"
    fi

    echo "Les branches sont :"
    git branch -r
}
function pull_toutes_branches {
    local branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")

    for branch in $branches; do
        git checkout $branch
        git pull
    done
}

function importer_branches_distantes {
    echo "Importation de toutes les branches distantes en local..."
    git fetch --all
}

# Fonction pour vérifier les modifications non validées
function check_uncommitted_changes {
    if [[ $(git status --porcelain) ]]; then
        echo "Erreur : Vous avez des modifications non validées. Veuillez valider ou remiser vos modifications avant de basculer de branche."
        #exit 1
    fi
}

function afficher_commandes_git {
    echo "Commandes Git de base :"
    echo "1. git init                    (Initialiser un nouveau dépôt Git)"
    echo "2. git clone [adresse_web]     (Cloner un dépôt existant)"
    echo "3. git add [fichier/dossier]  (Ajouter des fichiers/dossiers)"
    echo "4. git commit -m 'message'     (Valider les modifications avec un message de commit)"
    echo "5. git pull                    (Récupérer les dernières modifications depuis le dépôt distant)"
    echo "6. git push origin [branche]  (Pousser les modifications vers le dépôt distant)"
    echo "7. git status                  (Afficher l'état des fichiers)"
    echo "8. git log                     (Afficher l'historique des commits)"
    echo "9. git branch                  (Afficher les branches)"
    echo "10. git checkout [branche]    (Changer de branche)"
    echo "11. git merge [branche]        (Fusionner une branche dans la branche actuelle)"
    echo "12. git remote -v              (Afficher les dépôts distants)"
}

PS3="Que souhaitez-vous faire ? "
options=("Afficher les branches" "Changer de branche" "Creer une nouvelle branche" "Supprimer une branche" "Fusionner deux branches" "Revenir à une version antérieure" "Creer un gitignore" "Ajouter un fichier" "Ajouter un dossier" "Effectuer un merge" "Effectuer un commit" "Tout ajouter" "Effectuer un pull" "Effectuer un push" "Lancer git-webui"  "Lancer Sublime merge" "Lancer guihub Desktop " "Commandes Git de base" "Quitter")
select opt in "${options[@]}"
do
    case $opt in
        "Afficher les branches")
            check_uncommitted_changes
            afficher_branches
            git branch -v
            git status
            ;;
        "Changer de branche")
            git add .
            check_uncommitted_changes
            
            # Vérifier s'il y a des modifications non validées
            #if [ -n "$(git status --porcelain)" ]; then
            #    echo "Erreur : Vous avez des modifications non validées. Veuillez valider ou remiser vos modifications avant de basculer de branche."
            #else
                echo "Les branches sont  : "
                afficher_branches
                echo "Entrez le nom de la branche : "
                read new_branch_name
                git checkout $new_branch_name
            #fi
            ;;
        "Creer une nouvelle branche")
            echo "Entrez le nom de la nouvelle branche : "
            read new_branch_name
            git checkout -b $new_branch_name
            git commit -m "Création de la branche  $new_branch_name"
            git checkout $new_branch_name
            afficher_branches
            git branch -v
            git status
            ;;
        "Supprimer une branche")
            afficher_branches
            supprimer_branche 
            ;;
        "Fusionner deux branches")
            afficher_branches
            echo "Entrez le nom de la branche cible: "
            read branch_cible
            echo "Entrez le nom de la branche source: "
            read branch_source
            git checkout $branche_cible
            git merge $branche_source
            git commit -m "Fusion de $branche_source dans  $branche_cible"
            ;;
        "Revenir à une version antérieure")
            git log --oneline
            echo "Entrez l'identifiant du commit auquel vous souhaitez revenir :"
            read commit_id
            git checkout $commit_id
            ;;
        "Creer un gitignore")
            if [ ! -f .gitignore ]; then
                touch .gitignore
            fi
            echo "gitignore.txt > .gitignore"
            cat gitignore.txt > .gitignore
            git add .gitignore
            git commit -m "Ajout du fichier .gitignore pour exclure les fichiers de log"
            echo "Le fichier .gitignore a été configuré pour exclure les fichiers de log (*.log) du suivi de version Git."
            ;;
        "Ajouter un fichier")
            echo "Entrez le nom du fichier: "
            read file_name
            echo "Contenu du fichier" > $file_name
            git add $file_name
            git commit -m "Ajouter $file_name"
            ;;
        "Ajouter un dossier")
            echo "Entrez le nom du dossier: "
            read folder_name
            mkdir $folder_name
            echo "Contenu du dossier" > $folder_name/fichier.txt
            git add $folder_name
            git commit -m "Ajouter $folder_name"
            ;;
        "Effectuer un merge")
            afficher_branches
            chmod +x merge_branches.sh
            ./merge_branches.sh
            ;;
        "Effectuer un commit")
            afficher_branches
            echo "Entrez le message de commit : "
            read commit_message
            git commit -am "$commit_message"
            ;;
        "Tout ajouter")
            git add .
            git commit -m "Tout ajouter"
            git stash
            git stash apply
            git stash pop
            ;;
        "Effectuer un pull")
            check_uncommitted_changes
            update_repo "$repo_dir"
            pull_toutes_branches
            importer_branches_distantes
            ;;
        "Effectuer un push")
            echo "Entrez le nom de la branche : "
            read branch_name
            git push origin $branch_name
            ;;
        "Lancer git-webui")
            chmod +x git_webui_setup.sh
            ./ git_webui_setup.sh
            git webui
            ;;
        "Lancer Sublime merge")
            chmod +x install_sublime_merge.sh
            ./ install_sublime_merge.sh
            smerge
            ;;
        "Lancer GitHub Desktop")
            chmod +x instal_gihub_Desktop.sh
            .\ instal_gihub_Desktop.sh
            ;;
            
        "Commandes Git de base")
            afficher_commandes_git
            read -p "Entrez votre commande Git : " custom_command
            eval "$custom_command"
            ;;
        "Quitter")
            break
            ;;
        *) echo "Option invalide";;
    esac
done

current_branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$(git rev-parse --symbolic-full-name --abbrev-ref '@{u}' 2>/dev/null)" ]; then
    echo "Pas de branche distante configurée pour la branche $current_branch."
    echo "Veuillez configurer une branche distante de suivi avec la commande :"
    echo "git branch --set-upstream-to=origin/$current_branch $current_branch"
fi


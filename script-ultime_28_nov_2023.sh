#!/bin/bash
function liste_dossier {
    # Utilisez la commande 'pwd' pour obtenir le répertoire actuel
    repertoire=$(pwd)
    
    # Vérifiez si le répertoire existe
    if [ -d "$repertoire" ]; then
        # Utilisez la commande 'ls' avec l'option '-d' pour lister les dossiers
        # Utilisez '*/' comme motif pour ne lister que les dossiers
        dossiers=$(ls -d "$repertoire"/*/)

        # Parcourez la liste des dossiers et affichez-les
        for dossier in $dossiers; do
            echo "$dossier"
        done
    else
        echo "Le répertoire spécifié n'existe pas."
    fi
}

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


    
echo "Entrez le repertoire :" #\n (local_probe_rapidity_distri/) \n (mon-premier-projet/) \n (spartacus/) \n (CameraFT/) \n (ClientServer/)"
liste_dossier
#echo "--------------Entrez le repertoire : \n (../../Traveaux/) pour mes truc principeaux (à continuer) ---------------------"
read dossier_0
cd $dossier_0
#pach_0=$(pwd)
#repo_dir=$pach_0'/'$dossier_0
repo_dir=$(pwd)

branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")

# Fonction pour afficher les branches
function afficher_branches {
    branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")
    echo "Branches disponibles :"
    #git branch -r
    #echo "Branches distantes disponibles :"
    #echo "$branches"
    # Afficher les branches disponibles
    for branch in $branches; do
        echo "- $branch"
        if [[ ! "$branches" =~ "$branch" ]]; then
            echo "La branche '$branch' n'existe pas."
        fi
        done
}

function afficher_branches_recursive {
    local prefix="$1"
    
    #Affiche les branches locales actuelles
    echo "$prefix$(git branch --show-current)"
    
    # Parcours récursif des branches dans les sous-dossiers
    for branche in $(git for-each-ref --format='%(refname:short)' refs/heads/);do
        if [ "$branche" != "$(git branch --show-current)"]; then
            git checkout $branche &> /dev/null
            afficher_branches_recursive "$prefix "
            git checkout -&> /dev/null
        fi
    done
}

function afficher_branches_recursive_1 {
    local prefix="$1"
    local branches=$(git branch -a --merged | grep "/" | grep -v "remotes" | sed 's/^\*\? //' | grep "^$prefix")

    for branch in $branches; do
        echo "- $branch"
        afficher_branches_recursive "$branch"
    done
}

function revenir_version_antérieure {
    git log --oneline
    echo "Entrez l'identifiant du commit auquel vous souhaitez revenir :"
    read commit_id
    git checkout $commit_id
}

function update_repo() {
    # Afficher le chemin absolu du répertoire de travail actuel
    #local pach_0=$(pwd)
    #echo "Le chemin absolu du répertoire de travail actuel est : $pach_0"
    #cd "$pach_0"

    # Demander et définir le nom du répertoire
    #read -p "Entrer le nom du répertoire : " dossier_0
    #local repo_dir="$pach_0/$dossier_0"
    
    echo "repo_dir : " $repo_dir

    # Vérifier si le répertoire existe
    if [ -d "$repo_dir" ]; then
        # Le répertoire existe, effectuer un pull
        echo "Le répertoire existe, en train de faire un pull..."
        cd "$repo_dir"
        git pull
    else
        # Le répertoire n'existe pas, cloner le dépôt
        echo "Le répertoire n'existe pas, en train de cloner le dépôt..."
        read -p "Entrez l'adresse web du dépôt : " address_web
        git clone "$address_web"
        cd "$dossier_0"
    fi

    # Afficher les branches
    echo "Les branches sont :"
    git branch -r
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

# Appeler la fonction
#update_repo


# Afficher un menu pour choisir une action
PS3="Que souhaitez-vous faire ? "
options=("Afficher les branches" "Changer de branche" "Creer une nouvelle branche" "Supprimer une branche" "Fusionner deux branches" "Revenir à une version antérieure" "Creer un gitignore" "Ajouter un fichier" "Ajouter un dossier" "Effectuer un merge" "Effectuer un commit" "Tout ajouter" "Effectuer un pull" "Effectuer un push" "Lancer git-webui" "Lancer Sublime merge" "Commandes Git de base" "Quitter")
select opt in "${options[@]}"
do
    case $opt in
        "Afficher les branches")
            afficher_branches
            #echo "Toutes les branches :"
            #git branch -a | grep -v "remotes" | sed 's/^\*\? //'  # Affiche les branches locales

            echo -e "\nBranches dans les branches :"
            afficher_branches_recursive ""
            #
            afficher_branches_recursive
            git branch -v
            git status
            ;;
        "Changer de branche")
            echo "Les branches sont  : "
            afficher_branches
            echo "Entrez le nom de la branche : "
            read new_branch_name
            git checkout $new_branch_name
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
            echo "Entrez le nom de la branche à supprimer : "
            read delet_branch_name
            git branch -D $delet_branch_name
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
            revenir_version_antérieure
            ;;
            
        "Creer un gitignore")

            # Étape 1 : Créer un fichier .gitignore s'il n'existe pas déjà
            if [ ! -f .gitignore ]; then
                touch .gitignore
            fi

            # Étape 2 : Ajouter la règle d'exclusion pour les fichiers
            echo "gitignore.txt > .gitignore"
            cat gitignore.txt > .gitignore

            # Étape 3 : Enregistrer le fichier .gitignore dans le référentiel Git
            git add .gitignore
            git commit -m "Ajout du fichier .gitignore pour exclure les fichiers de log"

            # Étape 4 : Afficher un message de confirmation
            echo "Le fichier .gitignore a été configuré pour exclure les fichiers de log (*.log) du suivi de version Git."

            # Fin du script
            ;;

        "Ajouter un fichier")
            # Script pour ajouter un fichier :
            echo "Entrez le nom du fichier: "
            read file_name
            #file_name="nom_du_fichier.txt"
            echo "Contenu du fichier" > $file_name
            git add $file_name
            git commit -m "Ajouter $file_name"
            ;;
        "Ajouter un dossier")
            # Script pour ajouter un dossier :
            echo "Entrez le nom du dossier: "
            read folder_name
            #folder_name="Spartacus"
            mkdir $folder_name
            echo "Contenu du dossier" > $folder_name/fichier.txt
            git add $folder_name
            git commit -m "Ajouter $folder_name"
            ;;
        "Effectuer un merge")
            afficher_branches
            # Script pour effectuer un merge :
            #echo "Entrez la branche cible : "
            #read target_branch
            #echo "Entrez la branche source : "
            #read source_branch
            #git checkout $target_branch
            #git merge $source_branch
            #cd ..
            chmod +x merge_branches.sh
            ./merge_branches.sh
            ;;
        "Effectuer un commit")
            afficher_branches
            # Script pour effectuer un commit :
            echo "Entrez le message de commit : "
            read commit_message
            git commit -am "$commit_message"
            ;;
        "Tout ajouter")
            # Script pour effectuer un commit :
            git add .
            git commit -m "Tout ajouter"
            git stash
            git stash apply
            git stash pop
            ;;
        "Effectuer un pull")
            # Script pour effectuer un push :
            #echo "on est la"
            #pwd
            #cd ../
            #echo "on est la"
            #pwd
            #repo_dir=$pach_0'/'$dossier_0
            #chmod +x clone.sh
            #./clone.sh
            update_repo
            #cd $dossier_0
            ;;
        "Effectuer un push")
            # Script pour effectuer un push :
            echo "Entrez le nom de la branche : "
            read branch_name
            git push origin $branch_name
            ;;
        "Lancer git-webui")
            # Script pour lancer git-webui :
            chmod +x git_webui_setup.sh
            ./ git_webui_setup.sh
            git webui
            ;;
        "Lancer Sublime merge")
            # Script pour lancer git-webui :
            chmod +x install_sublime_merge.sh
            ./ install_sublime_merge.sh
            smerge
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




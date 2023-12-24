#!/bin/bash

echo "Entrez le repertoire :" #\n (local_probe_rapidity_distri/) \n (mon-premier-projet/) \n (spartacus/) \n (CameraFT/) \n (ClientServer/)"
liste_dossier
#echo "--------------Entrez le repertoire : \n (../../Traveaux/) pour mes truc principeaux (à continuer) ---------------------"
read dossier_0
cd $dossier_0
#pach_0=$(pwd)
repo_dir=$pach_0'/'$dossier_0
repo_dir=$(pwd)

branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")


function update_repo() {
    echo "Entrez le nom du répertoire :"
    lister_dossiers
    read dossier_0
    cd "$dossier_0"

    pach_0=$(pwd)
    repo_dir="$pach_0/$dossier_0"

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

# Afficher un menu pour choisir une action
PS3="Que souhaitez-vous faire ? "
options=("Afficher les branches" "Changer de branche" "Créer une nouvelle branche" "Supprimer une branche" "Fusionner deux branches" "Revenir à une version antérieure" "Créer un gitignore" "Ajouter un fichier" "Ajouter un dossier" "Effectuer un merge" "Effectuer un commit" "Tout ajouter" "Effectuer un pull" "Effectuer un push" "Lancer git-webui" "Lancer Sublime merge" "Commandes Git de base" "Quitter")

select opt in "${options[@]}"
do
    case $opt in
        "Afficher les branches")
            git branch -a
            ;;
        "Changer de branche")
            echo "Les branches sont : "
            git branch -a
            read -p "Entrez le nom de la branche : " new_branch_name
            git checkout $new_branch_name
            ;;
        "Créer une nouvelle branche")
            read -p "Entrez le nom de la nouvelle branche : " new_branch_name
            git checkout -b $new_branch_name
            git commit -m "Création de la branche $new_branch_name"
            git checkout $new_branch_name
            git branch -v
            git status
            ;;
        "Supprimer une branche")
            read -p "Entrez le nom de la branche à supprimer : " delete_branch_name
            git branch -D $delete_branch_name
            ;;
        "Fusionner deux branches")
            git branch -a
            read -p "Entrez le nom de la branche cible : " target_branch
            read -p "Entrez le nom de la branche source : " source_branch
            git checkout $target_branch
            git merge $source_branch
            git commit -m "Fusion de $source_branch dans $target_branch"
            ;;
        "Revenir à une version antérieure")
            git log --oneline
            read -p "Entrez l'identifiant du commit auquel vous souhaitez revenir : " commit_id
            git checkout $commit_id
            ;;
        "Créer un gitignore")
            echo "gitignore.txt > .gitignore"
            cat gitignore.txt > .gitignore
            git add .gitignore
            git commit -m "Ajout du fichier .gitignore pour exclure les fichiers de log"
            echo "Le fichier .gitignore a été configuré pour exclure les fichiers de log (*.log) du suivi de version Git."
            ;;
        "Ajouter un fichier")
            read -p "Entrez le nom du fichier : " file_name
            echo "Contenu du fichier" > $file_name
            git add $file_name
            git commit -m "Ajouter $file_name"
            ;;
        "Ajouter un dossier")
            read -p "Entrez le nom du dossier : " folder_name
            mkdir $folder_name
            echo "Contenu du dossier" > $folder_name/fichier.txt
            git add $folder_name
            git commit -m "Ajouter $folder_name"
            ;;
        "Effectuer un merge")
            ./merge_branches.sh
            ;;
        "Effectuer un commit")
            read -p "Entrez le message de commit : " commit_message
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
            update_repo
            ;;
        "Effectuer un push")
            read -p "Entrez le nom de la branche : " branch_name
            git push origin $branch_name
            ;;
        "Lancer git-webui")
            chmod +x git_webui_setup.sh
            ./git_webui_setup.sh
            git webui
            ;;
        "Lancer Sublime merge")
            chmod +x install_sublime_merge.sh
            ./install_sublime_merge.sh
            smerge
            ;;
        "Commandes Git de base")
            afficher_commandes_git
            ;;
        "Quitter")
            break
            ;;
        *) echo "Option invalide";;
    esac
done

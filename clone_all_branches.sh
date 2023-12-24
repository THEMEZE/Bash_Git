#!/bin/bash
git@gitlab.in2p3.fr:guillaume.themeze/mon-premier-projet.git
cd /Users/themezeguillaume/Desktop/Git/Mes-Projets/mon-premier-projet

for branch in $(git branch -r | grep -v "HEAD" | sed -e "s/origin\///"); do
    # Vérifier si la branche existe localement
    if git show-ref --verify --quiet refs/heads/$branch; then
        echo "La branche $branch existe déjà localement."
        read -p "Voulez-vous écraser la branche existante (y/n) ? " answer
        if [ "$answer" = "y" ]; then
            echo "Écrasement de la branche $branch en cours..."
            git branch -D $branch   # Supprimer la branche locale existante
            git branch --track $branch origin/$branch
        else
            echo "La branche $branch ne sera pas modifiée."
        fi
    else
        git branch --track $branch origin/$branch
    fi
done

git fetch --all




#!/bin/bash
cd local_probe_rapidity_distri

# Récupérer la liste des branches distantes
branches=$(git branch -r | grep -v "HEAD" | sed -e "s/origin\///")
#echo "Branches distantes disponibles :"
#echo "$branches"

# Afficher les branches disponibles
echo "Branches disponibles :"
for branch in $branches; do
    echo "- $branch"
    if [[ ! "$branches" =~ "$branch" ]]; then
        echo "La branche '$branch' n'existe pas."
    fi
    done

# Demander à l'utilisateur de spécifier la branche cible (destination)
read -p "Entrez le nom de la branche cible : " target_branch

# Demander à l'utilisateur de spécifier la branche source (à fusionner)
read -p "Entrez le nom de la branche source à fusionner : " source_branch

# Vérifier si les branches spécifiées existent
if [[ ! "$branches" =~ "$target_branch" ]]; then
    echo "La branche cible '$target_branch' n'existe pas."
    exit 1
fi

if [[ ! "$branches" =~ "$source_branch" ]]; then
    echo "La branche source '$source_branch' n'existe pas."
    exit 1
fi

# Basculer vers la branche cible
git checkout $target_branch

# Fusionner la branche source dans la branche cible
git merge $source_branch

# Pousser les modifications vers le référentiel distant
git push origin $target_branch

echo "La fusion de la branche $source_branch dans la branche $target_branch a été effectuée avec succès."

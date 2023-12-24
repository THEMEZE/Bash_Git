#!/bin/bash

# Vérifier si Git est installé
if ! command -v git &> /dev/null
then
    echo "Git n'est pas installé. Installation en cours..."
    brew install git
fi

# Vérifier si Git est à jour
latest_version=$(brew ls --versions git | awk '{print $2}')
current_version=$(git --version | awk '{print $3}')

if [ "$latest_version" != "$current_version" ]; then
    echo "Git n'est pas à jour. Mise à jour en cours..."
    brew upgrade git
fi

# Configurer l'utilisateur Git
git config --global user.name "THEMEZE"
git config --global user.email "guillaume.themeze@universite-paris-saclay.fr"

# Initialiser un nouveau référentiel Git
git init

# Créer un dossier de test
mkdir dossier_test

# Ajouter le dossier au suivi de Git
git add dossier_test

# Effectuer un commit
git commit -m "Ajout du dossier dossier_test"

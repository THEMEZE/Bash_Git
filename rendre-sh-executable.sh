#!/bin/bash

# Chemin vers le répertoire contenant les scripts .sh
scripts_folder="$HOME/Papier"

# Parcours des fichiers .sh dans le répertoire
for script_file in "$scripts_folder"/*.sh; do
    if [ -f "$script_file" ]; then
        echo "Rendre $script_file exécutable"
        chmod +x "$script_file"
    fi
done


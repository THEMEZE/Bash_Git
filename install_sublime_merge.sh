#!/bin/bash

# Fonction pour l'installation sur Linux
install_linux() {
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimehq-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null
    sudo apt-get update
    sudo apt-get install sublime-merge
}

# Fonction pour l'installation sur macOS via Homebrew
install_mac() {
    brew install --cask sublime-merge
}

# Fonction pour l'installation sur Windows
install_windows() {
    # Instructions d'installation pour Windows (à adapter)
    echo "Téléchargez l'installateur depuis le site officiel et suivez les étapes d'installation."
}

# Vérifier si Sublime Merge est installé
if command -v smerge &> /dev/null; then
    echo "Sublime Merge est déjà installé."
else
    # Détecter le système d'exploitation
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_linux
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        install_mac
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        install_windows
    else
        echo "Système d'exploitation non pris en charge."
    fi
fi

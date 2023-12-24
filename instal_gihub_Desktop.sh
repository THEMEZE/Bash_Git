#!/bin/bash

# Fonction pour installer GitHub Desktop sur Windows
install_github_desktop_windows() {
    # Vérifier si GitHub Desktop est déjà installé
    if ! command -v "GitHubDesktop.exe" &> /dev/null; then
        # Télécharger et installer GitHub Desktop
        echo "Installation de GitHub Desktop sur Windows..."
        # Ajoutez ici la commande d'installation spécifique à Windows
        # Par exemple, vous pouvez utiliser un gestionnaire de packages comme Chocolatey.
        chocolatey install github-desktop -y
    fi
}

# Fonction pour installer GitHub Desktop sur macOS
install_github_desktop_macos() {
    # Vérifier si GitHub Desktop est déjà installé
    if ! command -v "GitHub Desktop" &> /dev/null; then
        # Télécharger et installer GitHub Desktop
        echo "Installation de GitHub Desktop sur macOS..."
        # Ajoutez ici la commande d'installation spécifique à macOS
        # Par exemple, vous pouvez utiliser un gestionnaire de packages comme Homebrew.
        # brew install --cask github
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install --cask github

    fi
}

# Fonction pour installer GitHub Desktop sur Linux
install_github_desktop_linux() {
    # Vérifier si GitHub Desktop est déjà installé
    if ! command -v "github-desktop" &> /dev/null; then
        # Télécharger et installer GitHub Desktop
        echo "Installation de GitHub Desktop sur Linux..."
        # Ajoutez ici la commande d'installation spécifique à Linux
        # Par exemple, vous pouvez utiliser un gestionnaire de packages comme apt ou dnf.
        sudo apt-get install github-desktop
    fi
}

# Détecter le système d'exploitation
os=$(uname -s)

# Installer GitHub Desktop en fonction du système d'exploitation
case "$os" in
    "Darwin")
        install_github_desktop_macos
        open -a "GitHub Desktop"
        ;;
    "Linux")
        install_github_desktop_linux
        github-desktop
        ;;
    "MINGW"*|"CYGWIN"*|"MSYS"*)
        install_github_desktop_windows
        start "" "C:\Program Files\GitHub Desktop\GitHubDesktop.exe"
        ;;
    *)
        echo "Système d'exploitation non pris en charge."
        exit 1
        ;;
esac

# Lancer GitHub Desktop
echo "Lancement de GitHub Desktop..."
# Ajoutez ici la commande spécifique pour lancer GitHub Desktop
# Par exemple, vous pouvez utiliser la commande "open -a 'GitHub Desktop'" sur macOS.

exit 0


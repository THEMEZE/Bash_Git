# Étape 5: git-webui ,Initialiser Git en local
#Clonez simplement le référentiel et installez l'alias
#cd ~/Downloads/
#cd ~/Papier/
#echo "git webui existe déjà "
#echo "instalation git webui "
## automatique
# Using curl (Mac OS X & Windows):
#curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | bash
#Using wget (Linux):
#wget -O - https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | bash

## manuel
#git clone https://github.com/alberthier/git-webui.git
#git config --global alias.webui \!$PWD/git-webui/release/libexec/git-core/git-webui
#echo "fin instalation git webui "
#Si vous souhaitez autoriser la mise à jour automatique :
#git config --global webui.autoupdate true
#echo "fin autorisation la mise à jour automatique git webui "
#Premier CD sur l'un de vos projets versionné avec git
# Déinstalation
#echo "déinstalation  git webui "
## automatique
#Using curl (Mac OS X & Windows):
#curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/uninstaller.sh | bash
#Using wget (Linux):
#wget -O - #https://raw.githubusercontent#.com/alberthier/git-webui/master/install/uninstaller.sh | bash
## manuel
#rm -rf <git-webui-clone-path>
#git config --global --unset-all alias.webui
#git config --global --remove-section webui
#echo "fin déinstalation  git webui "

#!/bin/bash

install_git_webui() {
    echo "Instalation git webui..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OS X
        curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | bash
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        wget -O - https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | bash
    else
        echo "Unsupported operating system: $OSTYPE"
    fi
}

uninstall_git_webui() {
    echo "Déinstalation git webui..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OS X
        curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/uninstaller.sh | bash
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        wget -O - https://raw.githubusercontent.com/alberthier/git-webui/master/install/uninstaller.sh | bash
    else
        echo "Unsupported operating system: $OSTYPE"
    fi
}

# Check command-line arguments
cd ~/Papier/
if [ "$1" == "install" ]; then
    install_git_webui
elif [ "$1" == "uninstall" ]; then
    uninstall_git_webui
else
    echo "Usage: $0 [install|uninstall]"
fi

#Voici comment utiliser ce script :

#1 Enregistrez le script dans un fichier, par exemple git_webui_setup.sh.
#2 Donnez les permissions d'exécution au script : chmod +x git_webui_setup.sh.
#3 Pour installer git-webui, exécutez : ./git_webui_setup.sh install.
#4 Pour désinstaller git-webui, exécutez : ./git_webui_setup.sh uninstall.
#Ce script détecte automatiquement le système d'exploitation (Mac OS X ou Linux) et utilise curl ou wget pour installer ou désinstaller git-webui en conséquence. Assurez-vous de sauvegarder vos données et de comprendre les actions du script avant de l'exécuter.





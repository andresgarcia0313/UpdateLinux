#!/bin/bash

echo -e "\e[32mVerificando internet\e[0m"
if ping -c 1 google.com > /dev/null 2>&1; then
    echo -e "\e[32mHay Internet.\e[0m"
else
    echo -e "\e[32mSin internet, intenta luego.\e[0m"
    exit 1
fi

echo -e "\e[32mCredenciales\e[0m"
sudo -v

echo -e "\e[32mConfigurar paquetes\e[0m"
sudo dpkg --configure -a

echo -e "\e[32mSolucionar paquetes rotos 😊🔧\e[0m"
sudo apt install -f -y

echo -e "\e[32mActualización de repositorios\e[0m" 
sudo apt update
echo -e "\e[32mActualización de paquetes\e[0m"
sudo apt full-upgrade -y


echo -e "\e[32mActualización de paquetes universales\e[0m"
sudo snap refresh
sudo flatpak update -y


echo -e "\e[32mActualización del gestor de actualizaciones\e[0m"
sudo apt-get install -y update-manager-core

echo -e "\e[32mConfigurar paquetes\e[0m"
sudo dpkg --configure -a
echo -e "\e[32mLimpriar de actualizaciones\e[0m"
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

# Obtiene la ruta absoluta del script
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"

# Verifica si el alias ya está agregado
if ! grep -q "alias updateLinux='$SCRIPT_PATH/01Update.sh'" ~/.bashrc; then
    # Si no está agregado, entonces agrega el alias
    echo -e "\e[32mAlias 'updateLinux' agregado al archivo .bashrc.\e[0m"
    echo -e "\e[32mAhora puedes ejecutar 'updateLinux' desde cualquier lugar en tu terminal.\e[0m"
else
    # Si ya está agregado, muestra un mensaje indicando que ya existe
    echo -e "\e[32mEl alias 'updateLinux' ya está presente en el archivo .bashrc.\e[0m"
fi

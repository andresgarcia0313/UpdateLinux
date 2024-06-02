#!/bin/bash
# Este código actualiza programas en computadoras con Linux, asegurando mejoras
# y correcciones de errores. 🚀

echo "Verificar la conexión a internet"
if ping -c 1 google.com > /dev/null 2>&1; then
    echo "Conexión a Internet detectada. Comenzando la actualización..."
else
    echo "No se detectó una conexión a Internet. Verifica tu conexión y vuelve a intentarlo."
    exit 1
fi


echo "Pedir Credenciales"
sudo -v


echo "Actualización de los repositorios y paquetes"
sudo apt update
sudo apt full-upgrade -y
sudo apt install -f -y


echo "Actualización de snaps y flatpaks"
sudo snap refresh
sudo flatpak update -y


echo "Actualización del gestor de actualizaciones"
sudo apt-get install -y update-manager-core


echo "Actualización adicional del sistema"
sudo aptitude -y safe-upgrade


echo "Actualización del sistema completo"
sudo do-release-upgrade

echo "Configuración adicional y limpieza"
sudo dpkg --configure -a
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean


# echo "Reiniciar el sistema para aplicar los cambios"
# echo "Actualización completada. ¿Deseas reiniciar el sistema ahora? (s/n):"
# read -r reiniciar
# if [ "$reiniciar" == "s" ]; then
#     echo "Reiniciando el sistema..."
#     sudo reboot
# else
#     echo "No se reiniciará el sistema. Recuerda hacerlo más tarde para aplicar los cambios."
# fi

# Obtiene la ruta absoluta del script
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"

# Verifica si el alias ya está agregado
if ! grep -q "alias updateLinux='$SCRIPT_PATH/01Update.sh'" ~/.bashrc; then
    # Si no está agregado, entonces agrega el alias
    echo "alias updateLinux='$SCRIPT_PATH/01Update.sh'" >> ~/.bashrc
    echo "Alias 'updateLinux' agregado al archivo .bashrc."
    echo "Ahora puedes ejecutar 'updateLinux' desde cualquier lugar en tu terminal."
else
    # Si ya está agregado, muestra un mensaje indicando que ya existe
    echo "El alias 'updateLinux' ya está presente en el archivo .bashrc."
fi

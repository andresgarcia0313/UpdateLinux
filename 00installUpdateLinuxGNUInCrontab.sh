#!/bin/bash

# Nombre del archivo de instalador
instalador="installUpdateLinuxGNUInCrontab.sh"

# Nombre del archivo a instalar
archivo_instalar="updateLinuxGNU.sh"

#Solicitar la contraseña para realizar actividades como super usuario
sudo -v

# Obtener el nombre de usuario actual
usuario=$USER

# Otorga permisos de ejecución al script
chmod +x ./$instalador

# Copia el script de actualización a /usr/bin para instalarlo en la carpeta de ejecución de todos los usuarios
sudo cp $archivo_instalar /usr/bin

# Otorga permisos de ejecución al script
sudo chmod +x /usr/bin/$archivo_instalar

# Agrega una tarea cron para ejecutar el script de actualización todos los días a las 3:00 a.m.
(crontab -l ; echo "0 3 * * * /usr/bin/$archivo_instalar") | crontab -

# Modifica el archivo sudoers para permitir que se ejecute el script de actualización sin pedir contraseña en caso de no realizarse previamente
if ! sudo grep -q "ALL=(ALL) NOPASSWD: /usr/bin/$archivo_instalar" /etc/sudoers; then
   sudo echo "$usuario ALL=(ALL) NOPASSWD: /usr/bin/$archivo_instalar" | sudo tee -a /etc/sudoers >/dev/null
fi

#Eliminar duplicados de ejecución automatica a las 3 am si previamente se instalo la herramienta
crontab -l | awk '!seen[$0]++' | crontab -

# Mensaje de confirmación
echo "El archivo $archivo_instalar se ha instalado y se ha programado la tarea para ejecutarse a las 3 am."

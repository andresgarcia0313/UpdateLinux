#!/bin/bash


# NO FINALIZADO
# NO FINALIZADO
# NO FINALIZADO
# Se debe agregar la forma de detectar aplicativos no usados de forma eficiente


sudo -v
# Función para desinstalar un programa
desinstalar_programa() {
    programa=$1
    if dpkg -l | grep -q "^ii.*$programa"; then
        echo "$programa"
        #sudo apt-get purge $programa -y
        echo "Desinstalado: $programa"
    else
        echo "El programa $programa no está instalado."
    fi
}

# Obtener la lista de programas instalados
programas_instalados=$(dpkg-query -W -f='${Package} ${Status}\n' | grep "install ok installed" | awk '{print $1}')

# Obtener la fecha actual
fecha_actual=$(date +%s)

# Loop a través de los programas instalados
for programa in $programas_instalados; do
    # Verificar si el programa está en el menú de software del sistema
    if [ -f "/usr/share/applications/$programa.desktop" ]; then
        # Obtener la fecha de acceso del programa
        fecha_acceso=$(stat -c %X "/usr/share/applications/$programa.desktop")

        # Calcular el tiempo desde el último acceso en segundos
        tiempo_desde_acceso=$((fecha_actual - fecha_acceso))

        # Convertir 6 meses a segundos (30 días * 24 horas * 60 minutos * 60 segundos)
        seis_meses=$((30 * 24 * 60 * 60 * 6))

        # Verificar si el programa no se ha usado en los últimos 6 meses
        if [ $tiempo_desde_acceso -gt $seis_meses ]; then
            # Verificar si el programa afecta la estabilidad del sistema
            if ! grep -q "Essential: yes" "/var/lib/dpkg/available"; then
                desinstalar_programa "$programa"
            fi
        fi
    fi
done

echo "Desinstalación de programas innecesarios completada."

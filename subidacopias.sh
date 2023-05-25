#!/bin/bash

# Verifica si se proporcionaron todos los argumentos necesarios
if [ $# -lt 3 ]; then
    echo "Uso: $0 <usuario_github> <token_github> <ruta_completa_script>"
    exit 1
fi

# Usuario de GitHub
usuario_github="$1"
shift

# Token de GitHub
token_github="$1"
shift

# Ruta completa del script
ruta_script="$1"
shift

# Cambia al directorio del script
cd $(dirname "${ruta_script}")

# Obtiene los dos últimos archivos creados en la carpeta
archivos=$(ls -t | head -2)

# Copia los dos últimos archivos al repositorio clonado
cp $archivos /home/ranego/copias_seguridad

# Cambia al directorio del repositorio clonado
cd /home/ranego/copias_seguridad

# Agrega los archivos copiados
git add .

# Realiza un commit con un mensaje descriptivo
git commit -m "Subida automática de los últimos archivos a las 23:05"

# Autenticación con el token de GitHub
echo -n "Autenticando con GitHub... "
git config credential.helper store <<<"https://$usuario_github:$token_github@github.com"
echo "Hecho"

# Sube los cambios al repositorio remoto (GitHub)
git push origin master


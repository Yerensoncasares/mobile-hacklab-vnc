#!/bin/bash
# Detener procesos en ejecución, por ejemplo VNC
vncserver -kill :1

# Eliminar la carpeta del laboratorio
rm -rf ~/mobile-hacklab-vnc
rm -rf ~/.vnc

echo "Desinstalación completada."

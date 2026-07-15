# mobile-hacklab-vnc
Mobile HackLab optimizado para VNC en TV. Un entorno de escritorio Linux completo y estable directamente en tu Android, libre de publicidad.

Mobile HackLab VNC
Un entorno de escritorio Linux completo y estable directamente en tu dispositivo Android, optimizado para ser visualizado en televisores inteligentes.

Requisitos
Para poder instalar y ejecutar este laboratorio, asegúrate de cumplir con los siguientes puntos:
Disponer de la aplicación Termux instalada en tu terminal.
Ten en cuenta que este script está configurado para la arquitectura de procesador estándar de la mayoría de los televisores (ARMv7), aunque también es compatible con teléfonos (ARMv8).

Instrucciones de Instalación
​Copia el contenido de nuestro script ```install.sh``` en Termux.
​Ejecuta el script para que comience a instalar el servidor TigerVNC, el entorno XFCE4 y las herramientas adicionales.
​Conexión al Televisor
​Una vez instalado, ejecuta el comando ```bash ~/.start-hacklab.sh```.
​El script te pedirá que crees una contraseña y luego te mostrará la dirección IP y el puerto (5901).
​Abre tu cliente VNC en el Smart TV, introduce esos datos y ¡listo!

Puedes usar curl con este comando:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Yerensoncasares/mobile-hacklab-vnc/principal/instalar.sh)"
```
O también puedes usar wget de esta forma:
```
bash -c "$(wget -qO- https://raw.githubusercontent.com/Yerensoncasares/mobile-hacklab-vnc/principal/instalar.sh)"
```
Desinstalación

Para eliminar completamente el Lab del dispositivo, ejecuta el siguiente comando en Termux:

```
bash ./desinstalar.sh
```

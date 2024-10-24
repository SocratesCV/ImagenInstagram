#!/usr/bin/env bash
# ---------------------------------------------------------------------
# Autor: SocratesCV
# Creado con la ayuda del editor de texto Cursor, que es un editor de texto
# muy bueno y fácil de usar, ya que utiliza IA para su funcionamiento.

# Script para modificar las imágenes mediante la aplicación ImageMagick

# (0) Pasar al script una dirección de Instagram
# (1) Descargar la imagen con instaloader
# (2) Ponerle un marco y una sombra
# (3) Ponerle el logo de Instagram y el nombre del autor.
# (4) Cuadrar la imagen ya que algunas no son cuadradas.
# (5) Ampliar la imagen con el color de fondo: #288368
# (6) Mostrar la imagen.
#------------------------------------------------------------------------

# (0) Llamar al script
# imInstagram.sh 08497463

# CONSTANTES GLOBALES
# Porcentaje de incremento
INCREMENTO=10
# Color de fondo
COLOR=288368
# Imagen donde se guardará el resultado
FINAL="imagenFinal.png"
# Imagen para guardar paso intermedio.
INTERMEDIO="imagenConBorde.png"

# Verifica si no se han proporcionado argumentos
if [ $# -eq 0 ]; then
	echo "Debes proporcionar un nombre de imagen"
	# Sale del script con código de error 1
	exit 1
fi

# Mensaje de bienvenida
echo -e "\n"
echo "-------------------------------------------------"
echo "Cambiando la imagen $1 para Instagram."
echo "Le daremos un margen de un $INCREMENTO %"
echo "con el color de fondo $COLOR"
echo "-------------------------------------------------"
echo " "
sleep 3

# Guarda el primer argumento como número de imagen
imagenInicial=$1
# Verifica si el archivo de imagen inicial existe
if [ ! -f "$imagenInicial" ]; then
	echo "Error: El archivo de imagen $imagenInicial no existe"
	exit 1
fi

# Verifica si las variables INCREMENTO y COLOR están definidas
if [ -z "$INCREMENTO" ]; then
	echo "Error: La variable INCREMENTO no está definida"
	exit 1
fi

if [ -z "$COLOR" ]; then
	echo "Error: La variable COLOR no está definida"
	exit 1
fi

# Verifica si el comando 'convert' de ImageMagick está disponible
if ! command -v convert &>/dev/null; then
	echo "Error: El comando 'convert' de ImageMagick no está disponible"
	exit 1
fi

# Verifica si el comando 'identify' de ImageMagick está disponible
if ! command -v identify &>/dev/null; then
	echo "Error: El comando 'identify' de ImageMagick no está disponible"
	exit 1
fi

######################################
# He comentado todo este código ya que no funciona instaloader.
######################################

# nombreArchivo="imagen${1}.jpg"
#
#  # Este fragmento de script hace lo siguiente:

#  # 1. Utiliza instaloader para descargar una imagen de Instagram
#  # El comando especifica el directorio de destino y el nombre del archivo
#  # El número de la imagen se pasa como argumento al script
#  # Mejoras:
#  # - Añadir manejo de errores
#  # - Usar variables para el directorio y opciones
#  # - Mostrar progreso al usuario
# DIRECTORIO_DESTINO="dirimagen"
# OPCIONES_INSTALOADER="--quiet --no-metadata-json --no-video-thumbnails"

# echo "Descargando imagen de Instagram..."
# if ! instaloader $OPCIONES_INSTALOADER --dirname=$DIRECTORIO_DESTINO --filename=$nombreArchivo -- -$imagenInicial; then
#     echo "Error: No se pudo descargar la imagen de Instagram"
#     exit 1
#   fi

# echo "Imagen descargada con éxito"

#  # 2. Verifica si el archivo descargado existe
#  # Si existe, asigna la ruta del archivo a la variable 'return'
#  # Si no existe, muestra un mensaje de error y termina el script
#  if [ ! -f "dirimagen/$nombreArchivo" ]; then
#     echo "Error: El archivo $nombreArchivo no ha podido crearse"
#     exit 1
#   fi
#######################################

# Este código utiliza el comando 'convert' de ImageMagick para procesar una imagen:
# 1. Añade un borde blanco de 1 píxel
# 2. Añade un borde gris de 1 píxel
# 3. Crea una sombra negra
# 4. Combina la imagen original con la sombra
# 5. Establece un fondo de color '#288368' (verde azulado)
# 6. Guarda el resultado en la imagen intermedia ($INTERMEDIO)
convert $imagenInicial -bordercolor white -border 1 \
	-bordercolor grey60 -border 1 \
	\( +clone -background black -shadow 60x4+4+4 \) +swap \
	v -background '#288368' -mosaic $INTERMEDIO

# Este código realiza las siguientes acciones:

# 1. Obtiene las dimensiones de la imagen intermedia
ancho=$(identify -format %w $INTERMEDIO)
alto=$(identify -format %h $INTERMEDIO)

# 2. Determina el lado más largo de la imagen
if [[ $ancho -gt $alto ]]; then
	maxValor=$ancho
else
	maxValor=$alto
fi

# 3. Calcula el nuevo tamaño de la imagen, aumentándolo según el porcentaje especificado en $INCREMENTO
valorFinal=$((maxValor * (100 + INCREMENTO) / 100))
echo $valorFinal

# 4. Convierte la imagen a un cuadrado, centrándola y rellenando el fondo con el color '#288368'
# El nuevo tamaño es $valorFinal x $valorFinal
convert $INTERMEDIO -gravity center -background '#288368' -extent "${valorFinal}x${valorFinal}" $FINAL

# En resumen, este código toma una imagen, la convierte en un cuadrado
# y aumenta su tamaño, manteniendo la imagen original centrada y rellenando
# el espacio adicional con un color de fondo específico.

# #############################################################
# Podría preguntar en que color hacer el logo y el texto.
# Añadir el código que añade el logotipo de instagram y el nombre del autor.
# Mostrar el resultao y si no convence preguntar que se quiere modificar, vertical, horizontal o color.
# Esto anterior sería hacerlo con un while o utilizando funciones.
# ######################################################

# Movemos el archivo original
mv dirimagen/$nombreArchivo ./originales/

# mostramos el archivo
# Cerramos la ventana con "q"
display $FINAL

# Fin del archivo.
#-----------------

#!/usr/bin/env bash
# ---------------------------------------------------------------------
# Autor: SocratesCV

# Scrip para modificar las imágenes mediante la aplicación imageMagick
# Es mi primer script y tendrá muchos fallos, errores y cosas a mejorar
# intentaré mejorarlo y actualizarlo. Me a servido par aprender y dar 
# un primer paso.
#------------------------------------------------------------------------



# CONSTANTES GLOBALES
# Porcentaje de imcremento 
INCREMENTO=10
# Color de fondo
COLOR=288368
#imagen inicial que vamos a transformar
INICIAL=comprobarParametros
#imagen donde se guardará el resultado
FINAL="imagenFinal.png"
#imagen para guardar paso intermedio.
INTERMEDIO="imagenConBorde.png"

# Funciones...
#
# Función que verifica que se haya pasado  los argumentos correctos
function comprobarParametros{ 
  if [$# -eq 0]; then
    echo "Debes proporcinar un número de imagen"
    exit 1 
  fi 

  # Guardar el numero pasado como argumento
  numero=$2 

  # construimos el nombre del archivo
  archivo="imagen${numero}.jpg"
  return=$archivo
 
}



# Funcion con la que descargaremos una imagen de instagram utilizando instaloader()
function descargaImagen(){
  instaloader --dirname=dirimagen --filename=imagenInicial -- -$1 

  # Verifica que el archivo exite
  if [ -f "$archivo" ]; then
    return=$archivo
  else
    echo "El archivo $archivo no exite."
    exit 1 
  fi 

}

# Funcion mensaje, muestra un mensaje por pantalla
function mensajeInicial(){

  echo "  "\n
  echo "-------------------------------------------------"
  echo Cambiando la imagen $1 para Instagram.
  echo le daremos un margen de un $INCREMENTO %
  echo con el color de fondo $COLOR
  echo "-------------------------------------------------"
  echo " "
  sleep 3
}

# Funcion para crear un pequeño borde sombreado entorno a la imagen 
function bordeSombreado{ 
  convert ~/dirimagen/$INICIAL -bordercolor white -border 1 \
  -bordercolor grey60 -border 1 \
  \( +clone -background black -shadow 60x4+4+4 \) +swap \
  v	-background '#288368' -mosaic $INTERMEDIO 
}


mensajeInicial
descargaImagen
bordeSombreado

# Vemos los parámetros de la imagen que le hemos pasado.
ancho=$(identify -format %w $INTERMEDIO )
alto=$(identify -format %h $INTERMEDIO)

# Buscamos el valor más alto.
if [[ $ancho -gt $alto ]]
then 
	maxValor=$ancho
else
	maxValor=$alto
fi

valorFinal=$(expr $maxValor \* $INCREMENTO / 100 + $maxValor)
echo $valorFinal

#cuadramos la imagen y le incrementamos un porcentaje INCREMENTO
convert $INTERMEDIO -gravity center -background '#288368' -extent "$valorFinal"x"$valorFinal" $FINAL

# Movemos el archivo original
mv $1 ./originales/

# mostramos el archivo
# Cerramos la ventana con "q"
display $FINAL

# Fin del archivo.
#-----------------

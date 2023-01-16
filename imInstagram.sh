#!/usr/bin/env bash
# Scrip para modificar las imágenes mediante la aplicación imageMagick

# Porcentaje de imcremento 
INCREMENTO=10
# Color de fondo
COLOR=288368

echo "  "\n
echo "-------------------------------------------------"
echo Cambiando la imagen $1 para Instagram.
echo le daremos un margen de un $INCREMENTO %
echo con el color de fondo $COLOR
echo "-------------------------------------------------"
echo " "

identify $1

# Vemos los parámetros de la imagen que le hemos pasado.
ancho=$(identify -format %w $1)
alto=$(identify -format %h $1)

# Buscamos el valor más alto.
if [[ $ancho -gt $alto ]]
then 
	maxValor=$ancho
else
	maxValor=$alto
fi

echo "Ancho $ancho"
echo "Alto $alto"

echo "Cuadramos la imagen a $maxValor"

echo "Un incremento de $INCREMENTO % de $maxValor es " 
valorFinal=$(expr $maxValor \* $INCREMENTO / 100 + $maxValor)
echo $valorFinal

#cuadramos la imagen y le incrementamos un porcentaje INCREMENTO
convert $1 -gravity center -background '#288368' -extent "$valorFinal"x"$valorFinal" imagenFinal.png

# Movemos el archivo original
mv $1 ./originales

# mostramos el archivo
# Cerramos la ventana con "q"
display imagenFinal.png

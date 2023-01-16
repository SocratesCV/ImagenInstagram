#!/usr/bin/env bash
# Scrip para modificar las imágenes mediante la aplicación imageMagick

# Porcentaje de imcremento 
INCREMENTO=10
# Color de fondo
COLOR=288368
#imagen donde se guardará el resultado
FINAL="imagenFinal.png"
#imagen para guardar paso intermedio.
INTERMEDIO="imagenConBorde.png"



display $1

echo "  "\n
echo "-------------------------------------------------"
echo Cambiando la imagen $1 para Instagram.
echo le daremos un margen de un $INCREMENTO %
echo con el color de fondo $COLOR
echo "-------------------------------------------------"
echo " "

convert $1 -bordercolor white -border 1 \
	-bordercolor grey60 -border 1 \
	\( +clone -background black -shadow 60x4+4+4 \) +swap \
	-background '#288368' -mosaic $INTERMEDIO 

display $INTERMEDIO

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

echo "Ancho $ancho"
echo "Alto $alto"

echo "Cuadramos la imagen a $maxValor"

echo "Un incremento de $INCREMENTO % de $maxValor es " 
valorFinal=$(expr $maxValor \* $INCREMENTO / 100 + $maxValor)
echo $valorFinal

#cuadramos la imagen y le incrementamos un porcentaje INCREMENTO
convert $INTERMEDIO -gravity center -background '#288368' -extent "$valorFinal"x"$valorFinal" $FINAL

# Movemos el archivo original
# mv $1 ./originales


# convert prueba.png \( +clone  -background "288368" -shadow 80x3+5+5 \) +swap \              -background none   -layers merge  +repage   prueba2.png
# mostramos el archivo
# Cerramos la ventana con "q"
display $FINAL

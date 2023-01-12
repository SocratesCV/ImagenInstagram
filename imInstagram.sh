#!/usr/bin/env bash
# Scrip para modificar las imágenes mediante la aplicación imageMagick

INCREMENTO=10
COLOR=288368

echo "  "\n
echo "-------------------------------------------------"
echo Cambiando la imagen $1 para Instagram.
echo le daremos un margen de un $INCREMENTO %
echo con el color de fondo $COLOR
echo "-------------------------------------------------"
echo " "

# Vemos los parámetros de la imagen que le hemos pasado.
identify $1

# ancho x Alto
# después nos pedirá el mayor de los dos (deberá hacerlo automaticamente cuando sepa como)
# Le daremos como parámetro el lado mayor y cuadrará la imagen. Añadiendo lo que falta
# con el color de fondo '288368'

read -p " Dame el valor mayor de la imagen " maxValor

echo "El 110% de $maxValor =" 
valorFinal=$(expr $maxValor \* $INCREMENTO / 100 + $maxValor)
echo $valorFinal

#cuadramos la imagen y le incrementamos un porcentaje INCREMENTO
convert $1 -gravity center -background '#288368' -extent "$valorFinal"x"$valorFinal" finaltotal.png

#Movemos el archivo original
mv $1 ./originales

#mostramos el archivo
# Cerramos la ventana con "q"
display finaltotal.png

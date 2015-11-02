#!/bin/bash

# Devuelve el ancho de banda de salida de la tarjeta de red juju-br0 
# en Bytes/segundo

tiempo=2

anterior=`sudo cat /proc/net/dev | grep juju-br0 | tr -s ' ' | cut -d " " -f 10`
sleep $tiempo
actual=`sudo cat /proc/net/dev | grep juju-br0 | tr -s ' ' | cut -d " " -f 10`
bitrate=$(( (actual-anterior)/$tiempo ))
echo $bitrate



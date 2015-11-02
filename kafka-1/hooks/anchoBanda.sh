#!/bin/bash

# Devuelve el ancho de banda de entrada de la tarjeta de red juju-br0 
# en Bytes/segundo

tiempo=2

anterior=`sudo cat /proc/net/dev | grep juju-br0 | cut -d " " -f 2`
sleep $tiempo
actual=`sudo cat /proc/net/dev | grep juju-br0 | cut -d " " -f 2`
bitrate=$(( (actual-anterior)/$tiempo ))
echo $bitrate

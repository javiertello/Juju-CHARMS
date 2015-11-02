#!/bin/bash

# Global Variables for the charm
APPNAME="rts.spark"
DEST_FOLDER="/opt/spark"
#CONFIG_FILE="${DEST_FOLDER}/${APPNAME}/src/main/resources/rts.spark.properties"
CONFIG_FILE_NAME="rts.spark.properties"
CONFIG_FILE="/home/ubuntu/$CONFIG_FILE_NAME"
#JARFILE="target/rts.spark-0.0.1.jar"
JARFILE="CuentaEventos.jar"
KAFKA_BROKERS=`cat ${CONFIG_FILE} | grep rts.spark.khosts | cut -d':' -f2- | tr -d ' '`

#!/bin/bash

# Global Variables for the charm
APPNAME="kafka-smart-grid"
DEST_FOLDER="/opt/${APPNAME}"
CONFIG_FILE="/etc/${APPNAME}/producer.conf"
DATA_SET="sorted100M.csv"
SERVER_URL="http://10.8.8.254/datasets/"

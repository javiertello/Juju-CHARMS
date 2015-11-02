#!/bin/bash

sudo -i
cd /opt/kafka/bin
./kafka-reassign-partitions.sh --zookeeper $1 --topics-to-move-json-file /tmp/topics-to-move.json --broker-list $2 --generate | sed -n -e '/Proposed partition reassignment configuration/,$p' | grep -v "Proposed partition reassignment configuration" | grep -v \"^$\" > /tmp/expand-cluster-reassignment.json

./kafka-reassign-partitions.sh --zookeeper $1 --reassignment-json-file /tmp/expand-cluster-reassignment.json --execute

cd -
exit

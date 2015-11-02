# Juju-CHARMS

Set of charms that implement a distributed event processing infrastructure.

Contains:
* __kafka__: Kafka service that scales up dynamically
* __kafka-smart-grid__: Kafka producer service. It produces synthetic smart-grid events from several nodes
* __spark-processing__: Apache Spark service which reads data form Kafka brokers and processes the data 
* __zabbix-agent__: Zabbix agent service that monitors the network usage of Kafka brokers to let the ability to scale up automatically

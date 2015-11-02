Kafka
=====

Scalable distributed publish/subscribe system built ontop of a distributed log.


Install
-------

 $ juju deploy zookeeper
 $ juju deploy kafka
 $ juju add-relation kafka zookeeper

Usage
-----

First we need to get a hold of the zookeeper servers that are kafka brokers
are connected to:

 $ juju run --unit=kafka/0 "./hooks/utils.py"
 10.0.3.221:2181

We can list all the cli commands available to us via

 $ juju run --unit=kafka/0 "ls bin"

 kafka-console-consumer.sh
 kafka-console-producer.sh
 kafka-consumer-perf-test.sh
 kafka-preferred-replica-election.sh
 kafka-producer-perf-test.sh
 kafka-reassign-partitions.sh
 kafka-replay-log-producer.sh
 kafka-simple-consumer-perf-test.sh
 kafka-simple-consumer-shell.sh
 kafka-topics.sh

We can create a topic with

 $ juju run --unit=kafka/0 "./bin/kafka-topics.sh --zookeeper 10.0.3.221:2181  --create --topic my_topic_name  --partitions 5 --replication-factor 1"

We can list topics with

 $ juju run --unit=kafka/0 "./bin/kafka-topics.sh --zookeeper 10.0.3.221:2181  --list"






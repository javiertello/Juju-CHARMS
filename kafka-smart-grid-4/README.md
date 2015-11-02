# Overview

This charm will install a specific Kafka application dedicated to consuming a smart-grid data set and send all messages to a Kafka broker.

Note that this application is useless if not used in combination with a Kafka Server / Broker cluster

# Usage

In essence, you will need a Kafka cluster to make it run. As Kafka requires a Zookeeper cluster to run, we are also going to deploy that. 

Your first taks will be to select your favourite Hadoop distribution and select the Zookeeper from that distribution. The below example shows a vanilla version, but hdp-zookeeper would work. 

    :~$ juju deploy trusty/zookeeper
    :~$ juju deploy trusty/kafka
    :~$ juju add-relation kafka zookeeper

This will make sure you have a cluster available with an up & running Kafka broker. 

Now install this Producer and add a relation between it and the Kafka Broker. 

    :~$ juju deploy trusty/kafka-smart-grid
    :~$ juju add-relation kafka-smart-grid kafka

## Scale out Usage

You can scale by adding kafka units:

    :~$ juju add-unit kafka -n 3

You can also increase the number of partitions Kafka uses in the configuration file. This doesn't come as a configuration option in this charm so please notify if you need it and I can add this. 

## HA usage

Production environments usually run ZooKeeper in a HA mode with 3 nodes. You can do so by running: 

    :~# juju add-unit zookeeper -n 2

## Known Limitations and Issues

The default configuration for Kafka doesn't work well for our purpose as it clearly assumes a complete and extensive production environment. So we are going to change some variables to make it sustainable for an AWS m1.small instance. Note that those changes are not mandatory if you run enough disk space. 

First of all connect to your kafka server, edit the server details with your favorite editor. We'll use Nano for the purpose of this example, and only write what lines we change / update

    :~$ juju ssh kafka/0
    :~$ sudo nano /opt/kafka/config/server.properties

OK now let's modify

    # log.retention.hours=168
    log.retention.hours=24

    # log.cleaner.enable=false
    log.cleaner.enable=true


Then you should restart Kafka. 

    sudo service kafka restart

you can also run the same from your computer with 

    :~# juju run --service=kafka '(sed -i -e s/^log\.retention\.hours.*/log\.retention\.hours\=24/ -e s/^log.cleaner.enable.*/log\.cleaner\.enable\=true) && service kafka restart'

We should also check the ZooKeeper connection string. In some occasions if the ZooKeeper charm is not the one planed it may fail to expose the right URL. So let's have a look at **zookeeper.connect** and make sure it is OK.


# Contact Information

Maintener of this charm: Javier Tello <jtelloal@gmail.com>

## Upstream Project Name

This charm is based on https://jujucharms.com/u/samuel-cozannet/kafka-twitter/trusty/1


package com.kafka.producer;

import kafka.producer.Partitioner;
import kafka.utils.VerifiableProperties;
 
public class RoundRobinPartitioner implements Partitioner {
    public RoundRobinPartitioner (VerifiableProperties props) {
 
    }
 
    public int partition(Object key, int a_numPartitions) {
        int partition = 0;
        String stringKey = (String) key;
	Integer integerKey = Integer.parseInt(stringKey);
        partition = integerKey % a_numPartitions;

        return partition;
  }
 
}

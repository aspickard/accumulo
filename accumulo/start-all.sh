#!/bin/bash


#Start Zookeeper
$ACCUMULO_SETUP_DIR/start_zookeeper.sh

#Start Hadoop Services
$ACCUMULO_SETUP_DIR/start_hadoop.sh

#Start Accumulo
$ACCUMULO_SETUP_DIR/start_accumulo.sh

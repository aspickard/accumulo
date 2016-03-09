#!/bin/bash

#Start Hadoop Services
$ACCUMULO_SETUP_DIR/start_hadoop.sh

#Start Zookeeper
$ACCUMULO_SETUP_DIR/start_zookeeper.sh

#Start Accumulo
$ACCUMULO_SETUP_DIR/start_accumulo.sh

#!/bin/bash

export USER=`whoami`

#Set hadoop env
$HADOOP_HOME/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid
#Start Supervisor for SSHD
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

#Start Hadoop Services
#Start Name Node
$ACCUMULO_SETUP_DIR/start_hadoop.sh

#Initialize HDFS
$HADOOP_LIBEXEC_DIR/init-hdfs.sh

#Start Zooker.sheeper
$ACCUMULO_SETUP_DIR/start_zookeeper.sh

#Initiate Accumulo
$ACCUMULO_HOME/bin/accumulo init --instance-name accumulo --password secret

#Reset the hadoop env
$HADOOP_HOME/etc/hadoop/hadoop-env.sh

#Stop Zookeeper
$ACCUMULO_SETUP_DIR/stop_zookeeper.sh

#Stop Hadoop Services
$ACCUMULO_SETUP_DIR/stop_hadoop.sh

unset USER
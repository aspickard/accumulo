#!/bin/bash

export USER=`whoami`

#Set hadoop env
$HADOOP_HOME/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

#Start Supervisor for SSHD
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

#Start Zookeeper
$ACCUMULO_SETUP_DIR/start_zookeeper.sh

#Start Hadoop Services
#Start Name Node
$ACCUMULO_SETUP_DIR/start_hadoop.sh

$HADOOP_HDFS_HOME/bin/hdfs dfsadmin -safemode wait

#Initialize HDFS
$HADOOP_LIBEXEC_DIR/init-hdfs.sh

#Initiate Accumulo
$ACCUMULO_HOME/bin/accumulo init --instance-name accumulo --password secret

#Reset the hadoop env
$HADOOP_HOME/etc/hadoop/hadoop-env.sh

#Stop Hadoop Services
$ACCUMULO_SETUP_DIR/stop_hadoop.sh

#Stop Zookeeper
$ACCUMULO_SETUP_DIR/stop_zookeeper.sh
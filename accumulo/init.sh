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

$ACCUMULO_SETUP_DIR/start-all.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

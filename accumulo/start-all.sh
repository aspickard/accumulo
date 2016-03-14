#!/bin/bash


sed s/HOSTNAME/$HOSTNAME/ $HADOOP_CONF_DIR/core-site.xml.template > $HADOOP_CONF_DIR/core-site.xml

sed "s/HOSTNAME/$HOSTNAME/g" $ACCUMULO_HOME/conf/accumulo-site-template.xml > $ACCUMULO_HOME/conf/accumulo-site.xml
sed "s/HOSTNAME/$HOSTNAME/g" $ACCUMULO_HOME/conf/client.conf.template > $ACCUMULO_HOME/conf/client.conf

echo $HOSTNAME > $ACCUMULO_HOME/conf/gc
echo $HOSTNAME > $ACCUMULO_HOME/conf/masters
echo $HOSTNAME > $ACCUMULO_HOME/conf/monitor
echo $HOSTNAME > $ACCUMULO_HOME/conf/slaves
echo $HOSTNAME > $ACCUMULO_HOME/conf/tracers

#Start Supervisor for SSHD
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

#Start Zookeeper
$ACCUMULO_SETUP_DIR/start_zookeeper.sh

#Start Hadoop Services
$ACCUMULO_SETUP_DIR/start_hadoop.sh

#Start Accumulo
$ACCUMULO_SETUP_DIR/start_accumulo.sh

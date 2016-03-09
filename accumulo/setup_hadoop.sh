#!/bin/bash

#altering the hadoop-env.sh
sed -i '/^export JAVA_HOME/ s:.*:'"export JAVA_HOME=$JAVA_HOME\nexport HADOOP_HOME=$HADOOP_HOME\n"':' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sed -i '/^export HADOOP_CONF_DIR/ s:.*:'"export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/"':' $HADOOP_HOME/etc/hadoop/hadoop-env.sh

mkdir $HADOOP_PREFIX/input
cp $HADOOP_CONF_DIR/*.xml $HADOOP_PREFIX/input

#Create directories for hdfs files and mapred temporary files
mkdir -p /data/hadoop
chown -R hdfs:hadoop /data/hadoop
 
# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ $HADOOP_CONF_DIR/core-site.xml.template > $HADOOP_CONF_DIR/core-site.xml

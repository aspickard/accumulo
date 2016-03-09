#!/bin/bash

cp $ACCUMULO_HOME/conf/examples/1GB/standalone/* $ACCUMULO_HOME/conf/

sed -i '/export HADOOP_PREFIX/ s:export HADOOP_PREFIX.*:'"export HADOOP_PREFIX=$HADOOP_PREFIX"':' $ACCUMULO_HOME/conf/accumulo-env.sh
sed -i '/export JAVA_HOME/ s:export JAVA_HOME.*:'"export JAVA_HOME=$JAVA_HOME"':' $ACCUMULO_HOME/conf/accumulo-env.sh
sed -i '/export ZOOKEEPER_HOME/ s:export ZOOKEEPER_HOME.*:'"export ZOOKEEPER_HOME=$ZOOKEEPER_HOME"':' $ACCUMULO_HOME/conf/accumulo-env.sh
sed -i '/$HADOOP_PREFIX\/share\/hadoop\/common/ s::'"$HADOOP_PREFIX"':' $ACCUMULO_HOME/conf/accumulo-site.xml
sed -i '/$HADOOP_PREFIX\/share\/hadoop\/hdfs/ s::'"$HADOOP_HDFS_HOME"':' $ACCUMULO_HOME/conf/accumulo-site.xml
sed -i '/$HADOOP_PREFIX\/share\/hadoop\/mapreduce/ s::'"$HADOOP_MAPRED_HOME"':' $ACCUMULO_HOME/conf/accumulo-site.xml
sed -i '/$HADOOP_PREFIX\/share\/hadoop\/yarn/ s::'"$HADOOP_YARN_HOME"':' $ACCUMULO_HOME/conf/accumulo-site.xml
sed -i '/$HADOOP_PREFIX\/share\/hadoop\/yarn\/lib/ s::'"$HADOOP_YARN_HOME/lib"':' $ACCUMULO_HOME/conf/accumulo-site.xml

echo $HOSTNAME > $ACCUMULO_HOME/conf/gc
echo $HOSTNAME > $ACCUMULO_HOME/conf/masters
echo $HOSTNAME > $ACCUMULO_HOME/conf/monitor
echo $HOSTNAME > $ACCUMULO_HOME/conf/slaves
echo $HOSTNAME > $ACCUMULO_HOME/conf/tracers

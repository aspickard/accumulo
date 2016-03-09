#!/bin/bash

mkdir -p /var/zookeeper/logs;
mkdir $ZOOKEEPER_HOME/conf/backup

cp $ZOOKEEPER_HOME/conf/* $ZOOKEEPER_HOME/conf/backup


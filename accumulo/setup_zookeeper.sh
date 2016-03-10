#!/bin/bash

mkdir -p /var/zookeeper/logs
mkdir -p $ZOOKEEPER_HOME/conf/backup

rsync -av --progress $ZOOKEEPER_HOME/conf $ZOOKEEPER_HOME/conf/backup --exclude backup

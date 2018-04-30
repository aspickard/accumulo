#!/bin/bash
cp -r $ACCUMULO_HOME/conf/* $ACCUMULO_SETUP_DIR/conf/
cp $ACCUMULO_HOME/proxy/proxy.properties $ACCUMULO_SETUP_DIR/conf/proxy.properties

chmod 755 $ACCUMULO_SETUP_DIR/*.sh

rm -rf $ACCUMULO_HOME/conf/
ln -s $ACCUMULO_SETUP_DIR/conf $ACCUMULO_HOME

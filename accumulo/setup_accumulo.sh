#!/bin/bash
cp -r $ACCUMULO_HOME/conf/* $ACCUMULO_SETUP_DIR/conf/
sed "s/test/accumulo/g" $ACCUMULO_HOME/proxy/proxy.propeties > $ACCUMULO_SETUP_DIR/conf/proxy.properties

chmod 755 $ACCUMULO_SETUP_DIR/*.sh

rm -rf $ACCUMULO_HOME/conf/
ln -s $ACCUMULO_SETUP_DIR/conf $ACCUMULO_HOME

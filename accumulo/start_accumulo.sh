#!/bin/bash

ADDRESS="$(hostname -I)"

sed "s/HOSTNAME/$ADDRESS/g" $ACCUMULO_HOME/conf/accumulo-site-template.xml > $ACCUMULO_HOME/conf/accumulo-site.xml
sed "s/HOSTNAME/$ADDRESS/g" $ACCUMULO_HOME/conf/client.conf.template > $ACCUMULO_HOME/conf/client.conf

echo $ADDRESS > $ACCUMULO_HOME/conf/gc
echo $ADDRESS > $ACCUMULO_HOME/conf/masters
echo $ADDRESS > $ACCUMULO_HOME/conf/monitor
echo $ADDRESS > $ACCUMULO_HOME/conf/slaves
echo $ADDRESS > $ACCUMULO_HOME/conf/tracers

#Start Accumulo
su -s /bin/bash accumulo -c '$ACCUMULO_HOME/bin/start-all.sh'

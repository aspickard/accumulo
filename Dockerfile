FROM ceagan/wildfly:9.0.2.Final

USER root

RUN yum install -y curl which tar sudo openssh-server openssh-clients rsync supervisor && \
	yum update -y libselinux && \
	mkdir -p /var/run/sshd /var/log/supervisor && \
	curl -LO https://archive.cloudera.com/cdh5/one-click-install/redhat/7/x86_64/cloudera-cdh-5-0.x86_64.rpm && \
	yum -y --nogpgcheck localinstall cloudera-cdh-5-0.x86_64.rpm && \
	rpm --import http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera && \
	yum install -y hadoop-conf-pseudo && \
	curl -s http://apache.claz.org/accumulo/1.6.5/accumulo-1.6.5-bin.tar.gz | tar -xz -C /usr/lib && \
	ln -s /usr/lib/accumulo-1.6.5 /usr/lib/accumulo && \
	chown -R root:root /usr/lib/accumulo-1.6.5 && \
	yum clean all
#Check line 7 see if docker has it by default
#Supervisord for managing the services
ADD supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
	ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
	ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#Hadoop, Zookeeper and Accumulo Environment Variables
ENV HOSTNAME=localhost HADOOP_HOME=/usr/lib/hadoop HADOOP_PREFIX=/usr/lib/hadoop \
	HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec HADOOP_COMMON_HOME=/usr/lib/hadoop HADOOP_HDFS_HOME=/usr/lib/hadoop-hdfs \
	HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce HADOOP_YARN_HOME=/usr/lib/hadoop-yarn \
	HADOOP_CONF_DIR=/usr/lib/hadoop/etc/hadoop YARN_CONF_DIR=/usr/lib/hadoop-yarn/etc/hadoop \
	ACCUMULO_SETUP_DIR=/etc/accumulo ZOOKEEPER_HOME=/usr/lib/zookeeper ACCUMULO_HOME=/usr/lib/accumulo
	
ENV PATH=$PATH:$HADOOP_HOME/bin:$JAVA_HOME/bin:$ACCUMULO_HOME/bin:$ZOOKEEPER_HOME/bin

ADD hadoop/ssh_config /root/.ssh/config
ADD accumulo/* $ACCUMULO_SETUP_DIR/
ADD hadoop/conf/core-site.xml.template $HADOOP_CONF_DIR/

RUN chmod 600 /root/.ssh/config && \
	chown root:root /root/.ssh/config && \
	chmod 700 $ACCUMULO_SETUP_DIR/*.sh && \
	chown root:root $ACCUMULO_SETUP_DIR/*.sh	

RUN $ACCUMULO_SETUP_DIR/setup_hadoop.sh && \
	$ACCUMULO_SETUP_DIR/setup_zookeeper.sh && \
	$ACCUMULO_SETUP_DIR/setup_accumulo.sh

#Replace Hadoop and Zookeeper Configuration
ADD hadoop/conf/*.xml $HADOOP_CONF_DIR/
ADD zookeeper/* $ZOOKEEPER_HOME/conf/

USER hdfs
RUN  hdfs namenode -format

USER root

###PORTS	
## Hdfs ports
# Data Node - 50010, 50020, 50075
# Name Node - 8020, 9000, 50070
# Secondary Name Node 50090
EXPOSE 50010 50020 50070 50075 50090 8020 9000
## Mapred ports
EXPOSE 19888
## Yarn ports
# Resource Manager - 8030, 8031, 8032, 8033, 8088
# Node Manager - 8040, 8042
EXPOSE 8030 8031 8032 8033 8040 8042 8088
## Other ports
EXPOSE 49707 2122
## Zookeeper Ports
EXPOSE 2181
## Accumulo Ports
EXPOSE 2181 50095

CMD ["/etc/accumulo/init.sh", "-bash"]


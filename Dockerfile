FROM jakubzapletal/java:jdk-8-oracle

MAINTAINER Jakub Zapletal <zapletal.jakub@gmail.com>

# Install ActiveMQ 5.10.0
RUN \
    curl http://archive.apache.org/dist/activemq/5.10.0/apache-activemq-5.10.0-bin.tar.gz | tar xz && \
    cp apache-activemq-5.10.0/conf/activemq.xml apache-activemq-5.10.0/conf/activemq.xml.orig

ADD scripts/activemq.xml apache-activemq-5.10.0/conf/activemq.xml

# Install hawtio
RUN \
    mkdir apache-activemq-5.10.0/webapps/hawtio && \
    curl -L https://oss.sonatype.org/content/repositories/public/io/hawt/hawtio-default/1.4.45/hawtio-default-1.4.45.war >> apache-activemq-5.10.0/webapps/hawtio/hawtio-default-1.4.45.war && \
    cd apache-activemq-5.10.0/webapps/hawtio && \
    jar -xf hawtio-default-1.4.45.war && \
    rm hawtio-default-1.4.45.war

ADD scripts/jetty.xml apache-activemq-5.10.0/conf/jetty.xml

EXPOSE 61612 61613 61616 8161

CMD java -Dhawtio.authenticationEnabled=false -Xms1G -Xmx1G -Djava.util.logging.config.file=logging.properties -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote -Djava.io.tmpdir=apache-activemq-5.10.0/tmp -Dactivemq.classpath=apache-activemq-5.10.0/conf -Dactivemq.home=apache-activemq-5.10.0 -Dactivemq.base=apache-activemq-5.10.0 -Dactivemq.conf=apache-activemq-5.10.0/conf -Dactivemq.data=/data -jar apache-activemq-5.10.0/bin/activemq.jar start

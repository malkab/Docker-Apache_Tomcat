FROM malkab/java:server_jre_8u162_x64

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"

ENV ANT_HOME /usr/local/apache-ant-1.10.1
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.7
ENV PATH $ANT_HOME/bin:$PATH
ENV LD_LIBRARY_PATH $CATALINA_HOME/lib:$LD_LIBRARY_PATH

# Proxy
ENV PROXY false
ENV PROXYNAME localhost
ENV PROXYPORT 8080

# Max heap size
ENV XMX 64m

# Initial heap size
ENV XMS 64m

# Locale
ENV LANG_OPTS="en"
ENV REGION_OPTS="US"
ENV CODING="UTF-8"

# Add all packages
ADD packages/apache-ant-1.10.1-bin.tar.bz2 /usr/local
ADD packages/apache-tomcat-9.0.7.tar.gz /usr/local
ADD packages/apr-1.6.3.tar.gz /usr/local
ADD packages/compile.sh /usr/local/bin/
ADD packages/gosu-amd64 /usr/local/bin/gosu
ADD packages/run.sh /usr/local/bin/
ADD packages/setenv.sh $CATALINA_HOME/bin/

# Do everything
WORKDIR /usr/local/bin
RUN chmod 777 compile.sh ; chmod 777 run.sh ; ./compile.sh

# Server configuration
ADD packages/server.xml /usr/local/apache-tomcat-9.0.7/conf/server.xml
ADD packages/startup.sh /usr/local/apache-tomcat-9.0.7/bin/startup.sh

# Ports
EXPOSE 80

# Entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]

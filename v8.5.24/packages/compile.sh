#!/bin/bash

# Update and download basic packages
apt-get update && apt-get install -y build-essential libssl-dev locales

# Define locals
IFS=',' read -r -a array <<< $GENERATELOCALE

for i in "${array[@]}"
do
    locale-gen $i
done;

locale-gen

# Install Apache Ant
cd apache-ant-1.10.1 ; ant -f fetch.xml -Ddest=system ; cd ..

# Add user and group
groupadd tomcat -g $GID
useradd -r -s /sbin/nologin -u $UID -g tomcat -d /usr/local/apache-tomcat-8.5.24/ tomcat
echo "tomcat:tomcat" | chpasswd

# Install Apache Portable Runtime
cd apr-1.6.3 ; ./configure --prefix=/usr/local ; cd ..
cd apr-1.6.3 ; make ; cd ..
cd apr-1.6.3 ; make install ; cd ..
ldconfig

# Install Tomcat Native
tar -xzvf $CATALINA_HOME/bin/tomcat-native.tar.gz -C $CATALINA_HOME/bin/
cd $CATALINA_HOME/bin/tomcat-native-1.2.16-src/ ; ant ; cd ..
cd $CATALINA_HOME/bin/tomcat-native-1.2.16-src/native/ ; ./configure --with-apr=/usr/local --with-java-home=$JAVA_HOME --with-ssl=/usr/local --prefix=$CATALINA_HOME ; cd ..
cd $CATALINA_HOME/bin/tomcat-native-1.2.16-src/native/ ; make ; cd ..
cd $CATALINA_HOME/bin/tomcat-native-1.2.16-src/native/ ; make install ; cd ..
ldconfig

# Configuration of JMX
chown -R tomcat:tomcat $CATALINA_HOME
chmod 770 -R $CATALINA_HOME/webapps
chmod 600 $JMX_CONF_FOLDER/jmxremote.*
chown tomcat:tomcat $JMX_CONF_FOLDER/jmxremote.*

# Cleanup
rm -Rf /usr/local/apache-ant-1.10.1
rm -Rf /usr/local/apr-1.6.3
rm -Rf /usr/local/bin/compile.sh

#!/bin/bash

# Update and download basic packages
apt-get update && apt-get install -y build-essential libssl-dev locales authbind

# Install Apache Ant
cd apache-ant-1.10.1 ; ant -f fetch.xml -Ddest=system ; cd ..

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

# Configure port 80 with AUTHBIND
touch /etc/authbind/byport/80
chmod 500 /etc/authbind/byport/80

# Configure user and group
groupadd -g 1000 tomcat
useradd --shell /bin/bash --uid 1000 --gid 1000 tomcat

# Change ownership of apache-tomcat
chown -R tomcat:tomcat $CATALINA_HOME

# Cleanup
rm -Rf /usr/local/apache-ant-1.10.1
rm -Rf /usr/local/apr-1.6.3
rm -Rf /usr/local/bin/compile.sh

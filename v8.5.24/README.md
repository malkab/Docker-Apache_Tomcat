Apache Tomcat v8.0.18
=====================

Versions
--------
This Dockerfile compiles the following software:

- Apache Tomcat as provided by the Apache Foundation (not from packages), version __8.5.24__;

- the Apache Portable Runtime __1.6.3__, compiled from source, and enabled into Tomcat.


Usage Pattern
-------------
Build the image directly from GitHub (this can take a while):

```Shell
docker build -t="malkab/apache-tomcat:v8.5.24" .
```

or pull it from Docker Hub:

```Shell
docker pull malkab/apache-tomcat:v8.5.24
```

To start the container interactively:

```Shell
docker run -ti -p 8080:8080 --name whatever malkab/apache-tomcat:v8.5.24 /bin/bash
```

or, if JMX is wanted (by default, JMX is deactivated):

```Shell
docker run -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -e "JMX=true" --name whatever malkab/apache-tomcat:v8.5.24
```

Tomcat's output can be seen and it can be closed with CTRL-C.

See all important environmental variables affecting the virtual machine in the __Dockerfile__. They can be overriden at container's creation. For example:

```Shell
docker run --rm -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -e "JMX=true" -e "XMX=256m" -e "XMS=256m" -e "MAXPERMSIZE=1024k" malkab/apache-tomcat:v8.5.24
```


JMX
---
JMX access control are based on __packages/jmxremote.*__. They are copied to __$JAVA_HOME__. Alter them before __docker build__ or enter into the container and change them manually to change permissions.


Interesting Volumes
-------------------
By default, this image exposes no volumes, but some interesting folders to expose are:

- __$CATALINA_HOME/logs:__ Catalina logs;
- __$CATALINA_HOME/webapps:__ Catalina apps.


Environment Variables
---------------------
Tomcat user tuning:

- __GID:__ tomcat group GID;
- __UID:__ tomcat user UID.

Both defaults to 1005. This is important in case any other container is going to access Tomcat data.

Environmental variables to control this image:

- __JAVA_HOME:__ Java home. Seldom to be modified, as the JVM package installs to a fixed path;
- __JRE_HOME:__ same;
- __PATH:__ by default, adds the bins in the above paths and that of ANT;
- __LD_LIBRARY_PATH:__ defaults to _/usr/local/lib_ and to Catalina's lib;
- __ANT_HOME:__ defaults to _/usr/local/apache-ant-1.9.4_, also seldom to be modified as build path are static;
- __CATALINA_HOME:__ defaults to /usr/local/apache-tomcat-8.0.18;

JMX tuning:

- __JMX:__ true or false, (de)activates JMX access;
- __JMX_PORT:__ JMX port, defaults to _3333_;
- __JMX_HOSTNAME:__ JMX hostname, defaults to _localhost_;
- __JMX_CONF_FOLDER:__ JMX configuration folder, defaults to _$CATALINA_HOME/conf_;
- __JMX_ACCESS_FILE:__ JMX access file, defaults to _$JMX_CONF_FOLDER/jmxremote.access_;
- __JMX_PASSWORD_FILE:__ JMX access file, defaults to _$JMX_CONF_FOLDER/jmxremote.password_;

JVM tuning:

- __XMX:__ defaults to _64m_;
- __XMS:__ defaults to _64m_;
- __MAXPERMSIZE:__ defaults to _64m_.

Locale:

- __GENERATELOCALE:__ locales to generate. Defaults to _es_ES.UTF-8,es_ES.ISO-8859-1_;
- __TLOCALE:__ target locale. Defaults to _es_ES.utf8_;
- __LANG:__ target language. Defaults to _$TLOCALE_;
- __LANGUAGE:__ target language. Defaults to _es_ES:es_;
- __LC_ALL:__ LC_ALL, whatever it means. Defaults to _$TLOCALE_.

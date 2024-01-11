# Apache Tomcat v9.0.7


## Versions

This Dockerfile compiles the following software:

- Apache Tomcat as provided by the Apache Foundation (not from packages), version **9.0.7**;

- the Apache Portable Runtime **1.6.3**, compiled from source, and enabled into Tomcat.


## Usage Pattern

Build the image directly from GitHub (this can take a while):

```Shell
docker build -t="malkab/apache-tomcat:v9.0.7" .
```

or pull it from Docker Hub:

```Shell
docker pull malkab/apache-tomcat:v9.0.7
```

To start the container interactively:

```Shell
docker run -ti --rm -p 8080:80 --entrypoint /bin/bash malkab/apache-tomcat:v9.0.7
```

Tomcat's output can be seen and it can be closed with CTRL-C.


## User

The Tomcat is run by the **tomcat:tomcat** (1000:1000) user, and the **$CATALINA_HOME** folder is fully owned by this user.

This is important to interact with other containers, for example SFTP ones to add data to apps in the Tomcat.


## Configuration

This container exports **port 80**, and the Tomcat process is launched by the **root user with IDs 0:0**.

Several env variables are available:

- **XMX:** max heap size, defaults to _64m_;
- **XMS:** initial heap size, defaults to _64m_;
- **LANG_OPTS:** language for locale, defaults to _en_;
- **REGION_OPTS:** region for locale, defaults to _US_;
- **CODING:** coding for locale, defaults to _UTF-8_.

#!/bin/bash

docker run -ti --rm -p 8080:80 --entrypoint /bin/bash malkab/apache-tomcat:v9.0.7

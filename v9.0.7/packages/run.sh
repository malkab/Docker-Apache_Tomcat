#!/bin/bash

# Locale
export LOCALE="${LANG_OPTS}_${REGION_OPTS}.${CODING}"

echo $LOCALE

locale-gen $LOCALE
export LANGUAGE=$LOCALE
export LANG=$LOCALE
export LC_ALL=$LOCALE

locale

exec gosu tomcat $CATALINA_HOME/bin/catalina.sh run

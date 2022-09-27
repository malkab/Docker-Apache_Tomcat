# Custom configuration

AUTHBIND=yes

CATALINA_OPTS="-server -d64 -XX:+AggressiveOpts -Djava.library.path=/usr/local/apache-tomcat-9.0.7/lib:/usr/local/lib -Djava.awt.headless=true -XX:MaxGCPauseMillis=500 -Xmx${XMX} -Xms${XMS} -Duser.language=${LANG_OPTS} -Duser.region=${REGION_OPTS} -Djava.net.preferIPv4Stack=true"

if $PROXY ; then
    CATALINA_OPTS="${CATALINA_OPTS} -Dhttp.proxyHost=${PROXYNAME} -Dhttp.proxyPort=${PROXYPORT}"
fi

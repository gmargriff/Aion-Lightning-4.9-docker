#! /bin/bash

CUR_DIR=$(dirname $(readlink -f $0))
JAVA_HOME=$CUR_DIR/java/jdk
PATH=$PATH:$JAVA_HOME/bin

export JAVA_HOME
export PATH

for server in chatserver loginserver gameserver logger
do
    sh -c "./start_$server.sh" &
    sleep 10
done

tail -f /dev/null

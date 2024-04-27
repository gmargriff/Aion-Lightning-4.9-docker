#! /bin/bash

CUR_DIR=$(dirname $(readlink -f $0))
JAVA_HOME=$CUR_DIR/java/jdk
PATH=$PATH:$JAVA_HOME/bin

if [ -z "$SERVER_MAX_MEMORY" ]; then
    SERVER_MAX_MEMORY=4
fi

SERVER_MEMORY=$((SERVER_MAX_MEMORY*1024))

export JAVA_HOME
export PATH

cd ./AL-Game/build/dist/AL-Game
chmod +x ./StartGS.sh

./StartGS.sh $SERVER_MEMORY
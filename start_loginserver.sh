#! /bin/bash

CUR_DIR=$(dirname $(readlink -f $0))
JAVA_HOME=$CUR_DIR/java/jdk
PATH=$PATH:$JAVA_HOME/bin

export JAVA_HOME
export PATH

cd ./AL-Login/build/dist/AL-Login
chmod +x ./StartLS.sh
./StartLS.sh
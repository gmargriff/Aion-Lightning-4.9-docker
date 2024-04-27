#! /bin/bash

CUR_DIR=$(dirname $(readlink -f $0))
JAVA_HOME=$CUR_DIR/java/jdk
PATH=$PATH:$JAVA_HOME/bin

export JAVA_HOME
export PATH

for server in chatserver loginserver gameserver
do
    echo "Building $server..."
    sh -c "./build_$server.sh"
    echo "-------------------------------------------"
done

echo "Done building servers"
echo "-------------------------------------------"

exit 0
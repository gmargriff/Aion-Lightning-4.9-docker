#!/bin/bash
MAX_MEMORY=$1

if [ -z "$MAX_MEMORY" ]; then
    MAX_MEMORY=4096
fi

JAVA_OPTS="-Xms128m -Xmx${MAX_MEMORY}m -ea -XX:-UseSplitVerifier"
java  $JAVA_OPTS -javaagent:./libs/al-commons.jar -cp ./libs/*:AL-Game.jar com.aionemu.gameserver.GameServer

#!/bin/bash

java -Xms128m -Xmx4096m -ea -XX:-UseSplitVerifier -javaagent:./libs/al-commons.jar -cp ./libs/*:AL-Game.jar com.aionemu.gameserver.GameServer

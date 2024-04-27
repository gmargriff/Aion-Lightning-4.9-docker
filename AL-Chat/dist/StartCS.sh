#!/bin/sh

java -Xms8m -Xmx32m -ea -Xbootclasspath/p:./libs/jsr166-1.7.0.jar -cp ./libs/*:AL-Chat.jar com.aionemu.chatserver.ChatServer

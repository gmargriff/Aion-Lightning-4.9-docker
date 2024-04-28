#! /bin/bash

while :
do
  for SERVER in AL-Chat AL-Login AL-Game
  do
    mkdir -p /server_logs/$SERVER
    cp -r /aion/$SERVER/build/dist/$SERVER/log /server_logs/$SERVER
  done
sleep 60

done

#!/bin/bash

# TODO: use .env to set dir correctly

cd "$(dirname "$0")"

exec /usr/bin/java -Xms12G -Xmx12G \
-XX:+UseG1GC \
-XX:+ParallelRefProcEnabled \
-XX:MaxGCPauseMillis=200 \
-XX:+UnlockExperimentalVMOptions \
-XX:+DisableExplicitGC \
-XX:+AlwaysPreTouch \
-XX:G1NewSizePercent=30 \
-XX:G1MaxNewSizePercent=40 \
-XX:G1ReservePercent=20 \
-XX:InitiatingHeapOccupancyPercent=15 \
-XX:+UseStringDeduplication \
-jar server.jar nogui

#!/bin/bash

IFS=","
for v in $ZIMS
do
  if [ -f /data/$v ]; then
    echo "Downloading $v if newer"
    curl -L -o "/data/$v" -z "/data/$v" "http://download.kiwix.org/zim/$v"
  else
    echo "Downloading $v"
    curl -L -o "/data/$v" "http://download.kiwix.org/zim/$v"
  fi
  /usr/local/bin/kiwix-manage /data/library-zim.xml add /data/$v -u http://download.kiwix.org/zim/$v
done

echo "Starting server..."
exec "$@"

#!/bin/bash 

set -u -e

while true; do 
  echo '{ "schema": { "type": "struct", "optional": false, "version": 1, "fields": [ { "field": "ID", "type": "string", "optional": true }, { "field": "Artist", "type": "string", "optional": true }, { "field": "Song", "type": "string", "optional": true } ] }, "payload": { "ID": 1, "Artist": "Rick Astley", "Song": "Never Gonna Give You Up" } }'
  sleep 5
done | kafka-console-producer \
  --broker-list localhost:9092 \
  --topic test_topic_json 

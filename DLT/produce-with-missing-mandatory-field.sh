#!/bin/bash 

set -u -e

while true; do 
  echo '{ "schema": { "type": "struct", "optional": false, "version": 1, "fields": [ { "field": "ID", "type": "string", "optional": false }, { "field": "Artist", "type": "string", "optional": true }, { "field": "Song", "type": "string", "optional": true } ] }, "payload": { } }'
  sleep 5
done | kafka-console-producer \
  --broker-list localhost:9092 \
  --topic test_topic_json 

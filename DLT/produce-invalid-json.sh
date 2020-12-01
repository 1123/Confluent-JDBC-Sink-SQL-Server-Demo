#!/bin/bash 

set -u -e

while true; do 
  echo 'abc'
  sleep 5
done | kafka-console-producer \
  --broker-list localhost:9092 \
  --topic test_topic_json 

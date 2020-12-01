#!/bin/bash 

kafka-topics \
  --bootstrap-server localhost:9092 \
  --delete \
  --topic test_topic_json

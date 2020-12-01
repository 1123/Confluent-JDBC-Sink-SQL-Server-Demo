#!/bin/bash 

set -u -e

while true; do 
  echo '{"id": 999, "product": "foo", "quantity": 100, "price": 50}'
  sleep 5
done | kafka-avro-console-producer \
  --broker-list localhost:9092 \
  --topic orders \
  --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product", "type": "string"}, {"name":"quantity", "type": "int"}, {"name":"price",
 "type": "float"}]}'


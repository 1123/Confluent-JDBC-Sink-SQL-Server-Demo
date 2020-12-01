kafkacat \
  -b localhost:9092 \
  -t orders \
  -C \
  -f 'Topic: %t\nPartition: %p\nOffset: %o\nKey: %k\nPayload: %S bytes: %s\n--\n'


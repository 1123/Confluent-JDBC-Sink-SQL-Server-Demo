# Overview

This demo is based upon the following resources:

* the official Confluent documenation of the JDBC sink connector: https://docs.confluent.io/kafka-connect-jdbc/current/sink-connector/index.html
* the following blog post on Kafka Connect Converters and Serialization: https://www.confluent.io/blog/kafka-connect-deep-dive-converters-serialization-explained/S
* the following blog post on error handling in Kafka connect: https://www.confluent.io/blog/kafka-connect-deep-dive-error-handling-dead-letter-queues/

It is shown how the Kafka Connect JDBC Sink connector can be used to export data to Microsoft SQL Server running as a Docker container, and how dead letter topics can be configured to keep track of messages that could not be deserialized. 

The demo includes a simple example within the `simple` subdirectory and an example showing the dead letter topic in the `DLT` subdirectory. 

# Prerequistes

* Confluent Platform and dependencies installed
* `curl` for interacting with the Kafka Connect Rest API
* Docker for running Microsoft SQL Server
* access to dockerhub for pulling the image 
* `kafkacat` installed for looking at the messages in Kafka. 
  Alternatively this can be done using Confluent Control Center or the standard command line tools that come with Confluent Platform. 

# Running the Demo

## Setup

* start Microsoft SQL Server in docker: `./start-sql-server-in-docker.sh`
* verify that you can connect to SQL Server: `./connect-to-sql-server.sh`
* install the jdbc sink connector to your connect cluster: `./install-jdbc-sink-connector.sh`
* start Confluent Platform: `confluent local services start`. Alternatively you can also run some other Kafka cluster, a Connect Cluster and Confluent Schema Registry. 

##  Running the simple example 

The simple example writes messages in Avro format to Kafka. The Sink connector is configured to auto-create the corresponding table in Microsoft SQL Server. The connector will fail if it encounters any bad message. 

* `cd simple`
* Deploy the connector. `./post-connector.sh`
* Verify the status of the connector: `./get-connector-status.sh`
* Verify the log of the connect worker: `confluent local services connect log -f`
* Produce some sample messages with an Avro schmema: `produce-messages.sh`
* Verify that the data is written to SQL Server by connecting to SQL Server and running `select * from orders;` followed by `GO`.
* clean up: `./delete-connector.sh`

## Running the example with the Dead Letter Topic

The DLT example writes messages in Json format to Kafka. 
The Schema is included within every message. 
The connector uses the JsonConverters to extract the schema and the payload. 
Again, the sink table will be auto-created by the connector. 
Yet instead of failing upon bad messages, the connector will write the bad messages to a dead letter topic and continue processing the good messages. 

* `cd DLT`
* Deploy the connector. `./post-connector.sh`
* Verify the status of the connector: `./get-connector-status.sh`
* Verify the log of the connect worker: `confluent local services connect log -f`
* Produce some good sample messages, that the connector will be able to handle: `./produce-good-messages.sh`
* Verify that the data is writtent to SQL Server: `select count(*) from test_topic_json;` followed by `GO`.
* Verify that the dead letter topic is empty: `consume-from-dlt.sh`
* Produce some messages containing a simple String in instead of a valid JSON: `produce-invalid-json.sh`
* Produce some messages with a missing mandatory field: `produce-with-missing-mandatory-field.sh`
* Verify that the messages are written to the dead letter topic: `consume-from-dlt.sh`
* Verify that the connector is still running by producing some more good messages and looking at the results in SQL Server. 
* clean up: `./delete-connector.sh`



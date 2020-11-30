# Overview

This demo is based upon the official Confluent documenation of the JDBC sink connector. Some additions have been done to see a fully working example with Microsoft SQL Server.

# Prerequistes

* Confluent Platform and dependencies installed
* `curl` for interacting with the Kafka Connect Rest API
* docker
* access to dockerhub

# Running the Demo

* start Microsoft SQL Server in docker: `./start-sql-server-in-docker.sh`
* Verify that you can connect to SQL Server: `./connect-to-sql-server.sh`
* install the jdbc sink connector to your connect cluster: `./install-jdbc-sink-connector.sh`
* start Confluent Platform or some other Kafka cluster, Connect Cluster and Confluent Schema Registry: `confluent local services start`
* Deploy the connector. `./post-connector.sh`
* Verify the status of the connector: `./get-connector-status.sh`
* Verify the log of the connect worker: `confluent local services connect log -f`
* Produce some sample messages with an Avro schmema: `produce-messages.sh`
* Verify that the data is written to SQL Server connecting to SQL Server and running `select * from orders;` followed by `GO`.



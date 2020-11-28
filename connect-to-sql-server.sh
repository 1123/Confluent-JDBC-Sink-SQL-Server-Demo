#!/bin/bash

set -e -u 

# this assumes that only one mssql server is running in docker. 
containerId=$(docker ps | grep 'mcr.microsoft.com/mssql' | sed 's/  .*//')

docker exec \
  -it $containerId \
  /opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P 'abc123.A'

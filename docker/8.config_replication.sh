#!/bin/bash

# Configure cluster replication zones
# Requires cluster to already be initialized via 7.init_cluster.sh
# SQL is mounted into the container via ./sql:/cockroach/sql:ro (see node scripts)

docker exec -it roach1 ./cockroach sql \
  --host=roach1:26257 \
  --insecure \
  --file=/cockroach/sql/config_replication.sql

if [ $? -eq 0 ]; then
  echo "✅ Cluster Replication configured."
else
  echo "❌ Replication configuration failed."
  exit 1
fi
#!/bin/bash

# Configure cluster replication zones
# Requires cluster to already be initialized via 7.init_cluster.sh
# SQL is mounted into the container via ./sql:/cockroach/sql:ro (see node scripts)

docker exec -it roach1 ./cockroach sql \
  --host=roach1:26357 \
  --insecure \
  --file=/cockroach/sql/config_replication.sql

echo "✅ Cluster Replication configured."
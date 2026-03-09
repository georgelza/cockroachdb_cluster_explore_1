#!/bin/bash

# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach6 \
  --hostname=roach6 \
  --net=roachnet \
  -p 26262:26257 \
  -p 8085:8080 \
  -v "./data/roach6:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach6:26357 \
    --http-addr=roach6:8080 \
    --listen-addr=roach6:26357 \
    --sql-addr=roach6:26257 \
    --insecure \
    --locality=rack=3 \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

echo "✅ Node 6 deployed."
#!/bin/bash

# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach1 \
  --hostname=roach1 \
  --net=roachnet \
  -p 26257:26257 \
  -p 8080:8080 \
  -v "./data/roach1:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach1:26357 \
    --http-addr=roach1:8080 \
    --listen-addr=roach1:26357 \
    --sql-addr=roach1:26257 \
    --insecure \
    --locality=rack=1 \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

echo "✅ Node 1 deployed."
# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach4 \
  --hostname=roach4 \
  --net=roachnet \
  -p 26260:26257 \
  -p 8083:8080 \
  -v "./data/roach4:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach4:26357 \
    --http-addr=roach4:8080 \
    --listen-addr=roach4:26357 \
    --sql-addr=roach4:26257 \
    --insecure \
    --locality=CP=google,region=us-east1,zone=us-east1-b \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

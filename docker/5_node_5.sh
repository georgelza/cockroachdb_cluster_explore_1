# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach5 \
  --hostname=roach5 \
  --net=roachnet \
  -p 26261:26257 \
  -p 8084:8080 \
  -v "./data/roach5:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach5:26357 \
    --http-addr=roach5:8080 \
    --listen-addr=roach5:26357 \
    --sql-addr=roach5:26257 \
    --insecure \
    --locality=CP=google,region=us-east1,zone=us-east1-c \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

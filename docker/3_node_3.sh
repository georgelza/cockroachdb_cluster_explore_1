# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach3 \
  --hostname=roach3 \
  --net=roachnet \
  -p 26259:26257 \
  -p 8082:8080 \
  -v "./data/roach3:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach3:26357 \
    --http-addr=roach3:8080 \
    --listen-addr=roach3:26357 \
    --sql-addr=roach3:26257 \
    --insecure \
    --locality=CP=aws,region=af-south-1,zone=az3 \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker run -d \
  --name=roach2 \
  --hostname=roach2 \
  --net=roachnet \
  -p 26258:26257 \
  -p 8081:8080 \
  -v "./data/roach2:/cockroach/cockroach-data" \
  -v "./sql:/cockroach/sql:ro" \
  cockroachdb/cockroach:latest-v25.2 start \
    --advertise-addr=roach2:26357 \
    --http-addr=roach2:8080 \
    --listen-addr=roach2:26357 \
    --sql-addr=roach2:26257 \
    --insecure \
    --locality=CP=aws,region=af-south-1,zone=az2 \
    --join=roach1:26357,roach2:26357,roach3:26357,roach4:26357,roach5:26357,roach6:26357

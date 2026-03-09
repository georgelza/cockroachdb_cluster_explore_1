docker run -d \
  --name=haproxy \
  --hostname=haproxy \
  --net=roachnet \
  -p 26000:26000 \
  -p 8888:8888 \
  -v "./conf/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro" \
  haproxy:latest
  
  # docker exec -it roach1 ./cockroach sql --host=haproxy:26000 --insecure
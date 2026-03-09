docker exec -it roach1 /bin/bash

# ./cockroach sql --host=roach1:26257 --insecure < /cockroach/sql/init_db.sql
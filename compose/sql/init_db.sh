#!/bin/sh
set -e

# ── Step 1: initialise the cluster ──────────────────────────────────────────
echo ">>> Waiting for nodes to start..."
sleep 10

./cockroach init --host=roach1:26357 --insecure \
  && echo ">>> Cluster initialised." \
  || echo ">>> Init skipped (cluster already initialised)."

# ── Step 2: wait for SQL listener ───────────────────────────────────────────
echo ">>> Waiting for SQL listener..."
until ./cockroach sql --insecure --host=roach1:26257 -e "SELECT 1" > /dev/null 2>&1; do
  echo "    ...not ready, retrying in 3s"
  sleep 3
done

# ── Step 3: wait for ALL 6 nodes to be live ─────────────────────────────────
echo ">>> Waiting for all 6 nodes to join the cluster..."
until [ "$(./cockroach sql --insecure --host=roach1:26257 --format=tsv \
  -e "SELECT count(*) FROM crdb_internal.gossip_nodes WHERE is_live = true;" \
  2>/dev/null | tail -1)" = "6" ]; do
  echo "    ...not all nodes ready yet, retrying in 3s"
  sleep 3
done
echo ">>> All 6 nodes live."

# ── Step 4: apply replication zone config ───────────────────────────────────
echo ">>> Applying replication zone config (init-zone.sql)..."
./cockroach sql --insecure --host=roach1:26257 -f /cockroach/sql/init-zone.sql
echo ">>> Zone config applied."

# ── Step 5: Creating Database and ... ───────────────────────────────────────────
echo ">>> Creating Database, Schema's and Tables (using init_db.sql)..."
./cockroach sql --insecure --host=roach1:26257 -f /cockroach/sql/init_db.sql
echo ">>> Database initialised. All done."
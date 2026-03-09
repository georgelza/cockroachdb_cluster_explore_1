-- Configure cluster-wide replication zones
-- Ensures 3 replicas, 1 per rack, across rack=1, rack=2, rack=3

ALTER RANGE default CONFIGURE ZONE USING
  num_replicas = 3,
  constraints = '{"+rack=1": 1, "+rack=2": 1, "+rack=3": 1}';

ALTER RANGE meta CONFIGURE ZONE USING
  num_replicas = 3,
  constraints = '{"+rack=1": 1, "+rack=2": 1, "+rack=3": 1}';

ALTER RANGE system CONFIGURE ZONE USING
  num_replicas = 3,
  constraints = '{"+rack=1": 1, "+rack=2": 1, "+rack=3": 1}';

ALTER RANGE liveness CONFIGURE ZONE USING
  num_replicas = 3,
  constraints = '{"+rack=1": 1, "+rack=2": 1, "+rack=3": 1}';

-- Verify
SHOW ZONE CONFIGURATION FOR RANGE default;
-- init-zone.sql
--
-- Configures the default replication zone for the entire cluster.
-- Must be run once after cluster initialisation, before any tables are created.
--
-- Sets a cluster-wide replication factor of 3, with at least 1 replica
-- guaranteed on each cloud provider (CP):
--
--   +CP=aws    → roach1, roach2, roach3  (af-south-1 / az1, az2, az3)
--   +CP=google → roach4, roach5, roach6  (us-east1 / us-east1-b, us-east1-c, us-east1-d)
--
-- The 3rd replica is placed freely by CockroachDB based on diversity rules.
-- All databases, tables, and indexes inherit this zone config by default
-- unless explicitly overridden at a lower level.

ALTER RANGE default CONFIGURE ZONE USING
  num_replicas = 3,
  constraints = '{"+CP=aws": 1, "+CP=google": 1}';
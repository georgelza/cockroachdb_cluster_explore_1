-- Once connected using 8.connect.sh
-- Execute the below commands in the sql window to create a database, and some tables with data.
---
CREATE DATABASE IF NOT EXISTS  bank;
CREATE TABLE IF NOT EXISTS bank.accounts (id INT PRIMARY KEY, balance DECIMAL);
INSERT INTO bank.accounts VALUES (1, 1020.50) ON CONFLICT (id) DO NOTHING;
INSERT INTO bank.accounts VALUES (2, 1400.50) ON CONFLICT (id) DO NOTHING;
INSERT INTO bank.accounts VALUES (3, 4030.50) ON CONFLICT (id) DO NOTHING;
INSERT INTO bank.accounts VALUES (4, 10000.50) ON CONFLICT (id) DO NOTHING;
SELECT * FROM bank.accounts;

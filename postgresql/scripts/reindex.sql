CREATE DATABASE reindex_test;
\c reindex_test
CREATE EXTENSION pgstattuple;

CREATE TABLE test_table (id serial primary key, value integer);
CREATE INDEX test_index ON test_table (value);
ALTER TABLE test_table SET (autovacuum_enabled = false, toast.autovacuum_enabled = false);

INSERT INTO test_table (value) SELECT floor(random()*1000000)::integer FROM generate_series(1, 10000000);
CREATE DATABASE pocdb;
\c pocdb

CREATE TABLE backuptest(
  id        integer
);

INSERT INTO backuptest VALUES (1);
INSERT INTO backuptest VALUES (2);
INSERT INTO backuptest VALUES (3);
INSERT INTO backuptest VALUES (4);
INSERT INTO backuptest VALUES (5);
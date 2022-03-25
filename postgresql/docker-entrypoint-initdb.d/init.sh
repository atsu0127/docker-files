set -e
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
CREATE TABLE backuptest(
  id        integer
);
EOSQL

for i in {1..30}
do
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
INSERT INTO backuptest VALUES (${i});
EOSQL
done

## reindex

reindexの効果を確認します

```bash
su - postgres
## 初期データ作成
psql -f /init/reindex.sql

## 確認
psql reindex_test
SELECT pg_get_indexdef((SELECT oid FROM pg_class WHERE relname = 'test_index'));
\d test_table
\di test_index

## 肥大化の確認
SELECT * FROM pgstattuple('test_index');

## SQLの実行時間の確認
EXPLAIN ANALYZE SELECT * FROM test_table WHERE value BETWEEN 500000 AND 500100 ORDER BY value;

## 索引を肥大化させる
DELETE FROM test_table WHERE id % 2 = 0;
UPDATE test_table SET value = floor(random()*1000000)::integer;

## 肥大化の確認
SELECT * FROM pgstattuple('test_index');

## SQLの実行時間の確認
EXPLAIN ANALYZE SELECT * FROM test_table WHERE value BETWEEN 500000 AND 500100 ORDER BY value;

## reindex実行
REINDEX (VERBOSE) INDEX test_index;

## 索引の確認
\d test_table
\di test_index

## 肥大化の確認
SELECT * FROM pgstattuple('test_index');

## SQLの実行時間の確認
EXPLAIN ANALYZE SELECT * FROM test_table WHERE value BETWEEN 500000 AND 500100 ORDER BY value;
```
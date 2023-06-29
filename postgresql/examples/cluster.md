## Cluster化

Cluster化の効果を確認します

```bash
## 初期データ作成
psql -f /init/cluster.sql

## 確認
psql cluster_test
\d orders
\di order_date_index
select count(*) from orders;

## クラスタ化前の確認
SELECT tablename, attname, correlation FROM pg_stats WHERE tablename = 'orders';
EXPLAIN ANALYZE SELECT * FROM orders WHERE order_date BETWEEN '2022-01-01' AND '2022-01-31';

## クラスタ化
CLUSTER VERBOSE orders USING order_date_index;
ANALYZE VERBOSE orders;

## クラスタ化後の確認
SELECT tablename, attname, correlation FROM pg_stats WHERE tablename = 'orders';
EXPLAIN ANALYZE SELECT * FROM orders WHERE order_date BETWEEN '2022-01-01' AND '2022-01-31';
```
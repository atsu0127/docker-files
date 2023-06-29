CREATE DATABASE cluster_test;
\c cluster_test

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL
);

DO $$
DECLARE
  i INT;
BEGIN
  i := 1;
  WHILE i <= 1000000 LOOP
    INSERT INTO orders (customer_id, order_date)
    VALUES (
      (RANDOM() * 100)::INT, -- ランダムな顧客IDを生成
      TIMESTAMP '2022-01-01' + ((RANDOM() * 365)::int * '1 day'::interval) -- ランダムな注文日を生成
    );
    i := i + 1;
  END LOOP;
END $$;

CREATE INDEX order_date_index ON orders (order_date);
ANALYZE VERBOSE orders;
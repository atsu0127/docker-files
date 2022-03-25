## PITR

以下 LSN での PITR の方法をざっと書きます

まずはベースバックアップ取得

```bash
## 初期状態確認
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
SELECT * from backuptest;
EOSQL

## 取得
export NOW=`date +%y%m%d_%H%M%S`
pg_basebackup \
-D /tmp/postgresql/backup/${NOW} \
-F t \
-z -P -v

## 確認
ls -l /tmp/postgresql/backup/${NOW}
```

データの更新する

```bash
## 更新前のアーカイブログ
ls -l /tmp/postgresql/archives/

## 更新実施
for i in `seq 6 1 30`
do
[[ "${i}" == 15 ]] && sleep 45
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
INSERT INTO backuptest VALUES (${i});
EOSQL
done

## 更新後のアーカイブログ
ls -l /tmp/postgresql/archives/

## 確認
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
SELECT * from backuptest;
EOSQL
```

障害起こす

```bash
## DB止める
pg_ctl stop -D ${PGDATA}

## dataを消す
cd ${PGDATA}/..
mv data data_bak
ls -l
```

PITR する

```bash
## ファイルのリストア
cd /var/lib/pgsql/13/
mkdir -m 750 data
cp /tmp/postgresql/backup/${NOW}/base.tar.gz ./data/
cd data
tar xvf base.tar.gz > /dev/null
rm -r base.tar.gz
ls -l

## 戻したいLSNをチェック
pg_waldump /tmp/postgresql/archives/<それっぽいwal>

## 設定変更してシグナル配置
vi /etc/postgresql/postgresql.conf
touch $PGDATA/recovery.signal

## リカバリ
pg_ctl -D ${PGDATA} start "-o -c config_file=/etc/postgresql/postgresql.conf"

## 確認
PGPASSWORD=postgres psql -U postgres pocdb << EOSQL
SELECT * from backuptest;
EOSQL

## 設定戻して再起動(不要かな)
vi /etc/postgresql/postgresql.conf
pg_ctl -D ${PGDATA} restart "-o -c config_file=/etc/postgresql/postgresql.conf"
```

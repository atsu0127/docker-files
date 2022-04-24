# enq: TX - row lock contention

これは待機イベント`enq: TX - row lock contention`が発生したときに、その原因特定の方法を記載しています。

`WAITEVENT: "enq: TX - row lock contention" Reference Note (Doc ID 1966048.1)`と[こちらのサイト](https://www.ex-em.co.jp/blog/enq-tx-row-lock-contention/)を参考にしています。

特に SQL はほぼそのまま記載させていただいています。

## 手順

もっとも単純な行の更新の競合の場合をやってみます。

`待機発生 → 原因のセッション特定 →kill`、までを行います

### 1. 下準備

```sql
-- 表作ってデータ入れる
DROP TABLE TARGET;
CREATE TABLE TARGET (
    id NUMBER(10),
    name VARCHAR2(100),
    primary key (id)
);

INSERT INTO TARGET VALUES (1, 'aaa');
INSERT INTO TARGET VALUES (2, 'bbb');
INSERT INTO TARGET VALUES (3, 'ccc');

col NAME for a30
set lines 180 pages 999
desc TARGET
select * from TARGET;

-- commitしておく
commit;
```

### 2. 競合してみる

- ロック取る方

```sql
-- セッション確認
SELECT SYS_CONTEXT('USERENV', 'SID')  FROM DUAL;

-- update流しとく
update TARGET set NAME = 'changed' where ID = 1;
```

- ロック取られる方(待つ方)

```sql
-- セッション確認
SELECT SYS_CONTEXT('USERENV', 'SID')  FROM DUAL;

-- update流してみる
update TARGET set NAME = 'changed_locked!!' where ID = 1;
-- ...waiting...
```

### 3. 競合解消と確認

- ロックしているセッションの特定 & kill(ロック持っている方を kill)

```sql
-- 待機しているセッション出す
col TX for a30
set lines 180
SELECT
   sid, seq#, state, seconds_in_wait,
   'TX-'||lpad(ltrim(p2raw,'0'),8,'0')||'-'||lpad(ltrim(p3raw,'0'),8,'0') TX,
   trunc(p2/65536)      XIDUSN,
   trunc(mod(p2,65536)) XIDSLOT,
   p3                   XIDSQN
  FROM v$session_wait
 WHERE event='enq: TX - row lock contention'
;

-- ブロッキングセッション(待機させてるセッション)出す
-- 以下のクエリのREQUESTが6(排他)や4(共有)で待っているのが待機セッション
-- LMODEが6や4なのがブロッキングセッション
SELECT distinct w.tx, l.inst_id, l.sid, l.lmode, l.request
 FROM
  ( SELECT p2,p3,
     'TX-'||lpad(ltrim(p2raw,'0'),8,'0')||'-'||lpad(ltrim(p3raw,'0'),8,'0') TX
      FROM v$session_wait
     WHERE event='enq: TX - row lock contention'
       and state='WAITING'
  ) W,
  gv$lock L
 WHERE l.type(+)='TX'
   and l.id1(+)=w.p2
   and l.id2(+)=w.p3
 ORDER BY tx, lmode desc, request desc
;

-- killコマンド生成
select 'ALTER SYSTEM KILL SESSION ''' || inst_id || ', ' || sid || ', ' || serial# || ''' IMMEDIATE;' AS command
from gv$session where sid =&sid;

-- killする
ALTER SYSTEM KILL SESSION '<INST_ID>, <SID>, <SERIAL#>' FORCE;
```

- 確認

```sql
-- ロックとっていた方はもう繋がらない
SQL> select * from TARGET;
select * from TARGET
       *
ERROR at line 1:
ORA-03113: end-of-file on communication channel
Process ID: 388184
Session ID: 22869 Serial number: 11274

-- ロック待っていた方は成功している
SQL> update TARGET set NAME = 'changed_locked!!' where ID = 1;

1 row updated.

-- データも更新されてる
SQL> col NAME for a30
set lines 180 pages 999
select * from TARGET;

        ID NAME
---------- ------------------------------
         1 changed_locked!!
         2 bbb
         3 ccc
```

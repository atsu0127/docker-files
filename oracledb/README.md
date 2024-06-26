# oracledb

23c 検証用の Docker 環境

## 内容

以下の container が作成されます

- oracledb…Oracle Database 23c Free
- ords

### docker-compose について

- oracledb
  - healthcheck 用のファイルをマウントしています
- ords
  - oracledb の sys ユーザにアクセスできるようになったらコンテナ実行するようにします
  - Started になった後に ords の install & 起動があるので、log を確認してお待ちください
  - 以下の文言が出力されたら`http://localhost:8080/ords/sql-developer`にアクセスして利用開始できます
    - ユーザは pdbadmin、パスワードは oracle です。
    - または目的ごとに以下のユーザがいます
      - jrd/welcome1…`JSON Relation Duality`の検証用
      - js_developer/welcome1…`Javascript In MLE`の検証用

```bash
ORDS has been successfully configured.
```

## 手順

- [JSON Relation Duality](./JsonRelationDuality.md)
  - source: https://qiita.com/takuya_0301/items/d56628e22cdba8b222ed

## 参考

- https://qiita.com/satokaz/items/bd2e9514c3dbc2d8f313
- https://docs.oracle.com/cd/F87063_01/ordig/installing-and-configuring-oracle-rest-data-services.html

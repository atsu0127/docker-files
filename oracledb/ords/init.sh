#!/bin/bash

set -eu -o pipefail

# ログファイルのパス設定
LOG_FILE="/ords_installation.log"
touch $LOG_FILE

# ORDSの設定と起動、ログファイルに出力
ords --config /etc/ords/config install << EOF 2>&1 | tee $LOG_FILE &
2
1
oracledb
1521
freepdb1
sys
oracle
SYSAUX
TEMP
1
1
1
8080
EOF

# ログファイルの監視
# 起動完了のログメッセージが出るまで待機
set +o pipefail
tail -f $LOG_FILE | grep -q "Completed installation for Oracle REST Data Services"
set -o pipefail

# ログメッセージが見つかった後に実行するコマンド
echo "ORDS has been successfully started."

# setting pdb
echo "Grant pdbadmin"
sqlplus sys/oracle@oracledb:1521/freepdb1 as sysdba << EOF
GRANT DBA TO pdbadmin CONTAINER=CURRENT;
GRANT inherit privileges on user pdbadmin to ORDS_METADATA;
exit;
EOF

echo "Enable ords"
sqlplus pdbadmin/oracle@oracledb:1521/freepdb1 << EOF
BEGIN
    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'pdbadmin',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'pdbadmin',
                       p_auto_rest_auth => FALSE);

    commit;
END;
/
exit;
EOF

echo "ORDS has been successfully configured."

tail -f /dev/null
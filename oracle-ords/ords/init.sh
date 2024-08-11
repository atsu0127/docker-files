#!/bin/bash

set -eu -o pipefail

# ログファイルのパス設定
LOG_FILE="/ords_installation.log"
touch $LOG_FILE

echo "wait for db in 30sec(start at $(date))"
sleep 30

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

echo "create jrd user"
sqlplus sys/oracle@oracledb:1521/freepdb1 as sysdba << EOF
CREATE USER JRD IDENTIFIED BY "welcome1" DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
GRANT DBA TO JRD;
GRANT UNLIMITED TABLESPACE TO JRD;
GRANT CTXAPP TO JRD;
GRANT RESOURCE TO JRD;
exit;
EOF

echo "enable ords in jrd user"
sqlplus jrd/welcome1@oracledb:1521/freepdb1 << EOF
select role from session_roles;
BEGIN
    ORDS.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'JRD',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'jrd',
        p_auto_rest_auth=> TRUE
    );
    commit;
END;
/
exit;
EOF

echo "create js_developer user"
sqlplus sys/oracle@oracledb:1521/freepdb1 as sysdba << EOF
CREATE USER js_developer IDENTIFIED BY "welcome1" DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
grant EXECUTE on javascript to js_developer;
grant EXECUTE DYNAMIC MLE to js_developer;
grant DB_DEVELOPER_ROLE to js_developer;
grant create session to js_developer;
grant CREATE ANY DIRECTORY to js_developer;
GRANT UNLIMITED TABLESPACE TO JRD;
exit;
EOF

echo "enable ords in js_developer user"
sqlplus js_developer/welcome1@oracledb:1521/freepdb1 << EOF
select role from session_roles;
BEGIN
    ORDS.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'JS_DEVELOPER',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'js_developer',
        p_auto_rest_auth=> TRUE
    );
    commit;
END;
/
exit;
EOF

echo "ORDS has been successfully configured."

tail -f /dev/null
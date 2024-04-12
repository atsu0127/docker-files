#!/bin/bash

set -eu

sqlplus /nolog << EOF && ret=0 || ret=$?
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
WHENEVER OSERROR EXIT FAILURE ROLLBACK
CONNECT sys/oracle@oracledb:1521/freepdb1 as sysdba
EXIT SUCCESS;
EOF

exit $ret
